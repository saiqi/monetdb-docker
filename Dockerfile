FROM monetdb/monetdb-r-docker:july2017-sp4

RUN yum remove -y numpy

RUN curl https://bootstrap.pypa.io/get-pip.py | python -

RUN pip install numpy==1.14.2 pandas==0.22.0 scikit-learn==0.19.1 scipy==1.0.0