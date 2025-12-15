---
time: 11/02/2022
title: Lớp quản lý tài nguyên Hadoop Yet Another Resource Negotiator (YARN)
description: Hadoop YARN (Yet Another Resource Negotiator) là lớp quản lý tài nguyên và lập lịch trung tâm trong hệ sinh thái Hadoop, chịu trách nhiệm phân phối tài nguyên tính toán cho các ứng dụng chạy trên cụm. Nhờ cơ chế tách biệt giữa quản lý tài nguyên và mô hình xử lý, YARN cho phép nhiều framework như MapReduce, Spark, Tez cùng hoạt động linh hoạt trên cùng hạ tầng.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/1-hadoop/banner.jpeg
tags: [big-data, hadoop]
is_highlight: false
is_published: true
---

## 1. Vấn đề của Hadoop 1 khi không có YARN

Trước YARN, Hadoop (MapReduce v1) kết hợp cả quản lý tài nguyên và lập lịch công việc trong một thành phần duy nhất (JobTracker). Điều này gây ra hai hạn chế lớn:
- **Độc quyền cho MapReduce:** khó tích hợp các framework xử lý khác (Spark, Tez, Flink, v.v.).
- **Khó mở rộng và khả năng chịu lỗi:** JobTracker trở thành nút cổ chai về hiệu năng và tính sẵn sàng.

Việc quá "thiên vị" cho MapReduce khiến Hadoop 1 không thể tận dụng hiệu quả tài nguyên của cụm cho các ứng dụng đa dạng.
MapReduce hoạt động tốt với các công việc xử lý dữ liệu lớn theo lô (batch-based), nhưng không phù hợp với các mô hình xử lý thời gian thực (real-time) hoặc tiệm cận thời gian thực (near real-time).

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/hadoop_in_practice_alex_holmes.pdf), mô tả luồng tương tác giữa các thành phần trong quá trình MapReduce khi không có YARN.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/3-map-reduce/process.jpeg" style="width: 800px;"/>

Xuất hiện từ Hadoop 2, YARN (Yet Another Resource Negotiator) tách vấn đề quản lý tài nguyên ra khỏi logic xử lý, trở thành nền tảng chung cho nhiều framework.
Mục tiêu là cho phép nhiều loại ứng dụng đồng thời sử dụng tài nguyên cluster một cách hiệu quả và có thể mở rộng.
Các framework như MapReduce v2 (MRv2), Spark (in cluster mode), Tez, Flink (on YARN) đều sử dụng YARN để xin tài nguyên.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), so sánh giữa Hadoop 1 và Hadoop 2 với YARN.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/4-yarn/hadoop_1_vs_2.jpeg" style="width: 800px;"/>

Một cách tổng quát, YARN thực hiện hai công việc chính:
- Phản hồi yêu cầu của người dùng thông qua việc phân bổ tài nguyên cho các ứng dụng.
- Giám sát và quản lý các tài nguyên đã phân bổ để đảm bảo sử dụng hiệu quả và ổn định.

## 2. Kiến trúc và các thành phần chính của YARN

### 2.1. ResourceManager (RM)

ResourceManager là thành phần chủ chốt của YARN, quản lý tài nguyên cho toàn bộ cụm Hadoop.

Nhiệm vụ của nó là tiếp nhận yêu cầu từ client để tạo container và phối hợp với Scheduler để quyết định thời điểm và vị trí cấp phát container, dựa trên các chính sách dùng chung tài nguyên.
Sau khi quyết định cấp phát tài nguyên, việc khởi tạo container thực tế được giao cho NodeManager.

Hai phần cốt lõi trong ResourceManager:
- **Scheduler:** chỉ đưa ra quyết định phân bổ tài nguyên; không chịu trách nhiệm quản lý vòng đời ứng dụng.
Một số thuật toán lập lịch phổ biến bao gồm:
  - **FIFO Scheduler:** xử lý các ứng dụng theo thứ tự ai đến trước được phục vụ trước.
  - **Capacity Scheduler:** cho phép chia cụm thành nhiều hàng đợi với dung lượng cố định, phù hợp cho môi trường đa người dùng.
  - **Fair Scheduler:** phân bổ tài nguyên sao cho tất cả các ứng dụng đều nhận được phần công bằng theo thời gian.
- **ApplicationsManager (AMG):** quản lý lifecycle của applications (accept/reject applications, khởi tạo ApplicationMaster, v.v.).

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf),, mô tả vị trí của ResourceManager và NodeManager trong kiến trúc YARN.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/4-yarn/resource_manager_node_manager.jpeg" style="width: 800px;"/>

Vì ResourceManager là thành phần quan trọng, nên trong các triển khai sản xuất thường có cơ chế dự phòng (High Availability - HA) để tránh điểm lỗi đơn lẻ (Single Point of Failure - SPOF).

### 2.2. NodeManager (NM)

NodeManager là tiến trình phụ chạy trên từng node của cluster và chịu trách nhiệm trực tiếp quản lý vòng đời của các container.

Nhiệm vụ của nó gồm tạo container, theo dõi hoạt động và dừng container khi cần thiết.
NodeManager nhận yêu cầu tạo container từ ResourceManager và ApplicationMaster, đồng thời liên tục gửi báo cáo trạng thái container trở lại ResourceManager.
Các báo cáo này được ResourceManager sử dụng để đưa ra quyết định lập lịch tài nguyên chính xác cho những container mới.

### 2.3. ApplicationMaster (AM)

