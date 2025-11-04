---
time: 09/09/2021
title: Công nghệ Containerization và Docker
description:
banner_url: 
tags: [big-data, tools]
is_highlight: false
is_published: true
---

# Docker introduction

## 1. Giới thiệu về công nghệ Containerization

<img src="https://onedrive.live.com/embed?resid=55F936846CC480BE%2123421&authkey=%21AFdBecLAeHpJdpY" style="width: 1200px;"/>

Containerization là một công nghệ ảo hóa hệ thống giúp đóng gói ứng dụng và môi trường chạy của chúng vào một container độc lập, tự đủ, có thể di chuyển và chạy trên bất kỳ môi trường máy tính nào hỗ trợ containerization mà không cần phải quan tâm đến môi trường hệ thống phía dưới.

Containerization cung cấp một cách tiếp cận tiêu chuẩn hóa cho việc triển khai ứng dụng và giúp giảm thiểu các vấn đề liên quan đến sự khác biệt giữa môi trường phát triển và môi trường sản phẩm cuối cùng.

Một số công nghệ containerization phổ biến bao gồm:
- Docker:
Docker là một trong những công cụ containerization phổ biến nhất.
Nó sử dụng các image và container để đóng gói và triển khai ứng dụng.
Docker Hub là một registry nơi bạn có thể tìm kiếm và chia sẻ các image Docker.
- Kubernetes:
Kubernetes là một hệ thống quản lý container mã nguồn mở được sử dụng rộng rãi để tự động hóa việc triển khai, quản lý và mở rộng các container.
Nó giúp quản lý nhiều container trên các nút máy chủ khác nhau.
- Podman:
Một sự thay thế cho Docker, Podman cung cấp các tính năng tương tự cho việc quản lý container.
Tuy nhiên, Podman không yêu cầu một daemon chạy liên tục, điều này có thể hữu ích trong môi trường bảo mật hơn.
- LXC (Linux Containers):
LXC là một công nghệ containerization gốc dựa trên cơ sở hạ tầng Linux.
Nó cho phép tạo và quản lý các container Linux một cách trực tiếp.

## 2. Giới thiệu về Docker

<img src="https://onedrive.live.com/embed?resid=55F936846CC480BE%2123419&authkey=%21AG31-e6Vv2WLFrk" style="width: 1200px;"/>

Docker là một công nghệ containerization mạnh mẽ, cho phép bạn đóng gói ứng dụng và tài nguyên của chúng vào một container độc lập.
Mỗi container hoạt động như một môi trường cô độc, đảm bảo tính nhất quán và di động giữa các máy chủ và môi trường khác nhau.

Lợi ích của Docker
- Tích hợp dễ dàng:
Docker cho phép bạn đóng gói tất cả các phụ thuộc của ứng dụng vào một container, giúp quá trình triển khai trở nên đơn giản và dễ dàng.
- Di động và linh hoạt:
Container Docker có thể chuyển đổi giữa các môi trường khác nhau mà không gặp sự cản trở, từ máy tính cá nhân đến máy chủ trên đám mây.
- Tiết kiệm tài nguyên:
So với máy ảo truyền thống, Docker sử dụng ít tài nguyên hơn, cho phép bạn chạy nhiều container trên cùng một máy.

Các khái niệm cơ bản trong Docker
- Image:
Một hình ảnh (image) Docker là một bản tĩnh của một container, chứa tất cả các mã nguồn và cài đặt cần thiết để chạy ứng dụng.
Images có thể được tạo từ Dockerfile.
- Container:
Một container Docker là một thể hiện thực của một image.
Chúng ta có thể chạy nhiều container từ cùng một image.
- Dockerfile:
Là một tệp văn bản chứa các hướng dẫn để xây dựng một image.
Dockerfile định nghĩa cách cài đặt và cấu hình ứng dụng của bạn.
- Registry:
Registry Docker là nơi lưu trữ các image.
Docker Hub là một registry phổ biến chứa nhiều image sẵn sàng sử dụng.

