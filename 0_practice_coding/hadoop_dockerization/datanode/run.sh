#!/bin/bash

# start ssh server
/etc/init.d/ssh start

# start datanode
$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR datanode
