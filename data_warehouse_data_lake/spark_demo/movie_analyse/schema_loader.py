from pyspark.sql.types import *

def getMovieSchema():
    movieSchema = StructType([    
        StructField("movieId", IntegerType(), True),
        StructField("title", StringType(), True),
        StructField("releaseDate", StringType(), True),
        StructField("videoReleaseDate", StringType(), True),
        StructField("imdbUrl", StringType(), True),
        StructField("unknown", IntegerType(), True),
        StructField("action", IntegerType(), True)
        # add more fields here
    ])
    return movieSchema

def getRatingSchema():
    ratingSchema = StructType([StructField("userId",IntegerType(),False),
                            StructField("movieId",IntegerType(),False),
                            StructField("rating",DecimalType(10,2),False),
                            StructField("timestamp",LongType(),False)])
    return ratingSchema