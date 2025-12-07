from mrjob.job import MRJob
from mrjob.step import MRStep


class MovieRatingMRJob(MRJob):

    def steps(self):
        return [
            MRStep(
                mapper=self.mapper_get_ratings,
                reducer=self.reducer_average_ratings
            ),
            MRStep(
                mapper=self.mapper_identity,
                reducer=self.reducer_find_highest_rating
            )
        ]

    def mapper_get_ratings(self, _, line):
        # 0	50	5	881250949
        (user_id, movie_id, rating, timestamp) = line.split('\t')
        yield movie_id, (float(rating), 1)

    def reducer_average_ratings(self, movie_id, ratings_counts):
        sum_ratings, sum_counts = 0, 0
        for (rating, count) in ratings_counts:
            sum_ratings += rating
            sum_counts += count
        yield movie_id, sum_ratings / sum_counts

    def mapper_identity(self, movie_id, average_rating):
        yield None, (movie_id, average_rating)

    def reducer_find_highest_rating(self, _, avg_movie_pairs):
        highest_rating = -1
        top_movie_list = []

        for movie_id, average_rating in avg_movie_pairs:
            if average_rating >= highest_rating:
                highest_rating = average_rating
                top_movie_list.append(movie_id)

        yield highest_rating, top_movie_list


if __name__ == '__main__':
    # python3 map_reduce_demo/movie_high_rating.py -r local data/dummy_parquet_dataset/mapreduce_data/movie_rating_dataset/movie_data.txt

    MovieRatingMRJob.run()
