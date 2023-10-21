#!/bin/bash

# start ssh server
/etc/init.d/ssh start

#!/bin/bash
$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR nodemanager
