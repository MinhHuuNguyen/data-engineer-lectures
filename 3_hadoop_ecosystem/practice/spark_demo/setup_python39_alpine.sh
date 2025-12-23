#!/bin/sh
set -e

PYVER=3.9.18
PYTAR=Python-${PYVER}.tgz
PYDIR=Python-${PYVER}

echo "==> Installing build dependencies..."
apk add --no-cache --virtual .build-deps \
    build-base \
    linux-headers \
    wget \
    ca-certificates \
    curl \
    zlib-dev \
    openssl-dev \
    libffi-dev \
    ncurses-dev \
    readline-dev \
    sqlite-dev \
    bzip2-dev \
    xz-dev \
    tk-dev \
    gdbm-dev \
    util-linux-dev

echo "==> Downloading Python ${PYVER}..."
wget -q https://www.python.org/ftp/python/${PYVER}/${PYTAR}

echo "==> Extracting source..."
tar -xzf ${PYTAR}
cd ${PYDIR}

echo "==> Configuring..."
./configure \
    --with-ensurepip=install \
    --enable-optimizations

echo "==> Building..."
make -j"$(nproc)"

echo "==> Installing (altinstall)..."
make altinstall

echo "==> Creating python3 symlink..."
ln -sf /usr/local/bin/python3.9 /usr/local/bin/python3

echo "==> Verifying installation..."
/usr/local/bin/python3.9 --version
/usr/local/bin/python3 --version

cd /

echo "==> Cleaning up source files..."
rm -rf ${PYDIR} ${PYTAR}

echo "==> Removing build dependencies..."
apk del .build-deps

echo "==> Installing runtime dependencies..."
apk add --no-cache \
    zlib \
    openssl \
    libffi \
    ncurses-libs \
    sqlite-libs \
    bzip2 \
    xz

echo "==> Python ${PYVER} installation completed successfully."
