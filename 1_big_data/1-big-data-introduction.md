---
slug: big-data-introduction
time: 11/09/2024
title: Giới thiệu chung về Big Data
description:
author: Nguyễn Hữu Minh
banner_url: 
tags: [big-data]
is_highlight: false
is_published: false
---

# Data lake data warehouse

## 1. Giới thiệu chung về Data engineer

Data Engineer là người chịu trách nhiệm xây dựng hệ thống và cơ sở hạ tầng để thu thập, xử lý và lưu trữ dữ liệu. Họ đảm bảo dữ liệu sẵn sàng cho các nhóm dữ liệu khoa học, phân tích và quản lý.

### 1.1. Công việc của data engineer

- Thu thập dữ liệu: xây dựng hệ thống thu thập dữ liệu từ nhiều nguồn khác nhau như database, file, API, web ...
- Xử lý dữ liệu: xây dựng hệ thống xử lý, biến đổi dữ liệu từ dữ liệu thô thành dữ liệu có cấu trúc phục vụ cho các tác vụ khác sau này.
- Lưu trữ dữ liệu: xây dựng hệ thống lưu trữ dữ liệu.
- Quản lý dữ liệu: xây dựng hệ thống quản lý dữ liệu, đảm bảo tính bảo mật, toàn vẹn của dữ liệu, đảm bảo dữ liệu luôn sẵn sàng và chính xác.

### 1.2. Các kiến thức và kỹ năng cần thiết

- Kiến thức về cơ sở dữ liệu: Hiểu biết sâu về cơ sở dữ liệu quan hệ (SQL) và NoSQL là quan trọng.
- Ngôn ngữ lập trình: Các ngôn ngữ như Python, Java, Scala thường được sử dụng trong việc xây dựng công cụ xử lý dữ liệu.
- Hiểu biết về an ninh dữ liệu và quản lý phiên bản: Đảm bảo tính bảo mật và sẵn sàng của dữ liệu là rất quan trọng.
- Kiến thức về tối ưu hóa: Hiểu biết về các kỹ thuật tối ưu hóa để tăng tốc độ xử lý dữ liệu.
- Kỹ năng làm việc với công cụ và framework: Có kiến thức về các công cụ như Apache Hadoop, Apache Spark, Apache Kafka, và nhiều công cụ khác.
- Kỹ năng làm việc nhóm: Data engineer thường làm việc với các nhóm khác nhau như data scientist, data analyst, data architect, data administrator ...

### 1.3. Các công cụ hữu ích cho data engineer
- Cơ sở dữ liệu:
    - Relational Databases (Cơ sở dữ liệu quan hệ): MySQL, PostgreSQL, Oracle, SQL Server.
    - NoSQL Databases (Cơ sở dữ liệu phi quan hệ): MongoDB, Cassandra, Redis, Couchbase.
- Các công cụ xử lý dữ liệu:
    - Apache Hadoop: Hadoop ecosystem bao gồm HDFS (Hadoop Distributed File System) và Apache MapReduce để xử lý lớn lượng dữ liệu phân tán.
    - Apache Spark: Một framework xử lý dữ liệu phân tán mạnh mẽ hỗ trợ xử lý batch và stream data.
    - Apache Kafka: Hệ thống định kỳ cho việc xử lý và truyền tải dữ liệu thời gian thực.
    - Python Libraries: Pandas, NumPy, Dask cho xử lý dữ liệu và SciPy cho tính toán khoa học.
- Công cụ quản lý dữ liệu và ETL (Extract, Transform, Load):
    - Apache Nifi: Công cụ ETL mã nguồn mở giúp di chuyển và biến đổi dữ liệu.
    - Talend: Platform ETL và tích hợp dữ liệu.
    - Apache Airflow: Hệ thống lập lịch và quản lý luồng công việc, thường được sử dụng cho các quy trình ETL.
- Công cụ lưu trữ và xử lý dữ liệu lớn:
    - Amazon S3, Google Cloud Storage, Microsoft Azure Data Lake Storage: Dịch vụ lưu trữ đám mây cho dữ liệu lớn.
    - Hive, Presto, Impala: Các công cụ truy vấn dữ liệu lớn phân tán.
- Công cụ quản lý cụm và triển khai:
    - Docker và Kubernetes: Để triển khai và quản lý các ứng dụng dựa trên các container.
    - Apache ZooKeeper: Dịch vụ quản lý cụm cho các hệ thống phân tán.
- Công cụ giám sát và bảo mật:
    - Prometheus, Grafana: Công cụ giám sát và hiển thị dữ liệu về hệ thống.
    - Apache Ranger: Công cụ quản lý quyền truy cập và bảo mật dữ liệu.
- Công cụ quản lý phiên bản:
    - Git: Để quản lý mã nguồn và các phiên bản của công cụ và dự án.
    - GitHub, GitLab, Bitbucket: Dịch vụ lưu trữ mã nguồn và hợp tác dựa trên Git.

