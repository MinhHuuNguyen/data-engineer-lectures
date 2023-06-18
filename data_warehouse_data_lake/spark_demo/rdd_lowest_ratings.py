from pyspark import SparkConf, SparkContext


def loadMovieNames():
    movieNames = {}
    with open("ml-100k/u.item", encoding='latin-1') as f:
        for line in f:
            fields = line.split("|") # tab delimiter
            movieNames[fields[0]] = fields[1]
    return movieNames

def parseInput(line):
    fields = line.split()
    return (int(fields[1]), (int(fields[2]), 1))

if __name__ == "__main__":
    conf = SparkConf().setAppName("LowestRatingMovies")
    sc = SparkContext(conf=conf)

    movieNames = loadMovieNames()

    print("-----movieNames", movieNames)

    lines = sc.textFile("hdfs://namenode:9000/input/u.data")

    # convert to (movieId, (rating, 1.0))
    movieRatings = lines.map(parseInput)
    print(f"-----movieRatings: {movieRatings}")

    # reduce to (movieId, (sumOfRatings, totalRatings))
    ratingTotalsAndCount = movieRatings.reduceByKey(lambda movie1, movie2: (movie1[0] + movie2[0], movie1[1] + movie2[1]))
    print(f"-----RatingTotalsCount: {ratingTotalsAndCount}")

    # map to (movieId, averageRating)
    averageRatings = ratingTotalsAndCount.mapValues(lambda totalAndCount: totalAndCount[0] / totalAndCount[1])

    # sort by average ratings
    sortedMovies = averageRatings.sortBy(lambda x: x[1])

    results = sortedMovies.take(10)

    for result in results:
        print((movieNames[str(result[0])], result[1]))

