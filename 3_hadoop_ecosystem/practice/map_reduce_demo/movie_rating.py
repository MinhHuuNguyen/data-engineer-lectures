from mrjob.job import MRJob
from mrjob.step import MRStep


class MovieRating(MRJob):

    def steps(self):
        return [
            MRStep(
                mapper=self.mapper,
                reducer=self.reducer
            )
        ]

    def mapper(self, _, line):
        # 0	50	5	881250949
        (user_id, movie_id, rating, timestamp) = line.split('\t')
        yield movie_id, (float(rating), 1)

    def reducer(self, movie_id, ratings_counts):
        sum_ratings, sum_counts = 0, 0
        for (rating, count) in ratings_counts:
            sum_ratings += rating
            sum_counts += count
        yield movie_id, sum_ratings / sum_counts


if __name__ == '__main__':
    # python3 map_reduce_demo/movie_rating.py -r local data/dummy_parquet_dataset/mapreduce_data/movie_rating_dataset/movie_data.txt

    MovieRating.run()
