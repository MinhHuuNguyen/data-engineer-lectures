---
time: 04/08/2023
title:
description:
banner_url:
tags: []
is_highlight: false
is_published: false
---

# Google Compute Engine

Google Compute Engine (GCE) là một dịch vụ máy chủ ảo được cung cấp bởi Google Cloud Platform (GCP).
GCE cho phép bạn triển khai và quản lý các máy chủ ảo trên hạ tầng đám mây của Google.
Điều này giúp bạn tạo ra các tài nguyên máy chủ một cách linh hoạt, tăng giảm tài nguyên dựa theo nhu cầu của ứng dụng và dịch vụ của bạn.

# 1. Các đặc điểm chính của GCE

## 1.1. Linh hoạt quy mô:

Bạn có thể tạo máy chủ ảo với các cấu hình tùy chỉnh, như số lượng CPU, RAM, ổ cứng và hệ điều hành.
Điều này giúp bạn tùy chỉnh tài nguyên để phù hợp với nhu cầu ứng dụng.

## 1.2. Khả năng mở rộng:

GCE cho phép tự động mở rộng tài nguyên theo tải công việc.
Khi tải cao, máy chủ ảo sẽ tự động tăng để đảm bảo hiệu suất ứng dụng.

## 1.3. Tích hợp mạng:

Bạn có thể tạo mạng ảo và quản lý luồng dữ liệu giữa các máy chủ ảo của bạn.
Điều này giúp bạn tạo các ứng dụng có khả năng tương tác và giao tiếp an toàn.

## 1.4. Bảo mật và quản lý:

GCE tích hợp với Google Cloud Identity and Access Management (IAM), cho phép bạn quản lý quyền truy cập và bảo mật tài nguyên.
Bạn có thể cấu hình tường lửa và mạng riêng ảo (VPC) để bảo vệ ứng dụng của mình.

# 2. Ứng dụng của GCE

Google Compute Engine được sử dụng rộng rãi cho nhiều mục đích:

- Phát Triển Ứng Dụng:
GCE cung cấp môi trường cho phát triển, kiểm thử và triển khai các ứng dụng web và di động.
- Xử Lý Dữ Liệu:
Bạn có thể sử dụng GCE để xử lý dữ liệu lớn, tính toán khoa học và phân tích dữ liệu.
- Hệ Thống Phân Tán:
GCE hỗ trợ triển khai hệ thống phân tán, cơ sở dữ liệu và ứng dụng chia sẻ tải.
- Môi Trường Thử Nghiệm:
GCE cho phép bạn tạo các môi trường thử nghiệm và phát triển một cách nhanh chóng.

# 3. Các bước sử dụng GCE

- Bước 1: Tạo máy chủ ảo:
Chúng ta có thể tạo máy chủ ảo thông qua GCP Console hoặc giao diện dòng lệnh gCloud.
Bạn sẽ cần chọn cấu hình tài nguyên, hệ điều hành và tùy chọn khác.
- Bước 2: Quản lý máy chủ:
Bạn có thể kiểm soát và quản lý máy chủ ảo thông qua GCP Console.
Bạn có thể tắt, khởi động lại hoặc xóa máy chủ theo nhu cầu.
- Bước 3: Quản lý mạng:
GCE cho phép bạn tạo và quản lý các mạng ảo, phạm vi địa chỉ IP và các tùy chọn kết nối mạng.

# 4. Một số loại cấu hình máy chủ ảo phổ biến

## 4.1. General-Purpose Instances:

- Loại: N1, E2
- Mô tả: Các máy chủ phổ biến, phù hợp cho nhiều ứng dụng, từ phát triển ứng dụng đến máy chủ web và ứng dụng doanh nghiệp.
- Sử dụng: Phổ biến với các ứng dụng tổng quát, xử lý dữ liệu cơ bản.

## 4.2. Compute-Optimized Instances:

- Loại: C2, N2D
- Mô tả: Các máy chủ dành riêng cho tính toán cao cấp và xử lý đa luồng.
- Sử dụng: Đối với các ứng dụng yêu cầu hiệu suất tính toán cao, như phân tích dữ liệu, tính toán khoa học.

## 4.3. Memory-Optimized Instances:

- Loại: M2, R2
- Mô tả: Các máy chủ được tối ưu hóa cho khả năng xử lý bộ nhớ lớn.
- Sử dụng: Dành cho các ứng dụng đòi hỏi bộ nhớ lớn, như cơ sở dữ liệu in-memory và xử lý dữ liệu lớn.

## 4.4. Accelerator-Optimized Instances:

