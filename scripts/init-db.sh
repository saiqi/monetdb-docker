#!/bin/bash

monetdbd start /var/monetdb5/dbfarm

sleep 5
if [ ! -d "/var/monetdb5/dbfarm/db" ]; then
    monetdb create db && \
    monetdb set embedr=true db && \
    monetdb release db
else
    echo "Existing database found in '/var/monetdb5/dbfarm/db'"
fi

echo "Initialization done"