ApplicationMaster là tiến trình điều phối trung tâm của mỗi ứng dụng chạy trên YARN.
Nó không xử lý nghiệp vụ trực tiếp mà chịu trách nhiệm quản lý toàn bộ các container của ứng dụng.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf),, mô tả kiến trúc master-slave và các thành phần chính của YARN.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/4-yarn/architecture.jpeg" style="width: 800px;"/>

ApplicationMaster gửi yêu cầu cấp tài nguyên lên ResourceManager và làm việc với NodeManager để thực sự khởi tạo container.
Trong quá trình này, ApplicationMaster phải chỉ rõ yêu cầu tài nguyên của từng container, gồm vị trí node, bộ nhớ và CPU cần thiết. Khả năng mô tả và yêu cầu tài nguyên chính xác của ApplicationMaster giúp ResourceManager lập lịch linh hoạt và tối ưu việc sử dụng tài nguyên giữa nhiều node trong cluster.

Ngoài ra, ApplicationMaster còn chịu trách nhiệm về hành vi chịu lỗi của ứng dụng: khi container bị hỏng, ApplicationMaster nhận thông báo từ ResourceManager và quyết định có tái tạo container mới hay bỏ qua sự cố.

Với mỗi framework chạy trên YARN khác nhau (như MapReduce, Spark, Tez) thường cung cấp một ApplicationMaster riêng biệt.
Vòng đời của ApplicationMaster gắn liền với vòng đời của ứng dụng, ApplicationMaster sẽ được khởi tạo khi ứng dụng bắt đầu và kết thúc khi ứng dụng hoàn thành.

### 2.4. Container

Container là tiến trình thực thi cụ thể của ứng dụng YARN, được tạo bởi NodeManager theo yêu cầu của ApplicationMaster.
ApplicationMaster cũng là một container đặc biệt do ResourceManager tạo ra khi ứng dụng bắt đầu.

Mỗi container có thể là bất kỳ tiến trình nào có thể chạy, từ một lệnh đơn giản đến một ứng dụng phức tạp.
Chính khả năng tạo và quản lý các tiến trình tùy ý trên toàn cluster đã tạo nên sức mạnh của YARN, cho phép chạy nhiều loại workload khác nhau trên một nền tảng chung.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả vị trí của Container trong kiến trúc YARN.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/4-yarn/container.jpeg" style="width: 800px;"/>

Mỗi node trong cluster có thể chạy một hoặc nhiều container, tùy thuộc vào tài nguyên sẵn có và yêu cầu của ứng dụng.
Mỗi container được cấp phát một lượng tài nguyên nhất định (CPU, bộ nhớ) và NodeManager giám sát việc sử dụng tài nguyên này để đảm bảo không vượt quá giới hạn đã định.

## 3. Luồng hoạt động của YARN

### 3.1. Chuẩn bị hệ thống trước khi nhận yêu cầu từ người dùng

Trước khi nhận yêu cầu từ người dùng, hệ thống YARN cần thực hiện các bước sau:
- **Bước 1:** Khởi động ResourceManager
- **Bước 2:** Khởi động NodeManager trên mỗi máy chủ trong cụm
- **Bước 3:** Đăng ký từng NodeManager với ResourceManager

### 3.2. Quy trình xử lý yêu cầu từ người dùng

Khi hệ thống đã sẵn sàng và nhận yêu cầu từ người dùng, quy trình xử lý diễn ra như sau:
- **Bước 1:** YARN Client lấy các file cấu hình và tài nguyên cần thiết để chạy ứng dụng từ HDFS.
- **Bước 2:** YARN Client gửi yêu cầu đến ResourceManager để chạy ứng dụng.
- **Bước 3:** ResourceManager chấp nhận yêu cầu và gửi yêu cầu đến NodeManager trên máy chủ đầu tiên.
- **Bước 4:** NodeManager chấp nhận yêu cầu và khởi chạy ApplicationMaster trên máy chủ đó.
- **Bước 5:** ApplicationMaster lấy các thông tin cấu hình và tài nguyên cần thiết từ Client.
- **Bước 6:** ApplicationMaster yêu cầu ResourceManager cấp tài nguyên cho ứng dụng.
- **Bước 7:** Khi ResourceManager chấp nhận yêu cầu, ApplicationMaster gửi yêu cầu đến các NodeManager tiếp theo để khởi chạy các tác vụ của ứng dụng.
- **Bước 8:** Các NodeManager chấp nhận yêu cầu và khởi chạy các tác vụ của ứng dụng trên máy chủ do NodeManager đó quản lý.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả luồng hoạt động của YARN trong quá trình thực thi một ứng dụng MapReduce.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/4-yarn/workflow.jpeg" style="width: 800px;"/>

- **Bước 9:** Các tác vụ của ứng dụng chạy trên các máy chủ khác nhau, có thể đọc dữ liệu cần thiết từ HDFS và gửi trạng thái của chúng cho ApplicationMaster.
- **Bước 10:** ApplicationMaster gửi trạng thái của các tác vụ cho ResourceManager và ResourceManager gửi trạng thái của các tác vụ cho YARN Client để hiển thị cho người dùng.
- **Bước 11:** Khi các tác vụ hoàn thành, kết quả được trả về ResourceManager và ResourceManager gửi thông báo cho YARN Client để hiển thị thông báo cho người dùng.
- **Bước 12:** Ứng dụng kết thúc và các tài nguyên được giải phóng.