- Loại: A2
- Mô tả: Các máy chủ đi kèm với GPU tối ưu hóa cho khả năng xử lý học máy và trí tuệ nhân tạo.
- Sử dụng: Cho các ứng dụng học máy, xử lý ảnh, xử lý ngôn ngữ tự nhiên.

## 4.5. Shared-Core Instances:

- Loại: f1-micro, g1-small
- Mô tả: Các máy chủ chia sẻ tài nguyên máy chủ với các khách hàng khác.
- Sử dụng: Dành cho các ứng dụng nhẹ, phát triển và thử nghiệm.

# 5. Chi phí của GCE

- Cấu hình máy chủ ảo: Chi phí sẽ phụ thuộc vào cấu hình máy chủ ảo bạn chọn, bao gồm số lượng CPU, bộ nhớ RAM và dung lượng ổ cứng.
- Thời gian hoạt động: GCE tính toán chi phí dựa trên thời gian máy chủ ảo hoạt động. Bạn sẽ trả tiền cho thời gian máy chủ được khởi chạy.
- Lưu trữ: Nếu bạn sử dụng lưu trữ dữ liệu như ổ cứng ảo hoặc ổ cứng dài hạn, chi phí sẽ được tính dựa trên dung lượng lưu trữ bạn sử dụng.
- Băng thông: Chi phí băng thông được tính dựa trên lưu lượng dữ liệu ra/vào của máy chủ ảo.
- Vùng địa lý và kích thước: Giá sẽ thay đổi tùy theo vùng địa lý bạn triển khai máy chủ ảo và kích thước của máy chủ.
- Kích hoạt đặc quyền: Nếu bạn chọn các tùy chọn đặc quyền như GPU, chi phí sẽ tăng lên.

Để tính toán chi phí cụ thể cho việc sử dụng Google Compute Engine, bạn có thể sử dụng công cụ tính toán chi phí trực tuyến của Google Cloud Platform.
Điều này sẽ giúp bạn dự đoán được chi phí dự kiến dựa trên các yếu tố bạn chọn.


# Các dịch vụ lưu trữ của Google Cloud Platform

## 1. Google Cloud Storage

### 1.1. Lợi ích và tính năng chính của Google Cloud Storage

- Độ tin cậy và bảo mật:
Dữ liệu được lưu trữ trên hạ tầng đám mây bảo mật và đáng tin cậy của Google.
Bạn có thể áp dụng các cơ chế bảo mật như quản lý quyền truy cập và mã hóa dữ liệu.
- Hỗ trợ đa dạng định dạng:
Google Cloud Storage hỗ trợ nhiều định dạng dữ liệu khác nhau như văn bản, hình ảnh, âm thanh và video.
Điều này giúp bạn lưu trữ các loại dữ liệu khác nhau một cách linh hoạt.
- Lưu trữ lớn và linh hoạt:
Bạn có thể lưu trữ lượng dữ liệu lớn mà không cần lo lắng về việc mở rộng cơ sở hạ tầng.
Google Cloud Storage cho phép bạn mở rộng tài nguyên lưu trữ theo nhu cầu.
- Lưu trữ dữ liệu phân tán:
Dữ liệu có thể được lưu trữ ở nhiều vị trí khác nhau trên toàn cầu, giúp cải thiện khả năng truy cập và tốc độ tải dữ liệu.

### 1.2. Cách sử dụng Google Cloud Storage

- Tạo Bucket:
Bạn bắt đầu bằng cách tạo "bucket" - đơn vị lưu trữ cơ bản trong Google Cloud Storage.
Bucket giống như một thư mục chứa các đối tượng dữ liệu.
- Tải Lên Và Tải Xuống Dữ Liệu:
Bạn có thể tải lên và tải xuống dữ liệu vào bucket thông qua giao diện dòng lệnh hoặc các giao diện quản lý như GCP Console.
- Quản Lý Quyền Truy Cập:
Google Cloud Storage cho phép bạn quản lý quyền truy cập đối với các bucket và đối tượng.
Bạn có thể chia sẻ dữ liệu với người dùng cụ thể hoặc công khai chúng nếu cần.

### 1.3. Ứng Dụng của Google Cloud Storage

- Lưu trữ dữ liệu đa phương tiện:
Bạn có thể lưu trữ hình ảnh, video, và âm thanh trong Google Cloud Storage, rất phù hợp cho các ứng dụng liên quan đến phương tiện truyền thông.
- Dự án lớn:
Google Cloud Storage thích hợp cho các dự án lớn, như lưu trữ và phân tích dữ liệu lớn.
- Backup và khôi phục dữ liệu:
Bạn có thể sử dụng Google Cloud Storage để sao lưu dữ liệu quan trọng và khôi phục chúng khi cần.

