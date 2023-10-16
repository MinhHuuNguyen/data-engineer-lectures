# 0. Change directory to hadoop dockerization folder
cd hadoop_dockerization

# 1. Build hadoop_base image
docker build -t hadoop_base:v1.0.0 -f ./base.Dockerfile .

# 2. Run docker compose
docker-compose up -d

# 3. Check docker containers
docker ps

# 4. Check hadoop namenode
docker exec -it namenode bash

# 5. Copy file to hadoop
docker cp ../hadoop_demo/wordcount_dataset namenode:/
hdfs dfs -put wordcount_dataset/small_500k.txt /
hdfs dfs -ls /
hdfs dfs -cat /small_500k.txt
hdfs fsck /small_500k.txt -files -blocks -locations

# A rack is nothing but a collection of 30-40 DataNodes or machines in a Hadoop cluster located in a single data center or location.
# These DataNodes in a rack are connected to the NameNode through traditional network design via a network switch.
# A large Hadoop cluster will have multiple racks.

# 6. Check hadoop datanode
docker exec -it datanode1 bash
# check PID
jps
kill -9 <PID>
# wait for 10 mins to check if datanode is dead or not
hdfs dfsadmin -report
# after demo with small_500k file, continue to demo with big_5M file
 
# 7. Some hadoop commands
hdfs dfs -rm /small_500k.txt
hdfs dfs -ls /
hdfs dfs -mkdir /wordcount_dataset
hdfs dfs -mkdir -p /wordcount_dataset/input_level_1/input_level_2/input_level_3
hdfs dfs -rmdir /wordcount_dataset/input_level_1/input_level_2/input_level_3
hdfs dfs -get /small_500k.txt /tmp
hdfs dfs -count /
hdfs dfs -df
hdfs dfs -head /small_500k.txt
hdfs dfs -tail /small_500k.txt
