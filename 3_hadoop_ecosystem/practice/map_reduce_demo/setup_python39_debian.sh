# 1) Ghi lại sources.list trỏ về archive.debian.org
cat > /etc/apt/sources.list << 'EOF'
deb [trusted=yes] http://archive.debian.org/debian stretch main contrib non-free
deb [trusted=yes] http://archive.debian.org/debian-security stretch/updates main contrib non-free
EOF

# 2) Tắt kiểm tra hạn sử dụng Release file (vì repo đã rất cũ)
echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid

# 3) Cài build dependencies + build Python 3.9
apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl wget build-essential \
    zlib1g-dev libssl-dev libncurses5-dev libreadline-dev \
    libsqlite3-dev libffi-dev libbz2-dev liblzma-dev tk-dev \
    libgdbm-dev libnss3-dev \
&& rm -rf /var/lib/apt/lists/*

PYVER=3.9.18
wget -q https://www.python.org/ftp/python/${PYVER}/Python-${PYVER}.tgz \
    && tar -xzf Python-${PYVER}.tgz \
    && cd Python-${PYVER} \
    && ./configure --with-ensurepip=install \
    && make -j"$(nproc)" \
    && make altinstall \
    && ln -sf /usr/local/bin/python3.9 /usr/local/bin/python3 \
    && /usr/local/bin/python3.9 --version

# 4) Cài thư viện mrjob
apt-get update && apt-get install -y python3-pip
pip3 install mrjob