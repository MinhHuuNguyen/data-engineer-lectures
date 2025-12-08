# 0. Bật cluster Hadoop (nếu chưa bặt)
sudo docker compose up -d

# 1. Vào container NameNode
sudo docker exec -it namenode bash

# 2. Một số lệnh YARN cơ bản
yarn version

# Kiểm tra trạng thái cluster YARN
yarn node -list -all
# Hiển thị thông tin chi tiết về một NodeManager cụ thể
yarn node -status <node_id>

# Hiển thị các ứng dụng đang chạy trên YARN
# Nếu không có job đang chạy, sẽ trống.
# Sau khi submit job MapReduce, lệnh này sẽ hiển thị application ID, trạng thái, queue (default), user, v.v.
yarn application -list
# Hiển thị thông tin chi tiết về một ứng dụng cụ thể
# Cho biết trạng thái, resource dùng, tracking URL, v.v.
yarn application -status <application_id>
# Xem logs của một ứng dụng cụ thể
yarn logs -applicationId <application_id>
# Quản lý ứng dụng: kill một ứng dụng cụ thể
yarn application -kill <application_id>

yarn top

# Hiển thị thông tin về queue trong YARN
# Mặc định sẽ có queue default.
# Đây là nơi để demo khái niệm hàng chờ:
# job nào submit thì vào queue, scheduler quyết định phân bổ resource.
yarn queue -list # <<=== need check

# 3. Demo 2 job chạy song song
sudo docker cp data/dummy_parquet_dataset/mapreduce_data/wordcount_dataset namenode:/
sudo docker exec -it namenode bash
hdfs dfs -mkdir /wordcount_dataset
hdfs dfs -put /wordcount_dataset/small_500k.txt /wordcount_dataset/small_500k.txt
hdfs dfs -put /wordcount_dataset/big_5M.txt /wordcount_dataset/big_5M.txt
hdfs dfs -put /wordcount_dataset/huge_50M.txt /wordcount_dataset/huge_50M.txt
hdfs dfs -ls /wordcount_dataset
# Terminal 1: Chạy job MapReduce WordCount trên file huge_50M.txt
hadoop jar /opt/hadoop-3.2.1/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar \
    wordcount \
    /wordcount_dataset/huge_50M.txt \
    /wordcount_mapreduce_output/huge_50M_wc_output

# Terminal 2: Chạy job MapReduce WordCount trên file big_5M.txt
hadoop jar /opt/hadoop-3.2.1/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar \
    wordcount \
    /wordcount_dataset/big_5M.txt \
    /wordcount_mapreduce_output/big_5M_wc_output

# Quan sát YARN UI: http://192.168.100.131:8088
# - Vào tab Applications: thấy 2 app cùng ở trạng thái RUNNING (tuỳ resource).
# - Vào tab Nodes: xem mỗi NodeManager đang chạy bao nhiêu container.
