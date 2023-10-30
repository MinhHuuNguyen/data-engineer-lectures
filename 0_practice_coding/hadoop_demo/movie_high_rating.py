
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
        yield movie_id, float(rating)

    def reducer_average_ratings(self, movie_id, ratings):
        total_ratings = 0
        num_ratings = 0

        for rating in ratings:
            total_ratings += rating
            num_ratings += 1

        average_rating = total_ratings / num_ratings
        yield movie_id, average_rating

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
    MovieRatingMRJob.run()
