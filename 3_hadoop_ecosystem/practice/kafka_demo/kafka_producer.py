from kafka import KafkaProducer
import json
import time


IP = '172.21.0.6'  # Thay bằng IP của container Kafka


class ProducerServer(KafkaProducer):

    def __init__(self, input_file, topic, **kwargs):
        super().__init__(**kwargs)
        self.input_file = input_file
        self.topic = topic

    def generate_data(self):
        with open(self.input_file) as f:
            for line in f:
                message = self.dict_to_binary(line)
                self.send(self.topic, message)
                print(line)
                time.sleep(1)

    def dict_to_binary(self, json_dict):
        return json.dumps(json_dict).encode('utf-8')


def run_server():
    producer = ProducerServer(
        'data/dummy_parquet_dataset/mapreduce_data/movie_rating_dataset/movie_data.txt',
        'movie_data_topic',
        bootstrap_servers=f'{IP}:9092'
    )
    producer.generate_data()


if __name__ == "__main__":
    run_server()
