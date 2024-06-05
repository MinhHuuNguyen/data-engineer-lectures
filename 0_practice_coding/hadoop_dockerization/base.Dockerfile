# Reference:
# https://phpfog.com/creating-hadoop-docker-image/
# https://phoenixnap.com/kb/install-hadoop-ubuntu

FROM ubuntu:20.04

RUN apt update

# 1. Install JAVA - OpenJDK 8
RUN apt install openjdk-8-jdk -y

# 2. Install SSH - OpenSSH
RUN apt install openssh-server openssh-client -y

# 3. Create SSH keys
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys

# 4. Install Hadoop
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz
RUN tar -xzf hadoop-3.3.5.tar.gz

# 5. Install Python libraries
RUN apt-get update
RUN apt-get install python3-pip -y
RUN pip3 install pathlib mrjob pyyaml

# 6. Set environment variables (in ~/.bashrc)
ENV HADOOP_HOME=/hadoop-3.3.5
ENV HADOOP_INSTALL=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"

ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

# 7. Edit core-site.xml, hdfs-site.xml, mapred-site.xml, yarn-site.xml, hadoop-env.sh
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
COPY custom_config_files/core-site.xml $HADOOP_CONF_DIR/core-site.xml
COPY custom_config_files/hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY custom_config_files/mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml
COPY custom_config_files/yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml
COPY custom_config_files/hadoop-env.sh $HADOOP_CONF_DIR/hadoop-env.sh
