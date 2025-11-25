---
time: 10/01/2022
title: Công nghệ Containerization và Docker
description: Containerization là một công nghệ ảo hóa hệ thống giúp đóng gói ứng dụng và môi trường chạy của chúng vào một container độc lập, tự đủ, có thể di chuyển và chạy trên bất kỳ môi trường máy tính nào hỗ trợ containerization mà không cần phải quan tâm đến môi trường hệ thống phía dưới. Trong các công nghệ containerization, Docker là một trong những nền tảng phổ biến và mạnh mẽ nhất, cho phép người dùng dễ dàng tạo, triển khai và quản lý các container.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/banner.jpeg
tags: [big-data, tools]
is_highlight: false
is_published: true
---

## 1. Cách triển khai ứng dụng truyền thống

Một ứng dụng phần mềm thường bao gồm cách thành phần sau:
- **Mã nguồn ứng dụng:** Đây là phần chính của ứng dụng và cũng là phần cao nhất (high level) trong kiến trúc phần mềm.
- **Runtime environment:** Môi trường chạy ứng dụng, bao gồm các thư viện, framework và các công cụ cần thiết để ứng dụng hoạt động.
- **Driver và phụ thuộc hệ thống:** Các thành phần này bao gồm các driver, thư viện hệ thống và các phần mềm hỗ trợ khác mà ứng dụng cần để tương tác với hệ điều hành và phần cứng.
- **Hệ điều hành:** Ứng dụng chạy trên một hệ điều hành cụ thể, như Windows, Linux hoặc macOS.
- **Phần cứng (Hardware):** Ứng dụng cuối cùng chạy trên phần cứng của máy tính hoặc máy chủ.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/traditional_deployment.jpeg" style="width: 400px;"/>

Trong mô hình triển khai truyền thống, ứng dụng được cài đặt trực tiếp trên hệ điều hành của máy chủ hoặc máy tính cá nhân.
Điều này dẫn đến một số vấn đề như:
- **Khó khăn trong việc tái tạo môi trường:** Mỗi môi trường (phát triển, kiểm thử, production) có thể có cấu hình khác nhau, dẫn đến việc ứng dụng hoạt động không ổn định hoặc không chạy được.
- **Khó khăn trong việc mở rộng:** Việc mở rộng ứng dụng để đáp ứng nhu cầu tăng cao có thể gặp khó khăn do không thể đồng nhất được môi trường giữa các máy chủ.
- **Khó khăn trong việc nâng cấp và bảo trì:** Việc nâng cấp thư viện môi trường hoặc hệ điều hành hoặc phần cứng có thể gây ra sự cố cho ứng dụng.
- **Vấn đề về xung đột phụ thuộc:** Các ứng dụng khác nhau trên cùng một máy chủ có thể yêu cầu các phiên bản thư viện hoặc công cụ khác nhau, dẫn đến xung đột và khó khăn trong việc quản lý.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/problem_conversation.jpeg" style="width: 700px;"/>

Ví dụ 1: Khó khăn trong việc tái tạo môi trường
- Trong giai đoạn phát triển:
    - Lập trình viên A phát triển ứng dụng trên máy tính cá nhân với hệ điều hành Windows 10, sử dụng phiên bản Python 3.8 và một số thư viện như NumPy v1.19 và Pandas v1.1.
- Trong giai đoạn kiểm thử:
    - Ứng dụng được triển khai trên máy chủ kiểm thử chạy hệ điều hành Ubuntu 18.04 với Python 3.7 và các phiên bản thư viện khác như NumPy v1.18 và Pandas v1.0.
    - Điều này có thể dẫn đến việc ứng dụng hoạt động không đúng hoặc gặp lỗi do sự khác biệt trong môi trường.
    - Thấy lỗi, lập trình viên A phải điều chỉnh mã nguồn để tương thích với môi trường kiểm thử.
- Trong giai đoạn triển khai thực tế:
    - Giai đoạn ban đầu, ứng dụng được triển khai trên máy chủ production chạy đúng với các yêu cầu là Ubuntu 18.04 với Python 3.7 và các phiên bản thư viện khác như NumPy v1.18 và Pandas v1.0.
    Phầm mềm hoạt động ổn định.
    - Tuy nhiên, sau một thời gian hoạt động, một máy chủ khác được thêm vào hệ thống để mở rộng quy mô. Máy chủ mới này sử dụng các phần cứng mới hơn và đòi hỏi các phần mềm cũng phải được nâng cấp mới hơn: Ubuntu 20.04 với Python 3.9, NumPy v1.20 và Pandas v1.2.
    - Do sự khác biệt về môi trường giữa máy chủ cũ và máy chủ mới, ứng dụng không thể chạy ổn định trên máy chủ mới.
    - Đội ngũ kỹ thuật phải dành thời gian để điều chỉnh và kiểm tra lại ứng dụng để đảm bảo nó hoạt động đúng trên cả hai môi trường.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/conflict.jpeg" style="width: 700px;"/>

