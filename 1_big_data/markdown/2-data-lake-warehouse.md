---
time: 09/09/2021
title: Mô hình lưu trữ dữ liệu và quy trình xử lý dữ liệu
description:
banner_url: 
tags: [big-data]
is_highlight: false
is_published: true
---

## 1. Khái niệm Data lake, Data warehouse, Data Lakehouse, Data mart

### 1.1. Hồ dữ liệu - Data Lake:

Định nghĩa: Data Lake là một hệ thống lưu trữ dữ liệu quy mô lớn, không có sự cấu trúc cố định, cho phép lưu trữ mọi loại dữ liệu, bao gồm dữ liệu có cấu trúc, bán cấu trúc và phi cấu trúc.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/lake.jpeg" style="width: 500px;"/>

- Ưu điểm:
    - Lưu trữ các loại dữ liệu khác nhau
    - Giá thành thấp
    - Là xuất phát điểm tốt cho các hệ thống lưu trữ dữ liệu
    - Hỗ trợ các trường hợp sử dụng AI
- Nhược điểm:
    - Phức tạp trong việc thiết lập
    - Hiệu suất BI kém
    - Có thể trở thành "đầm lầy dữ liệu" không đáng tin cậy
    - Có thể gặp phải các vấn đề trong việc quản trị
    - Vẫn cần sử dụng warehouse

### 1.2. Kho dữ liệu - Data Warehouse:

Định nghĩa: Data Warehouse là một hệ thống lưu trữ dữ liệu được cấu trúc theo một mô hình tổ chức cụ thể.
Dữ liệu trong Data Warehouse đã được biến đổi và làm sạch trước khi lưu trữ, để phục vụ cho các mục đích phân tích kinh doanh.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/warehouse.jpeg" style="width: 500px;"/>

- Ưu điểm:
    - Mục đích xây dựng dành cho BI và báo cáo
    - Thống nhất giữa các hệ thống khác nhau
    - Lưu trữ dữ liệu sạch, có cấu trúc với một schema chuẩn
- Nhược điểm:
    - Không hỗ trợ dữ liệu bán cấu trúc hoặc không cấu trúc
    - Hỗ trợ kém cho các trường hợp sử dụng AI
    - Sử dụng định dạng đóng và định dạng độc quyền
    - Chi phí cao khi mở rộng

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/warehouse_vs_lake_graph.jpeg" style="width: 1200px;"/>

### 1.3. Data Mart (Thị trường dữ liệu):

Định nghĩa: Data Mart là một phần của Data Warehouse hoặc một kho dữ liệu nhỏ, chứa dữ liệu phục vụ cho một nhóm cụ thể trong tổ chức.
Data Mart thường tập trung vào một lĩnh vực hoặc chức năng cụ thể của tổ chức và cung cấp dữ liệu sẵn sàng cho người dùng cuối để phân tích và báo cáo.

- Ưu điểm: tương tự như Data Warehouse
- Nhược điểm: tương tự như Data Warehouse

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/warehouse_vs_lake_detail.jpeg" style="width: 1200px;"/>

## 2. Quy trình xử lý dữ liệu

ETL và ELT là hai phương pháp thường được sử dụng trong việc trích xuất, biến đổi và nạp dữ liệu (ETL) trong lĩnh vực quản lý dữ liệu.
Chúng có sự khác biệt trong thứ tự thực hiện các giai đoạn của quá trình ETL.
Dưới đây là giải thích về ETL và ELT:

### 2.1. ETL (Extract, Transform, Load):

- Extract (Trích xuất):
Ở giai đoạn này, dữ liệu được trích xuất từ các nguồn khác nhau, chẳng hạn như cơ sở dữ liệu, tệp dữ liệu, ứng dụng web, và các nguồn dữ liệu khác.
Dữ liệu được trích xuất trong định dạng gốc của nó.
- Transform (Biến đổi):
Sau khi dữ liệu được trích xuất, nó được biến đổi để thực hiện các xử lý và biến đổi dữ liệu cần thiết.
Các biến đổi này có thể bao gồm làm sạch dữ liệu, chuyển đổi định dạng, thêm cột mới, kết hợp dữ liệu từ nhiều nguồn, và nhiều công việc khác.
- Load (Nạp):
Cuối cùng, dữ liệu đã được biến đổi được nạp vào một kho dữ liệu hoặc Data Warehouse để sẵn sàng cho việc truy vấn và phân tích.

<img src="https://rivery.io/wp-content/uploads/2020/05/ETL-Process-for-linkedin3-1024x535.jpeg" style="width: 1200px;"/>

Ưu điểm của ETL:
- Tách biệt dữ liệu nguồn và dữ liệu đã biến đổi, giúp đảm bảo tính chính xác của dữ liệu nạp.
- Thích hợp cho các ứng dụng nơi dữ liệu đã được làm sạch và biến đổi trước khi lưu trữ.

### 2.2. ELT (Extract, Load, Transform):

- Extract (Trích xuất):
Giai đoạn này giống với ETL, dữ liệu được trích xuất từ các nguồn khác nhau trong định dạng gốc của nó.
- Load (Nạp):
Sau khi dữ liệu được trích xuất, nó được nạp trực tiếp vào kho dữ liệu hoặc Data Warehouse mà không cần biến đổi trước.
- Transform (Biến đổi):
Sau khi dữ liệu đã được nạp vào kho dữ liệu, các biến đổi và xử lý dữ liệu được thực hiện tại đây.
Các công cụ trong kho dữ liệu thường được sử dụng để biến đổi dữ liệu theo yêu cầu.

<img src="https://rivery.io/wp-content/uploads/2020/05/ETL-Process-for-linkedin.jpeg" style="width: 1200px;"/>

Ưu điểm của ELT:
- Cho phép lưu trữ dữ liệu nguyên gốc, giúp tiết kiệm thời gian và công sức trong việc trích xuất dữ liệu.
- Thích hợp cho các kho dữ liệu hoặc hệ thống có khả năng xử lý dữ liệu lớn và phức tạp.

||ETL|ELT|
|---|---|---|
|Đường đi dữ liệu|Dữ liệu được trích từ nguồn, qua server staging rồi mới vào data warehouse|Dữ liệu đi trực tiếp từ nguồn vào data warehouse và data lake|
|Kích thước dữ liệu|Dữ liệu kích thước nhỏ hơn|Dữ liệu kích thước lớn hơn|
|Phép biến đổi dữ liệu|Phép biến đổi phức tạp và đòi hỏi tính toán nhiều|Phép biến đổi đơn giản|
|Bảo mật dữ liệu|Dữ liệu được bảo mật cao hơn|Dữ liệu được bảo mật thấp hơn|
|Thời gian truyền tải dữ liệu|Khi kích thước dữ liệu tăng lên, thời gian chuyển đổi cũng tăng theo|Tốc độ không phụ thuộc vào kích thước của dữ liệu|
|Data lake|Không hỗ trợ data lake|Hỗ trợ data lake|
|Chi phí|Chi phí cao hơn|Chi phí thấp hơn|

<img src="https://panoply.io/uploads/versions/diagram8-1---x----750-376x---.jpg" style="width: 1200px;"/>