<img src="https://www.alexanderthamm.com/wp-content/uploads/Mehrwerte-aus-Daten-generieren_Big-Data-Landscape.png" style="width: 1200px;"/>

## 2. Giới thiệu chung về Big data

Big data (dữ liệu lớn) là một khái niệm đề cập đến việc xử lý và quản lý các tập dữ liệu có kích thước lớn và phức tạp đến mức không thể được xử lý bằng các công cụ và phương pháp truyền thống.
Big data có tiềm năng mang lại giá trị lớn cho nhiều lĩnh vực, bao gồm khoa học dữ liệu, phân tích dự đoán, quản lý tài chính, y tế, và nhiều ứng dụng khác.

Đặc điểm chính của big data bao gồm ba yếu tố chính: 3V (Volume, Velocity, Variety):
- Volume (Lượng):
Big data đề cập đến khối lượng dữ liệu lớn, thường nằm trong khoảng từ terabytes (TB) đến petabytes (PB) hoặc thậm chí exabytes (EB).
Dữ liệu này có thể bao gồm thông tin từ nhiều nguồn, bao gồm dữ liệu từ cơ sở dữ liệu, mạng xã hội, máy chủ web, thiết bị cảm biến, và nhiều nguồn khác.
- Velocity (Tốc độ):
Đây là tốc độ mà dữ liệu được tạo ra, thu thập và cập nhật.
Dữ liệu big data thường được tạo ra liên tục và trong thời gian thực, chẳng hạn như dữ liệu từ trang web, các ứng dụng trực tuyến, và các thiết bị IoT (Internet of Things).
- Variety (Đa dạng):
Big data bao gồm nhiều loại dữ liệu khác nhau, không chỉ giới hạn trong cấu trúc dữ liệu cơ sở dữ liệu quan hệ.
Nó bao gồm dữ liệu có cấu trúc (như bảng), dữ liệu bán cấu trúc (như JSON, XML), và dữ liệu phi cấu trúc (như văn bản, hình ảnh, âm thanh).

<img src="https://www.coforge.com/hubfs/Imported_Blog_Media/The-3Vs-of-big-data-1.png" style="width: 700px;"/>

Ngoài ba tiêu chí cơ bản (Volume, Velocity, Variety) đã đề cập ở trên, có một số tiêu chí khác được sử dụng để đánh giá big data, đặc biệt trong ngữ cảnh của việc quản lý, xử lý và hiểu dữ liệu lớn hơn.
Dưới đây là một số trong những tiêu chí này:
- Veracity (Tính chính xác):
Đánh giá tính chính xác và đáng tin cậy của dữ liệu.
Big data thường bao gồm dữ liệu có sự nhiễu (noise) và lỗi, và việc đảm bảo tính chính xác của dữ liệu là một thách thức quan trọng.
- Validity (Tính hợp lệ):
Liên quan đến việc xác định liệu dữ liệu có phản ánh đúng thực tế hay không.
Dữ liệu không hợp lệ có thể dẫn đến việc đưa ra quyết định sai lầm.
- Volatility (Sự biến đổi):
Mức độ biến đổi và thay đổi của dữ liệu theo thời gian.
Một số loại dữ liệu có sự biến đổi nhanh chóng, và việc quản lý sự biến đổi này là quan trọng.
- Value (Giá trị):
Đánh giá mức độ giá trị thực sự mà dữ liệu mang lại cho tổ chức hoặc dự án.
Điều này liên quan đến việc dữ liệu có khả năng cung cấp thông tin hữu ích và mang lại lợi ích kinh doanh hay không.
- Variability (Độ biến đổi):
Mức độ biến đổi trong cách dữ liệu được sắp xếp và tổ chức.
Dữ liệu có thể có độ biến đổi cao khi đối mặt với nhiều định dạng và nguồn dữ liệu khác nhau.

## 3. Data lake vs Data warehouse vs Data mart

Data lake, Data warehouse và Data mart là các giải pháp lưu trữ dữ liệu khác nhau.

### 3.1. Data Lake (Hồ dữ liệu):

- Định nghĩa:
Data Lake là một hệ thống lưu trữ dữ liệu lớn quy mô, không có sự cấu trúc cố định, cho phép lưu trữ mọi loại dữ liệu, bao gồm dữ liệu có cấu trúc, bán cấu trúc và phi cấu trúc.
- Đặc điểm chính:
Data Lake cho phép lưu trữ dữ liệu một cách linh hoạt và giúp tổng hợp dữ liệu từ nhiều nguồn khác nhau mà không yêu cầu biến đổi dữ liệu trước khi lưu trữ.
Dữ liệu trong Data Lake có thể được sử dụng cho nhiều mục đích phân tích và khám phá dữ liệu.
- Ưu điểm:
Tính linh hoạt trong việc lưu trữ và sử dụng dữ liệu, có khả năng xử lý dữ liệu lớn và dữ liệu thời gian thực.
- Nhược điểm:
Dữ liệu trong Data Lake thường không được đảm bảo về tính toàn vẹn và chính xác, và việc truy vấn dữ liệu có thể khó khăn hơn do không có sự cấu trúc cố định.