Ví dụ 2: Vấn đề về xung đột phụ thuộc
- Công ty XYZ đã có phần mềm quản lý nhân sự (HRM) được triển khai ổn định trên máy chủ nội bộ sử dụng hệ điều hành Linux với Python 3.6 và các thư viện như Django 2.2 và PostgreSQL 10.
- Sau đó, công ty quyết định triển khai thêm một ứng dụng phân tích dữ liệu (Data Analytics) trên cùng một máy chủ để tận dụng tài nguyên hiện có.
    - Ứng dụng phân tích dữ liệu được phát triển trên Python 3.8 và sử dụng Django 3.1 cùng với PostgreSQL 12 để tận dụng các tính năng mới liên quan đến hiệu suất phân tích dữ liệu.
- Khi triển khai ứng dụng phân tích dữ liệu trên cùng máy chủ với ứng dụng HRM, đội ngũ kỹ thuật phát hiện ra rằng có sự xung đột về phiên bản thư viện giữa hai ứng dụng.
    - Lúc này, đội ngũ kỹ thuật phải dành thời gian để điều chỉnh phiên bản thư viện và cấu hình hệ thống để đảm bảo cả hai ứng dụng có thể hoạt động ổn định trên cùng một máy chủ.

## 2. Công nghệ Containerization

### 2.1. Định nghĩa Containerization

Câu hỏi mà nhiều nhà phát triển đặt ra là: **"Có cách nào 'đóng gói' ứng dụng kèm theo tất cả những gì nó cần, để đem đi đâu chạy cũng như nhau không?"**

**Định nghĩa:** Containerization là kỹ thuật đóng gói ứng dụng gồm đầy đủ **Mã nguồn ứng dụng**, **Runtime environment**, một số **Driver và phụ thuộc hệ thống** vào thành một “hộp” gọi là Container, có thể chạy ổn định trên nhiều môi trường khác nhau.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/container_deployment.jpeg" style="width: 400px;"/>

Containerization cung cấp một cách tiếp cận tiêu chuẩn hóa cho việc triển khai ứng dụng và giúp giảm thiểu các vấn đề liên quan đến sự khác biệt giữa môi trường phát triển và môi trường sản phẩm cuối cùng.

### 2.2. So sánh Containerization và Virtual Machine (VM)

#### Kernel của hệ điều hành

Kernel là thành phần lõi của hệ điều hành (OS), chịu trách nhiệm quản lý trực tiếp phần cứng và cung cấp các dịch vụ cơ bản cho các tiến trình.
Kernel là "bộ não" điều phối tất cả hoạt động giữa phần mềm và phần cứng.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/kernel_in_operation_system.jpeg" style="width: 400px;"/>

Chức năng chính của kernel:
- **Quản lý tiến trình (Process Management):** Tạo, xóa, lập lịch (scheduling), chuyển trạng thái tiến trình.
- **Quản lý bộ nhớ (Memory Management):** Cấp phát và thu hồi RAM. Ánh xạ bộ nhớ ảo → bộ nhớ vật lý.
- **Quản lý thiết bị (Device Management):** Giao tiếp với phần cứng thông qua driver (disk, network card, USB…).
- **Quản lý hệ thống file (File System Management):** Đọc, ghi, phân quyền và tổ chức dữ liệu trên ổ đĩa.
- **Bảo mật và phân quyền (Security & Permission):** Kiểm soát quyền truy cập tài nguyên của mỗi tiến trình.

#### Cơ chế hoạt động của Virtual Machine (VM)

Hypervisor (hay Virtual Machine Monitor – VMM) là phần mềm hoặc firmware cho phép tạo và chạy máy ảo (Virtual Machine – VM) bằng cách ảo hóa tài nguyên phần cứng.

Hypervisor đứng bên dưới các VM, chịu trách nhiệm phân phối CPU, RAM, I/O cho từng VM.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/virtual_machine.jpeg" style="width: 500px;"/>

Chức năng chính của hypervisor:
- Tạo VM mới.
- Ảo hóa CPU, RAM, Network, Disk.
- Cô lập tài nguyên giữa các VM.
- Quản lý lifecycle của VM (start/stop/migrate/snapshot).

