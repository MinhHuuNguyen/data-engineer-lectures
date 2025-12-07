import sys


def mapper():
    for line in sys.stdin:
        words = line.strip().split()
        for word in words:
            # Emit key-value pairs (word, 1)
            print(f"{word}\t1")


def reducer():
    word_count = {}
    for line in sys.stdin:
        word, count = line.strip().split("\t")
        count = int(count)
        word_count[word] = word_count.get(word, 0) + count

    # Emit the final word count
    for word, count in word_count.items():
        print(f"{word}\t{count}")


if __name__ == "__main__":
    # Run mapper
    # python3 map_reduce_demo/wordcount_no_mrjob.py mapper < data/dummy_parquet_dataset/mapreduce_data/wordcount_dataset/small_500k.txt > map_reduce_demo/mapper_output.txt
    # python3 map_reduce_demo/wordcount_no_mrjob.py mapper < data/dummy_parquet_dataset/mapreduce_data/wordcount_dataset/big_5M.txt > map_reduce_demo/mapper_output.txt
    # python3 map_reduce_demo/wordcount_no_mrjob.py mapper < data/dummy_parquet_dataset/mapreduce_data/wordcount_dataset/huge_50M.txt > map_reduce_demo/mapper_output.txt

    # Run reducer
    # sort map output before feeding to reducer
    # sort map_reduce_demo/mapper_output.txt | python3 map_reduce_demo/wordcount_no_mrjob.py reducer > map_reduce_demo/reducer_output.txt

    input_fn = sys.argv[1]

    # Determine whether to run the mapper or reducer based on command line arguments
    if input_fn == 'mapper':
        mapper()
    elif input_fn == 'reducer':
        reducer()
    else:
        print("Invalid argument. Use 'mapper' or 'reducer' as the argument.")
        sys.exit(1)
