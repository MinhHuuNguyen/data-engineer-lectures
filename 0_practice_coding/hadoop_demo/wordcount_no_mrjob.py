# Import necessary libraries
import sys

# Mapper function
def mapper():
    for line in sys.stdin:
        words = line.strip().split()
        for word in words:
            # Emit key-value pairs (word, 1)
            print(f"{word}\t1")

# Reducer function
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
    if len(sys.argv) != 2:
        print("Usage: python wordcount.py <input_file>")
        sys.exit(1)

    input_file = sys.argv[1]

    # Determine whether to run the mapper or reducer based on command line arguments
    if input_file == 'mapper':
        mapper()
    elif input_file == 'reducer':
        reducer()
    else:
        print("Invalid argument. Use 'mapper' or 'reducer' as the argument.")
        sys.exit(1)
