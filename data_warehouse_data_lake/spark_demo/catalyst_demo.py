from pyspark.sql import SparkSession
from pyspark.sql.functions import *

# Create a SparkSession
spark = SparkSession.builder.appName("CatalystDemo").getOrCreate()

# Generate some sample data
num_rows = 1000000
data = [(i, i * 2, i % 10, i % 100, i % 1000) for i in range(num_rows)]
df = spark.createDataFrame(data, ["A", "B", "C", "D", "E"])

# Add some random data to the DataFrame
df = df.withColumn("F", rand())

# Apply the filters to the DataFrame
filtered_df = df.filter(col("A") > 100).filter(col("B") < 50).filter(col("C").between(10, 20))

# Perform some aggregation on the filtered data
result = filtered_df.groupBy("D").agg({"E": "sum", "F": "avg"})

# Show the result
result.show()