from pyspark.sql import SparkSession
from pyspark.sql.functions import *

# Create a SparkSession
spark = SparkSession.builder.appName("CommonFunctionsExample").getOrCreate()

# Read data from a CSV file
data = spark.read.format("csv").option("header", True).load("path/to/data.csv")

# Show the first few rows of the DataFrame
data.show()

# Select specific columns
selected_data = data.select("column1", "column2")

# Filter rows based on a condition
filtered_data = data.filter(col("column1") > 10)

# Group by a column and perform aggregation
aggregated_data = data.groupBy("column1").agg(avg("column2"), sum("column3"))

# Join two DataFrames
df1 = spark.createDataFrame([(1, "John"), (2, "Jane")], ["id", "name"])
df2 = spark.createDataFrame([(1, 25), (2, 30)], ["id", "age"])
joined_data = df1.join(df2, "id")

# Sort the DataFrame by a column
sorted_data = data.sort("column1")

# Perform a union of two DataFrames
df3 = spark.createDataFrame([(3, "Mike"), (4, "Emily")], ["id", "name"])
union_data = df1.union(df3)

# Rename columns
renamed_data = data.withColumnRenamed("column1", "new_column1")

# Perform a distinct operation
distinct_data = data.distinct()

# Calculate descriptive statistics
statistics = data.describe()

# Save the DataFrame as a Parquet file
data.write.format("parquet").mode("overwrite").save("path/to/save/parquet")

# Stop the SparkSession
spark.stop()
