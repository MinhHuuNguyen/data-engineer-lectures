from pyspark.sql import SparkSession


# Define Kafka parameters
IP = '172.21.0.6'  # Thay bằng IP của container Kafka
KAFKA_BOOTSTRAP_SERVERS = f"{IP}:9092"
KAFKA_TOPIC = "movie_data_topic"


# Create a Spark session
spark = SparkSession.builder \
    .appName("KafkaConsumerExample") \
    .config("spark.jars.packages", "org.apache.spark:spark-sql-kafka-0-10_2.13:4.1.0") \
    .getOrCreate()

print("Spark:", spark.version)
print("Scala:", spark.sparkContext._jvm.scala.util.Properties.versionNumberString())


# Define the input DataFrame with the Kafka source
df = spark \
    .readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers", KAFKA_BOOTSTRAP_SERVERS) \
    .option("subscribe", KAFKA_TOPIC) \
    .load()

# Convert the value column from Kafka message into a string
value_str = df.selectExpr("CAST(value AS STRING)")

# Output the results to the console (for testing purposes)
query = value_str \
    .writeStream \
    .outputMode("append") \
    .format("console") \
    .start()
# outputMode can be "append", "complete", "update"
# format can be "console", "memory", "parquet", "csv", "text", "orc", "json", "kafka" ...

# # Write the results to a Kafka topic
# query = value_str \
#     .writeStream \
#     .outputMode("append") \
#     .format("kafka") \
#     .option("kafka.bootstrap.servers", KAFKA_BOOTSTRAP_SERVERS) \
#     .option("topic", "second_topic") \
#     .option("checkpointLocation", "kafka_checkpoint") \
#     .start()

# Wait for the streaming query to finish
query.awaitTermination()
