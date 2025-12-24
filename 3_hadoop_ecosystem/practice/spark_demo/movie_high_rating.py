import time
from pyspark.sql import SparkSession


def mapper_get_ratings(line):
    # 0	50	5	881250949
    (user_id, movie_id, rating, timestamp) = line.split('\t')
    return movie_id, (float(rating), 1)


if __name__ == "__main__":
    spark = SparkSession.builder.appName("HighRatingMovies").getOrCreate()
    sc = spark.sparkContext

    input_path = "hdfs:///movie_rating_dataset/movie_data.txt"
    output_path = "hdfs:///movie_rating_dataset_output/highest_rated_movies_output_" + str(int(time.time()))

    # Load the movie ratings data from a text file
    # lines = sc.textFile("../hadoop_demo/mapreduce_data/movie_rating_dataset/movie_data.txt")
    lines = sc.textFile(input_path)
    # Use the mapper function to parse and extract ratings data, creating key-value pairs
    movie_ratings = lines.map(mapper_get_ratings)
    print('movie_ratings', movie_ratings.take(10))

    # Reduce by key to calculate the total rating and the count of ratings for each movie
    rating_totals_and_count = movie_ratings.reduceByKey(
        lambda movie_1, movie_2: (movie_1[0] + movie_2[0], movie_1[1] + movie_2[1])
    )
    print('rating_totals_and_count', rating_totals_and_count.take(10))

    # Calculate the average rating for each movie
    average_ratings = rating_totals_and_count.mapValues(
        lambda total_and_count: total_and_count[0] / total_and_count[1]
    )
    print('average_ratings', average_ratings.take(10))

    # Sort the movies by average rating in descending order
    sorted_movies = average_ratings.sortBy(lambda x: x[1], ascending=False)
    print('sorted_movies', sorted_movies.take(10))

    # Take the top 10 movies with the highest average rating and print the results
    results = sorted_movies.take(10)
    for result in results:
        print(result)

    sorted_movies.saveAsTextFile(output_path)

    # Stop the SparkContext to release resources
    sc.stop()
