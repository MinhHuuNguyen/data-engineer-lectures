#!/bin/bash

# start ssh server
/etc/init.d/ssh start

# format namenode
$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format $CLUSTER_NAME

# start namenode
$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode
