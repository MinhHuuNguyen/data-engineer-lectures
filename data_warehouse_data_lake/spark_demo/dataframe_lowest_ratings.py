from pyspark.sql import SparkSession
from pyspark.sql.functions import *

spark = SparkSession.builder.appName("MovieLowestRatings").getOrCreate()

movie_data = spark.read.format("csv").option("header", False).option("delimiter", ",").option("inferSchema", True).load("hdfs://namenode:9000/input/movies_data/u_2.item") 

ratings_data = spark.read.format("csv").option("header", False).option("delimiter", "\t").load("hdfs://namenode:9000/input/movies_data/u.data")

from pyspark.sql.types import StructType, StructField, IntegerType, StringType

movie_schema = StructType([
    StructField("movie_id", IntegerType(), True),
    StructField("title", StringType(), True),
    StructField("release_date", StringType(), True),
    StructField("video_release_date", StringType(), True),
    StructField("imdb_url", StringType(), True),
    StructField("unknown", IntegerType(), True),
    StructField("action", IntegerType(), True)
])

ratings_schema = StructType([
    StructField("user_id", IntegerType(), True),
    StructField("movie_id", IntegerType(), True),
    StructField("ratings", IntegerType(), True),
    StructField("timestamp", IntegerType(), True)
])

# Apply schema to the movie data and ratings data
movie_df = movie_data.toDF(*movie_schema.fieldNames())
ratings_df = ratings_data.toDF(*ratings_schema.fieldNames())

# calculate average ratings per movie
average_ratings = ratings_df.groupBy("movie_id").agg(avg("ratings").alias("avg_ratings"))

movie_ratings = movie_df.join(average_ratings, "movie_id").select("title", "avg_ratings")

lowest_rated_movie = movie_ratings.orderBy("avg_ratings", ascending=True).first()

print(f"Title: {lowest_rated_movie['title']}")
print(f"Average Ratings: {lowest_rated_movie['avg_ratings']}")

spark.stop()