from pyspark.sql.functions import *
from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, IntegerType, StringType


def sort_movie_high_rating(spark):

    # movie_data = spark.read.options(header=False, delimiter=",", inferSchema=True).csv(
    #     "hdfs://namenode:9000/movie_item.txt"
    # )
    # ratings_data = spark.read.options(header=False, delimiter="\t", inferSchema=True).csv(
    #     "hdfs://namenode:9000/movie_data.txt"
    # )

    movie_data = spark.read.options(header=False, delimiter=",", inferSchema=True).csv(
        "../hadoop_demo/mapreduce_data/movie_rating_dataset/movie_item.txt"
    )
    ratings_data = spark.read.options(header=False, delimiter="\t", inferSchema=True).csv(
        "../hadoop_demo/mapreduce_data/movie_rating_dataset/movie_data.txt"
    )

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
    sorted_rated_movie = movie_ratings.orderBy("avg_ratings", ascending=False)
    return sorted_rated_movie


def get_movie_high_rating(sorted_rated_movie):
    highest_rated_movie = sorted_rated_movie.first()
    print(f"Title: {highest_rated_movie['title']}")
    print(f"Average Ratings: {highest_rated_movie['avg_ratings']}")
    return highest_rated_movie


if __name__ == "__main__":
    spark = SparkSession.builder.appName("MovieHighestRatings").getOrCreate()

    get_movie_high_rating(sort_movie_high_rating(spark))

    spark.stop()