Mỗi VM chạy trên một hypervisor và bao gồm một hệ điều hành đầy đủ riêng biệt và mỗi VM vận hành giống như một máy vật lý độc lập.

#### Containerization khác Virtual Machine (VM) ở điểm nào?

Ví dụ: Xét một ứng dụng web trên hệ điều hành Ubuntu 20.04, sử dụng Python 3.8 và một số thư viện như Flask, SQLAlchemy.
- Để triển khai ứng dụng web này trong thực tế, ta cần đóng gói ứng dụng này cùng với môi trường chạy và các phụ thuộc cần thiết, tạo thành một container.
- Ta cần chạy container này trên một máy chủ khác, giả sử máy chủ chạy hệ điều hành Windows 10, vậy container này có thể chạy ổn định trên máy chủ Windows 10 không?

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/containerization_vs_virtual_machine.jpeg" style="width: 700px;"/>

Để chạy được container này trên máy chủ Windows 10, Windows 10 cần sử dụng một cơ chế ảo hoá (là Windows Subsystem for Linux - WSL hoặc LinuxKit) để tạo ra kernel cho hệ điều hành Ubuntu 20.04, từ đó mới có thể chạy được container chứa ứng dụng web.

Bản chất của cơ chế ảo hoá của WSL hoặc LinuxKit tương tự như hypervisor trong VM, nhưng thay vì tạo ra một máy ảo đầy đủ với hệ điều hành riêng biệt, nó chỉ tạo ra một môi trường kernel chung để các container có thể chia sẻ và chạy trên đó.
Điều này giúp giảm thiểu tài nguyên sử dụng và tăng hiệu suất nếu so sánh giữa việc chạy container và chạy VM.

Tóm lại, Containerization cũng sử dụng công nghệ ảo hoá giống Virtual Machine, nhưng thay vì ảo hoá toàn bộ phần cứng để chạy một hệ điều hành đầy đủ như VM, Containerization chỉ ảo hoá hệ điều hành để chia sẻ kernel giữa các container.

### 2.3. Ý nghĩa của Containerization

Containerization mang lại nhiều lợi ích quan trọng trong việc phát triển, triển khai và vận hành ứng dụng:
- **Tích hợp dễ dàng:** Containerization cho phép đóng gói tất cả các phụ thuộc của ứng dụng vào một container, giúp quá trình triển khai trở nên đơn giản và dễ dàng.
- **Di động và linh hoạt:** Container có thể chuyển đổi giữa các môi trường khác nhau mà gần như không gặp sự cản trở, từ máy tính cá nhân đến máy chủ trên đám mây.
- **Tiết kiệm tài nguyên:** So với máy ảo truyền thống, sử dụng ít tài nguyên hơn, cho phép bạn chạy nhiều container trên cùng một máy.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/containerization_values.jpeg" style="width: 500px;"/>

Một số công cụ containerization phổ biến:
- **Docker:** Là công cụ containerization phổ biến nhất, giúp xây dựng (build), đóng gói (package), phân phối (ship), chạy (run) các ứng dụng dưới dạng container.
- **Kubernetes:** Là một hệ thống quản lý container mã nguồn mở được sử dụng rộng rãi để tự động hóa việc triển khai, quản lý và mở rộng các container, giúp quản lý nhiều container trên các nút máy chủ khác nhau.
- Một số công cụ khác như **Podman**, **LXC (Linux Containers)**...

## 3. Tổng quan về Docker

Docker là công cụ containerization phổ biến nhất, giúp xây dựng (build), đóng gói (package), phân phối (ship), chạy (run) các ứng dụng dưới dạng container.

Các thành phần chính của Docker:
- **Docker Engine:** Là runtime cho phép tạo và chạy container.
- **Dockerfile:** Là file mô tả cách build một Docker image.
- **Docker Image:** Là “khuôn mẫu” (template) chỉ đọc, chứa mọi thứ để tạo ra container.
- **Docker Container:** Là instance đang chạy được tạo ra từ một image.
- **Docker Registry - Docker Hub:** Kho chứa image (ví dụ: Docker Hub, GitHub Container Registry, AWS ECR, GitLab, …)

### 3.0. Bước 0: Cài đặt Docker

Đầu tiên, bạn cần cài đặt Docker trên máy tính của mình.
Các bản cài đặt dành cho các hệ điều hành phổ biến như Windows, macOS và Linux có sẵn trên trang chính thức của Docker.

### 3.1. Bước 1: Tạo Dockerfile

