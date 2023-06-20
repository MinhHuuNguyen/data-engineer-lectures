FROM jiroakira/hadoop-base:1.0.6-hadoop3.3.4-java11

HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

RUN pip3 install pathlib mrjob pyyaml

ADD run.sh /run.sh
RUN chmod a+x /run.sh


EXPOSE 9864

CMD ["/run.sh"]
