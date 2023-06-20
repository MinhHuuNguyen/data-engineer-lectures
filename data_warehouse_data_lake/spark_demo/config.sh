#!/bin/bash

mv ../spark opt

export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin
export PYSPARK_PYTHON=/usr/bin/python3.7