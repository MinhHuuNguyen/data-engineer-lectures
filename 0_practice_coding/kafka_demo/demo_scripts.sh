# 1. Create a topic
kafka-topics.sh --bootstrap-server localhost:9092 --topic first_topic --create --partitions 3 --replication-factor 1

# 2. List all topics
kafka-topics.sh --bootstrap-server localhost:9092 --list

# 3. Describe a topic
kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic first_topic

# Topic: first_topic      TopicId: CralAF1qStuUP_cTV6pl-A PartitionCount: 3       ReplicationFactor: 1    Configs: 
# Topic: first_topic      Partition: 0    Leader: 1001    Replicas: 1001  Isr: 1001
# Topic: first_topic      Partition: 1    Leader: 1001    Replicas: 1001  Isr: 1001
# Topic: first_topic      Partition: 2    Leader: 1001    Replicas: 1001  Isr: 1001

# 4. Delete a topic
kafka-topics.sh --bootstrap-server localhost:9092 --delete --topic first_topic

# 5. Modify a topic
kafka-topics.sh --bootstrap-server localhost:9092 --alter --topic first_topic --partitions 5

# 6. Produce and consume a message
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic first_topic
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic first_topic
# consume all messages from the beginning
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic first_topic --from-beginning

# 7. Produce and consume a message from a file 
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic first_topic < /hadoop_demo/mapreduce_data/movie_rating_dataset/movie_data.txt
# # Permission denied????????
# kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic first_topic --from-beginning > first_topic-output.txt

# 8. Produce and consume from python code
# Install kafka-python
bash run_installation.sh
# Get the IP address of the docker container
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kafka
# Run the producer from python code
python3 kafka_producer.py
# Run the consumer
kafka-console-consumer.sh --bootstrap-server 0.0.0.0:9092 --topic movie_data_topic
# Run the consumer from python code
python3 spark_consumer.py
