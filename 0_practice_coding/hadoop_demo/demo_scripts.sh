# 0. Change directory to hadoop dockerization folder
cd hadoop_dockerization

# 1. Build hadoop_base image
docker build --platform=linux/amd64 -t hadoop_base:v1.0.0 -f ./base.Dockerfile .

# 2. Run docker compose
docker-compose up -d

# 3. Check docker containers
docker ps

# 4. Check hadoop namenode
docker exec -it namenode bash

# 5. Copy file to hadoop
docker cp ../hadoop_demo/mapreduce_data/wordcount_dataset namenode:/
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

# 8. Demo mapreduce
docker cp ../hadoop_demo/wordcount.py namenode:/
python3 wordcount.py -r local wordcount_dataset/small_500k.txt
python3 wordcount.py -r hadoop hdfs:///small_500k.txt --output-dir hdfs:///output_wordcount_small_500k
python3 wordcount.py -r hadoop hdfs:///big_5M.txt --output-dir hdfs:///output_wordcount_big_5M
# Go to http://localhost:8089/ to check the job status
# Go to http://localhost:9870/ to check the file system

# 9. Demo YARN
yarn version
yarn node -list
yarn application -list
yarn application -status <application_id>
yarn application -kill <application_id>
yarn logs -applicationId <application_id>
yarn top

mapred queue -list
yarn queue -status <your-yarn-queue>
yarn queue -setState <queue_name> <state>

# MapReduce without using mrjob library
yarn jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.5.jar \
    -files <path _to_your_script_on_hdfs> \
    -mapper "python3 <name_of_your_script.py>" \
    -input /<your_input_data_on_hdfs> \
    -output <your_output_on_hdfs>
# Example:
# yarn jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.5.jar \
#     -files wordcount_no_mrjob.py \
#     -mapper "python3 wordcount_no_mrjob.py mapper" \
#     -reducer "python3 wordcount_no_mrjob.py reducer" \
#     -input /small_500k.txt \
#     -output /wordcount_output_no_mrjob

# 10. SSH tunneling
ssh -i <KEY> -L <local_port>:<remote_ip>:<remote_local> username@<remote_ip>
# Example:
# ssh -i ~/.ssh/labserver.pem -L 8089:192.168.100.141:8089 -L 9870:192.168.100.141:9870 nguyenhuuminh@192.168.100.141
