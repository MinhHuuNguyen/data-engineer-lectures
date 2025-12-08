# 0. Bật cluster Hadoop (nếu chưa bặt)
sudo docker compose up -d

# 1. Copy dữ liệu vào container NameNode và vào bên trong container
sudo docker cp data/dummy_parquet_dataset/mapreduce_data/wordcount_dataset namenode:/
sudo docker cp map_reduce_demo namenode:/
sudo docker cp scripts/setup_python.sh namenode:/setup_python.sh
sudo docker exec -it namenode bash

# 2. Chuẩn bị dữ liệu
hdfs dfs -mkdir /wordcount_dataset
hdfs dfs -put /wordcount_dataset/small_500k.txt /wordcount_dataset/small_500k.txt
hdfs dfs -put /wordcount_dataset/big_5M.txt /wordcount_dataset/big_5M.txt
hdfs dfs -put /wordcount_dataset/huge_50M.txt /wordcount_dataset/huge_50M.txt
hdfs dfs -ls /wordcount_dataset

# 3. Kiểm tra hadoop-mapreduce-examples.jar
ls /opt/hadoop-3.2.1/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar

# 4. Chạy MapReduce WordCount bằng hadoop-mapreduce-examples.jar
hadoop jar /opt/hadoop-3.2.1/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar \
    wordcount \
    /wordcount_dataset/small_500k.txt \
    /wordcount_mapreduce_output/small_500k_wc_output

hadoop jar /opt/hadoop-3.2.1/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar \
    wordcount \
    /wordcount_dataset/big_5M.txt \
    /wordcount_mapreduce_output/big_5M_wc_output

hadoop jar /opt/hadoop-3.2.1/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar \
    wordcount \
    /wordcount_dataset/huge_50M.txt \
    /wordcount_mapreduce_output/huge_50M_wc_output

# 5. Xem kết quả
hdfs dfs -ls /wordcount_mapreduce_output/small_500k_wc_output
hdfs dfs -cat /wordcount_mapreduce_output/small_500k_wc_output/part-r-00000 | head -20
hdfs dfs -ls /wordcount_mapreduce_output/big_5M_wc_output
hdfs dfs -cat /wordcount_mapreduce_output/big_5M_wc_output/part-r-00000 | head -20
hdfs dfs -ls /wordcount_mapreduce_output/huge_50M_wc_output
hdfs dfs -cat /wordcount_mapreduce_output/huge_50M_wc_output/part-r-00000 | head -20

# 6. Cài đặt Python và thư viện cần thiết
# Trên container NameNode
bash /setup_python.sh
# Trên container NodeManager
# Mapper/Reducer không chạy trên namenode mà chạy trong các container NodeManager (chạy YARN containers).
# Nên bạn phải cài Python ở đó nữa, nếu không Hadoop Streaming sẽ lỗi python3: command not found trên worker.
sudo docker cp scripts/setup_python.sh nodemanager1:/setup_python.sh
sudo docker exec -it nodemanager1 bash
bash /setup_python.sh
exit
sudo docker cp scripts/setup_python.sh nodemanager2:/setup_python.sh
sudo docker exec -it nodemanager2 bash
bash /setup_python.sh
exit

# 7. Chạy MapReduce WordCount bằng code Python
sudo docker exec -it namenode bash
python3 map_reduce_demo/wordcount.py \
    -r hadoop \
    --python-bin python3 \
    --no-bootstrap-mrjob \
    hdfs:////wordcount_dataset/small_500k.txt \
    --output-dir hdfs:///output_wordcount_small_500k
python3 map_reduce_demo/wordcount.py -r hadoop hdfs:////wordcount_dataset/big_5M.txt --output-dir hdfs:///output_wordcount_big_5M
