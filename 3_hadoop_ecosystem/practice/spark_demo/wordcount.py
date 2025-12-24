import time
from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("spark-wordcount-big5M").getOrCreate()
sc = spark.sparkContext

input_path = "hdfs:///wordcount_dataset/big_5M.txt"
output_path = "hdfs:///wordcount_spark_output/big_5M_wc_output_" + str(int(time.time()))

rdd = sc.textFile(input_path)

counts = (rdd.flatMap(lambda line: line.split())
            .map(lambda w: (w.lower(), 1))
            .reduceByKey(lambda a, b: a + b))

counts.saveAsTextFile(output_path)

spark.stop()