### 3.2. Data Warehouse (Kho dữ liệu):

- Định nghĩa:
Data Warehouse là một hệ thống lưu trữ dữ liệu được cấu trúc theo một mô hình tổ chức cụ thể.
Dữ liệu trong Data Warehouse đã được biến đổi và làm sạch trước khi lưu trữ, để phục vụ cho các mục đích phân tích kinh doanh.
- Đặc điểm chính:
Data Warehouse thường chứa dữ liệu lịch sử và phản ánh một góc nhìn cụ thể về doanh nghiệp.
Dữ liệu ở đây thường được sắp xếp và lưu trữ trong các bảng quan hệ, thuận tiện cho việc truy vấn và phân tích.
- Ưu điểm:
Dữ liệu trong Data Warehouse thường rất đáng tin cậy và phục vụ cho mục đích phân tích kinh doanh một cách hiệu quả.
- Nhược điểm:
Data Warehouse thường không linh hoạt trong việc lưu trữ và sử dụng dữ liệu, và không thể lưu trữ dữ liệu phi cấu trúc.

<img src="https://www.qubole.com/wp-content/uploads/2020/12/Dl-vs-DW-infograph-1000x563.png" style="width: 1200px;"/>

### 3.3. Data Mart (Thị trường dữ liệu):

- Định nghĩa:
Data Mart là một phần của Data Warehouse hoặc một kho dữ liệu nhỏ, chứa dữ liệu phục vụ cho một nhóm cụ thể trong tổ chức.
- Đặc điểm chính:
Data Mart thường tập trung vào một lĩnh vực hoặc chức năng cụ thể của tổ chức và cung cấp dữ liệu sẵn sàng cho người dùng cuối để phân tích và báo cáo.
- Ưu điểm:
Data Mart giúp tập trung vào nhu cầu cụ thể của từng bộ phận hoặc nhóm người dùng, tạo ra sự tập trung và hiệu quả trong việc sử dụng dữ liệu.
- Nhược điểm:
Data Mart thường không linh hoạt trong việc lưu trữ và sử dụng dữ liệu, và không thể lưu trữ dữ liệu phi cấu trúc.

## 4. ETL vs ELT

ETL và ELT là hai phương pháp thường được sử dụng trong việc trích xuất, biến đổi và nạp dữ liệu (ETL) trong lĩnh vực quản lý dữ liệu.
Chúng có sự khác biệt trong thứ tự thực hiện các giai đoạn của quá trình ETL.
Dưới đây là giải thích về ETL và ELT:

### 4.1. ETL (Extract, Transform, Load):

- Extract (Trích xuất):
Ở giai đoạn này, dữ liệu được trích xuất từ các nguồn khác nhau, chẳng hạn như cơ sở dữ liệu, tệp dữ liệu, ứng dụng web, và các nguồn dữ liệu khác.
Dữ liệu được trích xuất trong định dạng gốc của nó.
- Transform (Biến đổi):
Sau khi dữ liệu được trích xuất, nó được biến đổi để thực hiện các xử lý và biến đổi dữ liệu cần thiết.
Các biến đổi này có thể bao gồm làm sạch dữ liệu, chuyển đổi định dạng, thêm cột mới, kết hợp dữ liệu từ nhiều nguồn, và nhiều công việc khác.
- Load (Nạp):
Cuối cùng, dữ liệu đã được biến đổi được nạp vào một kho dữ liệu hoặc Data Warehouse để sẵn sàng cho việc truy vấn và phân tích.

<img src="https://rivery.io/wp-content/uploads/2020/05/ETL-Process-for-linkedin3-1024x535.png" style="width: 800px;"/>

Ưu điểm của ETL:
- Tách biệt dữ liệu nguồn và dữ liệu đã biến đổi, giúp đảm bảo tính chính xác của dữ liệu nạp.
- Thích hợp cho các ứng dụng nơi dữ liệu đã được làm sạch và biến đổi trước khi lưu trữ.

### 4.2. ELT (Extract, Load, Transform):

- Extract (Trích xuất):
Giai đoạn này giống với ETL, dữ liệu được trích xuất từ các nguồn khác nhau trong định dạng gốc của nó.
- Load (Nạp):
Sau khi dữ liệu được trích xuất, nó được nạp trực tiếp vào kho dữ liệu hoặc Data Warehouse mà không cần biến đổi trước.
- Transform (Biến đổi):
Sau khi dữ liệu đã được nạp vào kho dữ liệu, các biến đổi và xử lý dữ liệu được thực hiện tại đây.
Các công cụ trong kho dữ liệu thường được sử dụng để biến đổi dữ liệu theo yêu cầu.

<img src="https://rivery.io/wp-content/uploads/2020/05/ETL-Process-for-linkedin.png" style="width: 800px;"/>

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

<img src="https://panoply.io/uploads/versions/diagram8-1---x----750-376x---.jpg" style="width: 800px;"/>
