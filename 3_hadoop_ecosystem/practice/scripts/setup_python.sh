# 1) Ghi lại sources.list trỏ về archive.debian.org
cat > /etc/apt/sources.list << 'EOF'
deb [trusted=yes] http://archive.debian.org/debian stretch main contrib non-free
deb [trusted=yes] http://archive.debian.org/debian-security stretch/updates main contrib non-free
EOF

# 2) Tắt kiểm tra hạn sử dụng Release file (vì repo đã rất cũ)
echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid

# 3) Cập nhật lại danh sách gói
apt-get update

# 4) Cài python3 + pip3
apt-get install -y python3 python3-pip

# 5) Cài thư viện mrjob
pip3 install mrjob