from pyspark.sql import SparkSession

from movie_high_rating_with_sql import sort_movie_high_rating


spark = SparkSession.builder.appName("MovieHighestRatings").getOrCreate()
sorted_rated_movie = sort_movie_high_rating(spark)

# Display the execution plan
sorted_rated_movie.explain()

# Access and print the analyzed logical plan
analyzed_logical_plan = sorted_rated_movie._jdf.queryExecution().analyzed()
print("\nAnalyzed Logical Plan:")
print(analyzed_logical_plan.numberedTreeString())

# Access and print the optimized logical plan
optimized_logical_plan = sorted_rated_movie._jdf.queryExecution().optimizedPlan()
print("\nOptimized Logical Plan:")
print(optimized_logical_plan.numberedTreeString())

# Access and print the physical plan
physical_plan = sorted_rated_movie._jdf.queryExecution().executedPlan()
print("\nPhysical Plan:")
print(physical_plan.numberedTreeString())

spark.stop()