Là file văn bản chứa các hướng dẫn để xây dựng một Docker image: Dùng image base nào? Copy file gì vào? Chạy lệnh gì? Mở port nào?

Viết Dockerfile là một phần quan trọng trong việc sử dụng Docker để đóng gói và triển khai ứng dụng.
Dockerfile chứa các hướng dẫn để xây dựng một image Docker, bao gồm cách cài đặt phụ thuộc, cấu hình ứng dụng và tạo môi trường chạy cho container.

**Bước 1:** Chọn một Base Image
Đầu tiên, bạn cần chọn một base image để bắt đầu.
Base image là một image sẵn có mà bạn sẽ dựa vào để xây dựng image của mình.
Docker Hub (https://hub.docker.com) là một nguồn tài nguyên tốt để tìm các base image sẵn có. 

``` Dockerfile
FROM ubuntu:20.04
```

**Bước 2:** Cài Đặt Phụ Thuộc
Sử dụng các lệnh RUN để cài đặt các phụ thuộc cần thiết cho ứng dụng của bạn
Sử dụng các lệnh dựa trên hệ điều hành của base image bạn đã chọn.

``` Dockerfile
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip
```

**Bước 3:** Sao chép mã nguồn và tài nguyên vào Container
Sử dụng lệnh COPY để sao chép mã nguồn và các tài nguyên của ứng dụng vào container.

``` Dockerfile
COPY ./app /app
```

**Bước 4:** Cấu Hình Môi Trường
Sử dụng các lệnh ENV để đặt các biến môi trường cần thiết cho ứng dụng của bạn.

``` Dockerfile
ENV DATABASE_PASSWORD=password
```

**Bước 5:** Expose các cổng (Ports) (nếu cần)
Nếu ứng dụng của bạn cần mở các cổng để giao tiếp với bên ngoài, sử dụng lệnh EXPOSE.

``` Dockerfile
EXPOSE 8000
```

**Bước 6:** Định Nghĩa Lệnh Khởi Chạy Container
Sử dụng lệnh CMD hoặc ENTRYPOINT để định nghĩa lệnh khởi chạy mặc định khi container được chạy.
Lệnh này sẽ thực thi khi bạn chạy container.

``` Dockerfile
CMD ["python3", "/app/main.py"]
```

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/dockerfile_image.jpeg" style="width: 500px;"/>

### 3.2. Bước 2: Build Docker Image

Sau khi bạn đã viết xong Dockerfile, bạn có thể sử dụng lệnh docker build để xây dựng image từ Dockerfile.

``` bash
docker build -t my-app .
```

Nếu như Dockerfile giống như một file chứa bản vẽ thiết kế về cách cài đặt và cấu hình ứng dụng, thì lệnh docker build sẽ là công cụ để "xây dựng" image dựa trên bản vẽ đó.

Docker image là một "bản sao" tĩnh của ứng dụng và môi trường chạy, được tạo ra từ Dockerfile.
Nói cách khác, Docker image là một đối tượng chứa ứng dụng một cách hoàn chỉnh, chỉ có điều là nó chưa được chạy thôi.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/docker_image_container.jpeg" style="width: 500px;"/>

### 3.3. Bước 3: Run Docker Container

Sau khi bạn đã build image, bạn có thể sử dụng lệnh docker run để chạy container từ image bạn đã build.

``` bash
docker run -p 8000:8000 my-app
```

Sau khi bạn đã có Docker image, bước tiếp theo là chạy một container từ image đó.
Lệnh docker run sẽ tạo và khởi động một container mới dựa trên image bạn đã build.

Trên thực tế, từ một Docker image, bạn có thể tạo ra nhiều Docker container khác nhau giúp mở rộng khả năng xử lý và phục vụ ứng dụng của mình.

Việc Run Docker Container thường được sử dụng trong quá trình phát triển và kiểm thử ứng dụng.
Trong các hệ thống lớn hơn và trong môi trường production, người ta thường sử dụng các công cụ quản lý container như Docker Compose hoặc Kubernetes để triển khai và quản lý nhiều container một cách hiệu quả hơn.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/docker_image_containers.jpeg" style="width: 500px;"/>

### 3.4. Bước 4: Push Docker Image lên Docker Registry

Bên cạnh việc lưu trữ mã nguồn chương trình của ứng dụng (trên GitHub), để đảm bảo tính sẵn sàng và tính mở rộng của hệ thống, người ta còn cần lưu trữ Docker image của ứng dụng trên các Docker Registry như Docker Hub, GitHub Container Registry, AWS ECR, GitLab ...

Từ đó, ta có thể dễ dàng mở rộng số lượng Docker container của ứng dụng trên nhiều máy chủ khác nhau bằng cách pull image từ Docker Registry về và chạy container từ image đó.

Để lưu trữ Docker image lên Docker Registry, bạn cần thực hiện các bước sau:
**Bước 1:** Đăng nhập vào Docker Registry như Docker Hub hoặc GitHub Container Registry ...

``` bash
docker login
```

**Bước 2:** Gắn thẻ (tag) Docker image với tên người dùng và tên repository trên Docker Registry.

``` bash
docker tag my-app username/my-app:latest
```

**Bước 3:** Đẩy (push) Docker image lên Docker Registry.

``` bash
docker push username/my-app:latest
```

Để sử dụng Docker image từ Docker Registry, bạn có thể pull image về máy chủ hoặc máy tính cá nhân của mình bằng lệnh docker pull.

``` bash
docker pull username/my-app:latest
```
Sau đó, bạn có thể chạy container từ image đã pull về như bình thường.

``` bash
docker run -p 8000:8000 username/my-app:latest
```

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/docker_registry_hub.jpeg" style="width: 400px;"/>

## 4. Docker Compose

### 4.1. Docker Compose là gì?

**Docker Compose** là một công cụ để định nghĩa và chạy nhiều container Docker như một ứng dụng thống nhất.
Thay vì chạy từng **docker run riêng rẽ**, bạn mô tả các dịch vụ (services), mạng (networks), và lưu trữ (volumes) trong một file YAML (docker-compose.yml) và dùng một vài lệnh để khởi tạo/triệt tiêu toàn bộ stack.

Ví dụ: web server + application + database + cache — mỗi thành phần chạy trong một container riêng nhưng được quản lý cùng nhau.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/2-docker/docker_compose.jpeg" style="width: 500px;"/>

Ta thường dùng Docker Compose trong các trường hợp:
- **Phát triển cục bộ:** khởi dựng nhanh môi trường giống production (DB, cache, message broker,...).
- **Triển khai ứng dụng nhỏ hoặc môi trường staging.**
- **CI pipelines để dựng môi trường tạm thời cho build/test.**

*Đối với các hệ thống lớn, cần chuyển sang nền tảng orchestration như Kubernetes hoặc Docker Swarm.*

### 4.2. Cấu trúc file docker-compose.yml

Cấu trúc cơ bản của file docker-compose.yml gồm:
- **version:** phiên bản của Docker Compose file format.
- **services:** định nghĩa các dịch vụ (containers) trong ứng dụng.
- **networks:** định nghĩa các mạng nội bộ giữa các dịch vụ.
- **volumes:** định nghĩa các volume để lưu trữ dữ liệu bền vững.

Dưới đây là ví dụ minh hoạ về một web app với database Postgres:

``` yaml
version: "3.8"

services:
  web:
    build: .
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgres://postgres:example@db:5432/mydb
    depends_on:
      - db
    volumes:
      - .:/app
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  db:
    image: postgres:14
    environment:
      - POSTGRES_PASSWORD=example
      - POSTGRES_DB=mydb
    volumes:
      - db-data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 30s
      timeout: 5s
      retries: 5

volumes:
  db-data:
```

trong đó:
- `build` vs `image`: `build` tạo image từ Dockerfile; `image` dùng image có sẵn.
- `ports`: ánh xạ cổng host:container.
- `volumes`: lưu trữ dữ liệu bền vững hoặc mount mã nguồn cho dev.
- `depends_on`: đảm bảo thứ tự khởi động (nhưng không đảm bảo service sẵn sàng; dùng healthcheck để kiểm tra readiness).
- `healthcheck`: giúp phát hiện khi một service thực sự sẵn sàng.

### 4.3. Các lệnh Docker Compose cơ bản

Docker Compose hiện nay có hai dạng lệnh: `docker-compose` (cũ) và plugin tích hợp `docker compose` — câu lệnh tương tự.

- Khởi động (foreground): `docker compose up`
- Khởi động nền (detached): `docker compose up -d`
- Dừng và gỡ bỏ containers: `docker compose down`
- Dừng và gỡ bỏ containers cùng volumes, networks không dùng: `docker compose down --volumes --remove-orphans`
- Xem logs: `docker compose logs` và `docker compose logs -f web`
- Xem trạng thái service: `docker compose ps`
- Thực thi lệnh trong container đang chạy: `docker compose exec web /bin/sh`
- Xây dựng image: `docker compose build`
- Dọn images không dùng: `docker image prune`
