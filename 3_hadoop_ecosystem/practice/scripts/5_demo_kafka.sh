# 0. Bật cluster Hadoop (nếu chưa bặt)
sudo docker compose up -d

# 1. Copy dữ liệu vào container Kafka và vào bên trong container
sudo docker cp data/dummy_parquet_dataset/mapreduce_data kafka:/
sudo docker exec -it kafka bash

# 1. Tạo topic / Liệt kê các topic / Xem chi tiết topic
kafka-topics --bootstrap-server localhost:9092 --topic ABC_topic --create --partitions 3 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --list
kafka-topics --bootstrap-server localhost:9092 --describe --topic ABC_topic

# Topic: ABC_topic      TopicId: CralAF1qStuUP_cTV6pl-A PartitionCount: 3       ReplicationFactor: 1    Configs: 
# Topic: ABC_topic      Partition: 0    Leader: 1001    Replicas: 1001  Isr: 1001
# Topic: ABC_topic      Partition: 1    Leader: 1001    Replicas: 1001  Isr: 1001
# Topic: ABC_topic      Partition: 2    Leader: 1001    Replicas: 1001  Isr: 1001

# 2. Sửa / Xoá topic
kafka-topics --bootstrap-server localhost:9092 --alter --topic ABC_topic --partitions 5
kafka-topics --bootstrap-server localhost:9092 --describe --topic ABC_topic
kafka-topics --bootstrap-server localhost:9092 --delete --topic ABC_topic
kafka-topics --bootstrap-server localhost:9092 --list

# 3. Produce và consume messages
kafka-topics --bootstrap-server localhost:9092 --topic DEF_topic --create --partitions 3 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --list

# Mở terminal khác, bật sẵn consumer trước
kafka-console-consumer --bootstrap-server localhost:9092 --topic DEF_topic
# Rồi quay lại terminal này để produce messages
kafka-console-producer --bootstrap-server localhost:9092 --topic DEF_topic
# Nhập vài dòng, mỗi dòng là một message, nhấn Enter để gửi
# Consume all messages from the beginning
kafka-console-consumer --bootstrap-server localhost:9092 --topic DEF_topic --from-beginning

# 4. Produce và consume messages từ file
kafka-console-producer --bootstrap-server localhost:9092 --topic DEF_topic < /mapreduce_data/movie_rating_dataset/movie_data.txt
kafka-console-consumer --bootstrap-server localhost:9092 --topic DEF_topic --from-beginning > DEF_topic-output.txt

# 5. Produce và consume messages từ code Python
# Tạo topic movie_data_topic
kafka-topics --bootstrap-server localhost:9092 --topic movie_data_topic --create --partitions 3 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --list
# Activate môi trường Python có thư viện kafka-python
pip3 install kafka-python
# Lấy IP của container Kafka để làm bootstrap-server
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kafka
# Sau đó, sửa code trong kafka_producer.py và spark_consumer.py cho đúng IP này
# Chạy producer ở bên ngoài container kafka
python3 kafka_producer.py
# Chạy consumer từ command line
kafka-console-consumer --bootstrap-server 0.0.0.0:9092 --topic movie_data_topic
# Hoặc chạy consumer từ code Python cũng ở bên ngoài container kafka
python3 spark_consumer.py
