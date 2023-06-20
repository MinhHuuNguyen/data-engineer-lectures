from pyspark.sql import SparkSession

# Create a SparkSession
spark = SparkSession.builder.appName("MovieAnalysis").getOrCreate()

# Read the movie data
movie_data = spark.read.format("csv").option("header", False).option("delimiter", ",").load("hdfs://namenode:9000/input/movies_data/u_2.item")

# Define the schema for the movie data
from pyspark.sql.types import StructType, StructField, IntegerType, StringType
movie_schema = StructType([
    StructField("movie_id", IntegerType(), True),
    StructField("title", StringType(), True),
    StructField("release_date", StringType(), True),
    StructField("video_release_date", StringType(), True),
    StructField("imdb_url", StringType(), True),
    StructField("unknown", IntegerType(), True),
    StructField("action", IntegerType(), True),
    # Add more genre fields here...
])

# Apply the schema to the movie data
movie_df = movie_data.toDF(*movie_schema.fieldNames())

# Show the first few rows of the movie data
movie_df.show()

# Perform analysis or computations on the movie data using PySpark functions and APIs
# Here are a few examples:

# Count the number of movies
num_movies = movie_df.count()
print("----------------Total number of movies:", num_movies)

# Calculate the average release year
from pyspark.sql.functions import substring
average_release_year = movie_df.select(substring("release_date", -4, 4).cast(IntegerType()).alias("year")).agg({"year": "avg"}).collect()[0][0]
print("----------------Average release year:", average_release_year)


# Perform more analysis or computations as per your requirements

# Stop the SparkSession
spark.stop()
