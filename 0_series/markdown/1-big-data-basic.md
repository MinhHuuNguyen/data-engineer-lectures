---
time: 09/24/2022
title: "[SERIES] Big Data cơ bản"
description: Là kết quả từ cách mạng công nghiệp 3.0, cho đến nay, thế giới đã tạo ra một lượng dữ liệu khổng lồ, trở thành nền tảng cho cách mạng công nghiệp 4.0 với Trí tuệ nhân tạo. Việc thu thập, xử lý và lưu trữ lượng dữ liệu lớn này đòi hỏi những công nghệ và kỹ thuật đặc biệt, được gọi chung là Big Data. Series bài viết này sẽ cung cấp cho bạn cái nhìn tổng quan về Big Data, từ các khái niệm cơ bản đến các công cụ và kỹ thuật phổ biến trong lĩnh vực này.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/banner.jpeg
tags: [big-data, series]
is_highlight: false
is_published: true
---

---

### [Bài 1: Giới thiệu chung về Big Data](/blog/gioi-thieu-chung-ve-big-data)

Bài viết giới thiệu chung về Big Data và vai trò của Data Engineer nhằm cung cấp cho người học cái nhìn tổng quan về sự bùng nổ dữ liệu trong kỷ nguyên số và nhu cầu xử lý dữ liệu quy mô lớn trong doanh nghiệp hiện đại. Nội dung trình bày các đặc trưng của Big Data như Volume, Velocity, Variety và những thách thức trong việc lưu trữ, quản lý và khai thác dữ liệu. Bài viết cũng làm rõ vị trí của Data Engineer trong hệ thống dữ liệu như xây dựng kiến trúc dữ liệu, thiết kế pipeline thu thập – xử lý – phân phối dữ liệu và đảm bảo dữ liệu sẵn sàng cho phân tích, học máy.

###### 1. So sánh Big data và cơ sở dữ liệu truyền thống

###### 2. Các đặc trưng của Big Data

###### 3. Các vai trò công việc trong lĩnh vực Big Data

---

### [Bài 2: Mô hình lưu trữ dữ liệu và quy trình xử lý dữ liệu](/blog/mo-hinh-luu-tru-du-lieu-va-quy-trinh-xu-ly-du-lieu)

Trong bối cảnh dữ liệu ngày càng trở thành tài sản chiến lược, các tổ chức cần nắm rõ cách dữ liệu được lưu trữ, tổ chức và xử lý để tối ưu hoá khả năng phân tích, khai thác giá trị và đảm bảo tính sẵn sàng. Các ý tưởng thiết kế hệ thống lưu trữ dữ liệu và quy trình xử lý dữ liệu cũng như các công cụ giúp triển khai từng phần trong thiết kế hệ thống đóng vai trò quan trọng trong việc xây dựng hệ thống dữ liệu hiệu quả.

###### 1. Mô hình lưu trữ dữ liệu

###### 2. Data Lake và Data Warehouse

###### 3. Quy trình xử lý dữ liệu

---

### [Bài 3: Thu thập dữ liệu từ các website](/blog/thu-thap-du-lieu-tu-cac-website)

Dữ liệu từ các trang web đóng vai trò quan trọng trong việc phân tích thị trường, nghiên cứu khách hàng và phát triển sản phẩm. Việc thu thập dữ liệu này thường được thực hiện thông qua các kỹ thuật như data scraping và data crawling.

###### 1. Data scraping và Data crawling là gì?

###### 2. Các công cụ để thực hiện data scraping và data crawling

###### 3. Ứng dụng của data scraping và data crawling

---

### [Bài 4: Hệ sinh thái Hadoop](/blog/he-sinh-thai-hadoop)

Hệ sinh thái Hadoop là một nền tảng xử lý dữ liệu lớn được xây dựng xoay quanh khả năng lưu trữ phân tán và tính toán song song trên cụm máy chủ giá rẻ. Trung tâm của hệ sinh thái là HDFS đảm nhiệm lưu trữ dữ liệu dung lượng lớn theo dạng phân mảnh, YARN quản lý tài nguyên và lập lịch tác vụ. Nhiều thành phần mở rộng được phát triển để đáp ứng các nhu cầu khác nhau như MapReduce, Hive, HBase, Spark, Pig, Oozie, Zookeeper, Avro, Parquet. Nhờ kiến trúc linh hoạt, Hadoop trở thành nền tảng phổ biến cho phân tích dữ liệu lớn, học máy và hệ thống kho dữ liệu hiện đại.

