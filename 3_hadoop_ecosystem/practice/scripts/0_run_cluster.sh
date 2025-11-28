# 1. Dựng cluster
sudo docker compose up -d

# 2. Xem container đang chạy
sudo docker compose ps

# 3. Tắt cluster
sudo docker compose down --remove-orphans --volumes