### 1.4. Một số loại cấu hình storage

#### 1.4.1. Standard Storage:

- Loại: Standard
- Mô tả: Dịch vụ lưu trữ chuẩn với thời gian truy cập thấp và khả năng sẵn sàng cao.
- Sử dụng: Lưu trữ dữ liệu thường xuyên truy cập, dự án lớn với yêu cầu bảo mật và hiệu suất cao.

#### 1.4.2. Nearline Storage:

- Loại: Nearline
- Mô tả: Dịch vụ lưu trữ dành cho dữ liệu ít truy cập, có thời gian truy cập từ vài giây đến phút.
- Sử dụng: Lưu trữ dữ liệu lưu trữ dài hạn như backup, lưu trữ lịch sử.

#### 1.4.2. Coldline Storage:

- Loại: Coldline
- Mô tả: Dịch vụ lưu trữ dành cho dữ liệu cần bảo quản lâu dài, với thời gian truy cập từ vài phút đến giờ.
- Sử dụng: Lưu trữ dữ liệu lưu trữ rất lâu dài, như dữ liệu pháp lý.

#### 1.4.3. Archive Storage:

- Loại: Archive
- Mô tả: Dịch vụ lưu trữ dành cho dữ liệu cần lưu trữ siêu lâu dài với thời gian truy cập từ vài giờ đến một ngày.
- Sử dụng: Lưu trữ dữ liệu ít truy cập, cần bảo quản theo yêu cầu quy định hoặc pháp lý.

#### 1.4.4. Multi-Regional Storage:

- Loại: Multi-Regional
- Mô tả: Dịch vụ lưu trữ đa vùng, đảm bảo sẵn sàng cao và thời gian truy cập thấp.
- Sử dụng: Dữ liệu được truy cập toàn cầu, ứng dụng có yêu cầu sẵn sàng và hiệu suất cao.

#### 1.4.5. Regional Storage:

- Loại: Regional
- Mô tả: Dịch vụ lưu trữ trong một vùng cụ thể, với sẵn sàng cao và thời gian truy cập thấp.
- Sử dụng: Dữ liệu được truy cập trong khu vực cụ thể, giảm thời gian truy cập.

#### 1.4.6. Durable Reduced Availability Storage:

- Loại: Durable Reduced Availability (DRA)
- Mô tả: Dịch vụ lưu trữ với sự sẵn sàng hạn chế hơn, giá thấp hơn so với các loại khác.
- Sử dụng: Dữ liệu ít truy cập, giảm chi phí lưu trữ.

### 1.5. Chi phí của Google Cloud Storage

- Loại cấu hình lưu trữ:
Chi phí sẽ thay đổi tùy theo loại cấu hình lưu trữ bạn chọn, ví dụ: Standard, Nearline, Coldline, Archive, Multi-Regional, Regional, Durable Reduced Availability.
- Dung lượng lưu trữ:
Giá lưu trữ dựa trên lượng dữ liệu bạn lưu trữ.
Càng nhiều dữ liệu thì càng tăng chi phí.
- Thời gian lưu trữ:
Dữ liệu lưu trữ trong thời gian dài sẽ tạo ra chi phí lưu trữ liên quan.
- Thời gian truy cập:
Dịch vụ lưu trữ có thời gian truy cập khác nhau (ví dụ: Standard có thời gian truy cập thấp hơn Archive).
Thời gian truy cập ảnh hưởng đến giá.
- Vùng địa lý:
Giá lưu trữ có thể thay đổi tùy theo vùng địa lý bạn chọn.
Vùng địa lý sẽ ảnh hưởng đến giá lưu trữ và truy cập.
- Số lượng yêu cầu API:
Nếu bạn sử dụng API để truy cập dữ liệu từ Google Cloud Storage, có thể có phí liên quan đến số lượng yêu cầu API.
- Chuyển dữ liệu và băng thông:
Nếu bạn di chuyển dữ liệu ra/vào Google Cloud Storage hoặc sử dụng băng thông lớn, chi phí có thể tăng.
- Quản lý dữ liệu:
Có thể có chi phí phụ thuộc vào việc quản lý và xử lý dữ liệu như xóa, di chuyển, sao lưu, phục hồi.

<!-- 
## 2. Google Cloud SQL

### 2.1. Google Cloud Vision

### 2.2. Google Cloud Speech

### 2.3. Google Cloud Translation

## 3. Google Cloud BigQuery -->