## 3. Các bước sử dụng Docker

<img src="https://onedrive.live.com/embed?resid=55F936846CC480BE%2123420&authkey=%21AMRnBio3tfPgwtk" style="width: 1200px;"/>

### 3.1. Khái quát các bước sử dụng

- Bước 1: Cài đặt Docker:
Đầu tiên, bạn cần cài đặt Docker trên máy tính của mình.
Các bản cài đặt dành cho các hệ điều hành phổ biến như Windows, macOS và Linux có sẵn trên trang chính thức của Docker.
- Bước 2: Tạo Dockerfile:
Để bắt đầu, bạn cần tạo một Dockerfile để xác định cách build image của bạn.
Dockerfile sẽ chứa các hướng dẫn về cách cài đặt các phụ thuộc và cấu hình ứng dụng.
- Bước 3: Build image:
Sử dụng lệnh docker build để tạo image từ Dockerfile của bạn.
Image này sẽ chứa mọi thứ cần thiết để chạy ứng dụng của bạn.
- Bước 4: Chạy container:
Sử dụng lệnh docker run để chạy container từ image bạn đã build.
Bạn có thể cấu hình các tùy chọn như cổng, biến môi trường và nhiều điều khác.
- Bước 5: Quản lý container:
Sử dụng các lệnh Docker như docker ps, docker stop, và docker rm để quản lý các container đang chạy.

### 3.2. Tạo Dockerfile

Viết Dockerfile là một phần quan trọng trong việc sử dụng Docker để đóng gói và triển khai ứng dụng.
Dockerfile chứa các hướng dẫn để xây dựng một image Docker, bao gồm cách cài đặt phụ thuộc, cấu hình ứng dụng và tạo môi trường chạy cho container.

Bước 1: Chọn một Base Image
Đầu tiên, bạn cần chọn một base image để bắt đầu.
Base image là một image sẵn có mà bạn sẽ dựa vào để xây dựng image của mình.
Docker Hub (https://hub.docker.com) là một nguồn tài nguyên tốt để tìm các base image sẵn có. 

``` Dockerfile
FROM ubuntu:20.04
```

Bước 2: Cài Đặt Phụ Thuộc
Sử dụng các lệnh RUN để cài đặt các phụ thuộc cần thiết cho ứng dụng của bạn
Sử dụng các lệnh dựa trên hệ điều hành của base image bạn đã chọn.

``` Dockerfile
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip
```

Bước 3: Sao chép mã nguồn và tài nguyên vào Container
Sử dụng lệnh COPY để sao chép mã nguồn và các tài nguyên của ứng dụng vào container.

``` Dockerfile
COPY ./app /app
```

Bước 4: Cấu Hình Môi Trường
Sử dụng các lệnh ENV để đặt các biến môi trường cần thiết cho ứng dụng của bạn.

``` Dockerfile
ENV DATABASE_PASSWORD=password
```

Bước 5: Expose các cổng (Ports) (nếu cần)
Nếu ứng dụng của bạn cần mở các cổng để giao tiếp với bên ngoài, sử dụng lệnh EXPOSE.

``` Dockerfile
EXPOSE 8000
```

Bước 6: Định Nghĩa Lệnh Khởi Chạy Container
Sử dụng lệnh CMD hoặc ENTRYPOINT để định nghĩa lệnh khởi chạy mặc định khi container được chạy.
Lệnh này sẽ thực thi khi bạn chạy container.

``` Dockerfile
CMD ["python3", "/app/main.py"]
```

### 3.3. Build Image
Sau khi bạn đã viết xong Dockerfile, bạn có thể sử dụng lệnh docker build để xây dựng image từ Dockerfile.

``` bash
docker build -t my-app .
```

### 3.4. Chạy Container
Sau khi bạn đã build image, bạn có thể sử dụng lệnh docker run để chạy container từ image bạn đã build.

``` bash
docker run -p 8000:8000 my-app
```
