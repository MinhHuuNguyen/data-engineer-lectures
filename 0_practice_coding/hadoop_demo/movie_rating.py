
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
        yield movie_id, float(rating)

    def reducer(self, movie_id, ratings):
        total_ratings = 0
        num_ratings = 0

        for rating in ratings:
            total_ratings += rating
            num_ratings += 1

        average_rating = total_ratings / num_ratings
        yield movie_id, average_rating


if __name__ == '__main__':
    MovieRating.run()
