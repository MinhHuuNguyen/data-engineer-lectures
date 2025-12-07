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
    # python3 map_reduce_demo/wordcount.py -r local data/dummy_parquet_dataset/mapreduce_data/wordcount_dataset/small_500k.txt
    # python3 map_reduce_demo/wordcount.py -r local data/dummy_parquet_dataset/mapreduce_data/wordcount_dataset/big_5M.txt
    # python3 map_reduce_demo/wordcount.py -r local data/dummy_parquet_dataset/mapreduce_data/wordcount_dataset/huge_50M.txt

    WordCount.run()
