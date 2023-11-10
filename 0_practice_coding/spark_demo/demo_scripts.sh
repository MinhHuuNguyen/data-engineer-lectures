# 0. Change directory to hadoop dockerization folder
cd hadoop_dockerization

# 1. Build hadoop_base image
docker build -t hadoop_base:v1.0.0 -f ./base.Dockerfile .

# 2. Run docker compose
docker-compose up -d

# 3. Check docker containers
docker ps

# 4. Check hadoop namenode
docker exec -it spark-master bash

# 5. Run installation
cd spark_demo
# Update Alpine Linux and install Numpy
bash installation_in_docker/run_installation.sh
# Copy yarn-site.xml to spark/conf to run spark with yarn
cp installation_in_docker/yarn-site.xml /spark/conf/

# 6. Run application
# Run simple
spark-submit movie_high_rating.py
# Run with yarn
spark-submit --master yarn movie_high_rating.py
