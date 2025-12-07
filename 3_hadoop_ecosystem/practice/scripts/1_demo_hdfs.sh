# 1. Vào container NameNode
sudo docker exec -it namenode bash

# 2. Kiểm tra tổng quan HDFS
# Liệt kê các thư mục ở root HDFS.
hdfs dfs -ls /

# Hiển thị báo cáo cluster: số DataNode, dung lượng, trạng thái.
hdfs dfsadmin -report

# 3. Tạo thư mục lab và upload file
# `-p`: tạo cả cây thư mục nếu chưa tồn tại.
hdfs dfs -mkdir -p /lab/hdfs-demo
hdfs dfs -ls /

# Tạo file `/tmp/demo.txt` với vài dòng text ở local (trong container nhưng ngoài HDFS).
cat > /tmp/demo.txt <<EOF
Hello HDFS
Hello Distributed World
Hello Replication
EOF
cat /tmp/demo.txt

# Upload lên HDFS
hdfs dfs -put /tmp/demo.txt /lab/hdfs-demo/demo.txt
hdfs dfs -ls /lab/hdfs-demo
hdfs dfs -cat /lab/hdfs-demo/demo.txt

# Copy file lớn
sudo docker cp data/dummy_parquet_dataset/mapreduce_data/wordcount_dataset namenode:/
sudo docker exec -it namenode bash
ls
hdfs dfs -mkdir /wordcount_dataset
hdfs dfs -put /wordcount_dataset/small_500k.txt /wordcount_dataset/small_500k.txt
hdfs dfs -put /wordcount_dataset/big_5M.txt /wordcount_dataset/big_5M.txt
hdfs dfs -put /wordcount_dataset/huge_50M.txt /wordcount_dataset/huge_50M.txt
hdfs dfs -ls /wordcount_dataset

# 4. Thể hiện tính phân tán (block & replication)
# `fsck`: kiểm tra tình trạng file.
# `-files` `-blocks` `-locations`: hiển thị chi tiết file, block và DataNode chứa block.
# Bạn sẽ thấy mỗi block có replicas=2 (theo HDFS_CONF_dfs_replication=2) và nằm trên datanode1, datanode2.
hdfs fsck /lab/hdfs-demo/demo.txt -files -blocks -locations
hdfs fsck /wordcount_dataset/small_500k.txt -files -blocks -locations
hdfs fsck /wordcount_dataset/big_5M.txt -files -blocks -locations
hdfs fsck /wordcount_dataset/huge_50M.txt -files -blocks -locations

# Rack là một nhóm các DataNode nằm trong cùng một tủ rack hoặc cùng một miền mạng trong cụm Hadoop.
# Các DataNode trong cùng rack thường kết nối với nhau thông qua cùng một switch mạng.
# Một cụm Hadoop lớn sẽ bao gồm nhiều rack,
# và HDFS sử dụng thông tin rack awareness để phân phối bản sao dữ liệu sang nhiều rack khác nhau nhằm tăng khả năng chịu lỗi
# và cải thiện hiệu năng truy xuất.

# Quan sát NameNode UI: http://192.168.100.131:9870

# 5. Demo khi một DataNode “chết”
sudo docker stop datanode1
# Sau 1 lúc, trong NameNode UI: datanode1 sẽ thành Dead.
# Kiểm tra lại file demo.txt
sudo docker exec -it namenode bash
hdfs fsck /lab/hdfs-demo/demo.txt -files -blocks -locations
hdfs dfsadmin -report

# 6. Một số lệnh HDFS khác
hdfs dfs -rm /wordcount_dataset/small_500k.txt
hdfs dfs -ls /wordcount_dataset
hdfs dfs -mkdir -p /test_dir/input_level_1/input_level_2/input_level_3
hdfs dfs -rmdir /test_dir/input_level_1/input_level_2/input_level_3
hdfs dfs -get /wordcount_dataset/big_5M.txt /big_5M.txt
hdfs dfs -count /
hdfs dfs -df
hdfs dfs -head /wordcount_dataset/small_500k.txt
hdfs dfs -tail /wordcount_dataset/small_500k.txt