###### 1. Tổng quan về hệ sinh thái Hadoop

###### 2. Các thành phần cốt lõi trong hệ sinh thái Hadoop

###### 3. Các thành phần mở rộng phổ biến trong hệ sinh thái Hadoop

---

### [Bài 5: Hệ thống tệp phân tán Hadoop Distributed File System (HDFS)](/blog/he-thong-tep-phan-tan-hadoop-distributed-file-system-hdfs)

HDFS (Hadoop Distributed File System) là hệ thống tệp phân tán được thiết kế để lưu trữ dữ liệu dung lượng rất lớn trên cụm máy chủ phổ thông, đồng thời đảm bảo khả năng chịu lỗi cao và thông lượng truy cập lớn. Nhờ khả năng mở rộng tuyến tính và cơ chế tự phục hồi, HDFS trở thành lớp lưu trữ cốt lõi trong các hệ thống phân tích dữ liệu lớn và xử lý song song trong Hadoop.

---

### [Bài 6: Framework xử lý dữ liệu Hadoop Map Reduce](/blog/framework-xu-ly-du-lieu-hadoop-map-reduce)

Hadoop MapReduce là mô hình và framework xử lý dữ liệu lớn theo phương thức song song và phân tán trên cụm máy chủ. Nhờ tận dụng tài nguyên từ toàn bộ cụm máy, MapReduce cho phép xử lý khối lượng dữ liệu rất lớn theo dạng batch với khả năng chịu lỗi cao. Đây là nền tảng truyền thống cho nhiều ứng dụng phân tích dữ liệu trong hệ sinh thái Hadoop.

---

### [Bài 7: Lớp quản lý tài nguyên Hadoop Yet Another Resource Negotiator (YARN)](/blog/lop-quan-ly-tai-nguyen-hadoop-yet-another-resource-negotiator-yarn)

Hadoop YARN (Yet Another Resource Negotiator) là lớp quản lý tài nguyên và lập lịch trung tâm trong hệ sinh thái Hadoop, chịu trách nhiệm phân phối tài nguyên tính toán cho các ứng dụng chạy trên cụm. Nhờ cơ chế tách biệt giữa quản lý tài nguyên và mô hình xử lý, YARN cho phép nhiều framework như MapReduce, Spark, Tez cùng hoạt động linh hoạt trên cùng hạ tầng.

---

### [Bài 8: Nền tảng xử lý dữ liệu lớn Apache Spark](/blog/nen-tang-xu-ly-du-lieu-lon-apache-spark)

Apache Spark là nền tảng xử lý dữ liệu lớn in-memory được thiết kế cho hiệu năng cao và khả năng xử lý linh hoạt. Khác với MapReduce chỉ hoạt động theo mô hình batch, Spark giữ dữ liệu trong bộ nhớ qua nhiều bước tính toán, giúp tăng tốc đáng kể các tác vụ lặp như học máy, phân tích biểu đồ và xử lý tương tác. Nhờ khả năng mở rộng và tốc độ vượt trội, Spark trở thành lựa chọn phổ biến trong các hệ thống phân tích dữ liệu hiện đại.

---

### [Bài 9: Nền tảng streaming phân tán Apache Kafka](/blog/nen-tang-streaming-phan-tan-apache-kafka)

Apache Kafka là nền tảng streaming phân tán được thiết kế để xử lý dữ liệu theo thời gian thực với độ tin cậy và thông lượng rất cao. Kafka hoạt động như một hệ thống hàng đợi nhật ký (commit log), nơi dữ liệu được ghi vào các topics và lưu trữ bền vững, cho phép nhiều ứng dụng tiêu thụ song song. Nhờ khả năng mở rộng tuyến tính, chịu lỗi tốt và độ trễ thấp, Kafka trở thành thành phần cốt lõi trong các hệ thống phân tích thời gian thực, event-driven architecture và pipeline dữ liệu lớn.
