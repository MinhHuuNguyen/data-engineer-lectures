from datetime import datetime
import sys

from mrjob.job import MRJob
from mrjob.step import MRStep


class WordCount(MRJob):

    def steps(self):
        return [
            MRStep(
                mapper=self.mapper,
                reducer=self.reducer
            )
        ]

    def mapper(self, _, line):
        for word in line.strip().split(' '):
            if len(word) > 0:
                yield (word, 1)

    def reducer(self, word, count):
        yield (word, sum(count))


if __name__ == "__main__":
    start_time = datetime.now()
    WordCount.run()
    end_time = datetime.now()

    elapsed_time = end_time - start_time

    sys.stderr.write(elapsed_time)
