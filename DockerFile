FROM debian:jessie

RUN groupadd -r monetdb && useradd -r -g monetdb monetdb

EXPOSE 50000

RUN apt-get update && apt-get install -y wget apt-transport-https
RUN wget --no-check-certificate --output-document=- https://www.monetdb.org/downloads/MonetDB-GPG-KEY | apt-key add -

COPY configs/monetdb.list /etc/apt/sources.list.d/monetdb.list

RUN apt-get update && apt-get install -y \
	monetdb5-sql \
	monetdb-client \
	monetdb-python2

RUN mkdir -p /var/log/monetdb

RUN chown -R monetdb:monetdb /var/monetdb5 /var/log/monetdb

COPY scripts/set-monetdb-password.sh /home/monetdb/set-monetdb-password.sh
COPY configs/.monetdb /home/monetdb/.monetdb
COPY scripts/init-db.sh /home/monetdb/init-db.sh

RUN chmod +x /home/monetdb/set-monetdb-password.sh
RUN chmod +x /home/monetdb/init-db.sh

ENTRYPOINT [ "/home/monetdb/init-db.sh" ]

CMD ["monetdb", "start", "db"]

VOLUME /var/monetdb5/dbfarm

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*