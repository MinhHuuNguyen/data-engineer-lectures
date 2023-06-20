# FROM docker.io/bitnami/spark:3
FROM bde2020/spark-master:3.3.0-hadoop3.3

ENV PYTHONUNBUFFERED=1
RUN apk --update --upgrade add gcc musl-dev jpeg-dev zlib-dev libffi-dev cairo-dev pango-dev gdk-pixbuf-dev python3-dev py3-setuptools
# RUN apk add gcc libc-dev libffi-dev

RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools && pip3 install jupyter

# RUN mv ../spark opt

ENV SPARK_HOME=/spark
ENV PATH=$PATH:$SPARK_HOME/bin
ENV PYSPARK_PYTHON=/usr/bin/python3.7
ENV PYSPARK_DRIVER_PYTHON="jupyter"
ENV PYSPARK_DRIVER_PYTHON_OPTS="notebook  --ip='*' --port=8888 --allow-root"

COPY jars/kafka-clients-3.3.0.jar $SPARK_HOME/jars 
COPY jars/spark-sql-kafka-0-10_2.12-3.3.0.jar $SPARK_HOME/jars 
COPY jars/spark-streaming-kafka-0-10_2.12-3.3.0.jar $SPARK_HOME/jars
COPY jars/commons-pool2-2.11.0.jar $SPARK_HOME/jars
COPY jars/spark-token-provider-kafka-0-10_2.12-3.3.0.jar $SPARK_HOME/jars 

EXPOSE 8888