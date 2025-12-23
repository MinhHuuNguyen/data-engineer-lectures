# 0. Bật cluster Hadoop (nếu chưa bặt)
sudo docker compose up -d

# 1. Copy dữ liệu vào container NameNode và vào bên trong container
sudo docker cp data/dummy_parquet_dataset/mapreduce_data/wordcount_dataset namenode:/
sudo docker cp spark_demo spark-master:/

# 2. Chuẩn bị dữ liệu
sudo docker exec -it namenode bash
hdfs dfs -mkdir /wordcount_dataset
hdfs dfs -put /wordcount_dataset/small_500k.txt /wordcount_dataset/small_500k.txt
hdfs dfs -put /wordcount_dataset/big_5M.txt /wordcount_dataset/big_5M.txt
hdfs dfs -put /wordcount_dataset/huge_50M.txt /wordcount_dataset/huge_50M.txt
hdfs dfs -ls /wordcount_dataset

# 3. Cài đặt Python và thư viện cần thiết
# Trên container NodeManager
# Mapper/Reducer không chạy trên namenode mà chạy trong các container NodeManager (chạy YARN containers).
# Nên bạn phải cài Python ở đó nữa, nếu không sẽ lỗi python3: command not found trên worker.
sudo docker cp map_reduce_demo nodemanager1:/
sudo docker exec -it nodemanager1 bash
bash /map_reduce_demo/setup_python39_debian.sh
exit
sudo docker cp map_reduce_demo nodemanager2:/
sudo docker exec -it nodemanager2 bash
bash /map_reduce_demo/setup_python39_debian.sh
exit

sudo docker exec -it spark-master bash
bash /spark_demo/setup_python39_alpine.sh

# 4. Chạy Spark WordCount bằng code Python
/spark/bin/spark-submit \
  --master yarn \
  --deploy-mode client \
  --name spark-wordcount-big5M \
  /spark_demo/wordcount.py
