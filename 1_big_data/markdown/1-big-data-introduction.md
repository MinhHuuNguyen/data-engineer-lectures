---
time: 09/09/2021
title: Giới thiệu chung về Big Data
description: Big Data là một khái niệm quan trọng trong thời đại số, đề cập đến việc xử lý và phân tích các tập dữ liệu lớn và phức tạp. Bài viết này sẽ cung cấp cái nhìn tổng quan về Big Data, từ khái niệm cơ bản đến các ứng dụng thực tiễn.
banner_url: 
tags: [big-data]
is_highlight: false
is_published: true
---

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

<img src="https://www.coforge.com/hubfs/Imported_Blog_Media/The-3Vs-of-big-data-1.jpeg" style="width: 1200px;"/>

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

<img src="https://www.alexanderthamm.com/wp-content/uploads/Mehrwerte-aus-Daten-generieren_Big-Data-Landscape.jpeg" style="width: 1200px;"/>
