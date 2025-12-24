from pyspark.ml.regression import LinearRegression
from pyspark.ml.feature import VectorAssembler
from pyspark import SparkConf, SparkContext
from pyspark.sql import SparkSession


def mapper_get_ratings(line):
    # 0	50	5	881250949
    (user_id, movie_id, rating, timestamp) = line.split('\t')
    return int(movie_id), (float(rating), 1)


if __name__ == "__main__":
    conf = SparkConf().setAppName("MovieRatingPrediction")
    sc = SparkContext(conf=conf)
    spark = SparkSession(sc)

    # Load the movie ratings data from a text file
    lines = sc.textFile("../hadoop_demo/mapreduce_data/movie_rating_dataset/movie_data.txt")
    # lines = sc.textFile("hdfs://namenode:9000/movie_data.txt")

    # Use the mapper function to parse and extract ratings data, creating key-value pairs
    movie_ratings = lines.map(mapper_get_ratings)

    # Reduce by key to calculate the total rating and the count of ratings for each movie
    rating_totals_and_count = movie_ratings.reduceByKey(
        lambda movie_1, movie_2: (movie_1[0] + movie_2[0], movie_1[1] + movie_2[1])
    )

    # Calculate the average rating for each movie
    average_ratings = rating_totals_and_count.mapValues(
        lambda total_and_count: total_and_count[0] / total_and_count[1]
    )

    # Create a DataFrame from the raw ratings
    ratings_df = spark.createDataFrame(average_ratings, ["item", "rating"])

    # Convert the "item" column to a feature vector
    assembler = VectorAssembler(inputCols=["item"], outputCol="features")
    ratings_df = assembler.transform(ratings_df)
    # ratings_df.show()

    # Split the data into training and test sets (not required for simple demonstration)
    train_data, test_data = ratings_df.randomSplit([0.8, 0.2])
    train_data.show()
    test_data.show()

    # Create a Linear Regression model
    lr = LinearRegression(featuresCol="features", labelCol="rating")

    # Fit the model to the training data
    lr_model = lr.fit(train_data)

    # Make predictions on the test data (not required for simple demonstration)
    predictions = lr_model.transform(test_data)

    # Show the predicted ratings
    predictions.show()

    # Stop the SparkSession and SparkContext when you're done
    spark.stop()
    sc.stop()
