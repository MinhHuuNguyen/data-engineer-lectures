---
time: 10/18/2022
title: Hệ thống tệp phân tán Hadoop Distributed File System (HDFS)
description: HDFS (Hadoop Distributed File System) là hệ thống tệp phân tán được thiết kế để lưu trữ dữ liệu dung lượng rất lớn trên cụm máy chủ phổ thông, đồng thời đảm bảo khả năng chịu lỗi cao và thông lượng truy cập lớn. Nhờ khả năng mở rộng tuyến tính và cơ chế tự phục hồi, HDFS trở thành lớp lưu trữ cốt lõi trong các hệ thống phân tích dữ liệu lớn và xử lý song song trong Hadoop.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/1-hadoop/banner.jpeg
tags: [big-data, hadoop]
is_highlight: false
is_published: true
---

## 1. Distributed File System (DFS) và Hadoop Distributed File System (HDFS)

DFS là một hệ thống tệp phân tán, cho phép lưu trữ và quản lý dữ liệu trên nhiều máy tính hoặc máy chủ trong một mạng phân tán.

Mục tiêu chính của DFS là cung cấp khả năng truy cập và quản lý tệp và dữ liệu trên một mạng rộng (WAN), cho phép người dùng và ứng dụng truy cập dữ liệu từ bất kỳ máy tính nào trong hệ thống, bất kể vị trí đặc biệt của dữ liệu đó.

Một số ưu điểm của DFS:
- **Khả năng mở rộng:** DFS cho phép mở rộng hệ thống lưu trữ bằng cách thêm nhiều máy tính hoặc máy chủ vào mạng phân tán.
- **Tính sẵn sàng cao:** DFS cung cấp khả năng chịu lỗi và phục hồi dữ liệu trong trường hợp một máy tính hoặc máy chủ gặp sự cố.
- **Hiệu suất cao:** DFS cho phép truy cập dữ liệu nhanh chóng và hiệu quả bằng cách phân phối dữ liệu trên nhiều máy tính hoặc máy chủ.
- **Tính toàn vẹn dữ liệu:** DFS đảm bảo tính toàn vẹn của dữ liệu bằng cách sử dụng các cơ chế kiểm tra lỗi và sao lưu dữ liệu.

HDFS (Hadoop Distributed File System) là một hệ thống tệp phân tán và là một trong những thành phần quan trọng nhất của hệ sinh thái Hadoop.
HDFS được thiết kế để lưu trữ và quản lý dữ liệu lớn trên một tập hợp các máy chủ phân tán, và nó cung cấp tính đáng tin cậy và khả năng mở rộng cao.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả kiến trúc của HDFS.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/2-hdfs/architecture.jpeg" style="width: 900px;"/>

Một số ưu điểm của HDFS:
- **Dữ liệu lớn:** HDFS được thiết kế để xử lý dữ liệu lớn, từ megabyte, gigabyte đến nhiều hơn terabyte và petabyte.
- **Streaming data access:** HDFS được xây dựng dựa trên ý tưởng mô hình xử lý dữ liệu hiệu quả: write-once, read-many.
Một file dữ liệu có thể được sao chép nhiều lần để đảm bảo phục vụ cho nhiều luồng đọc dữ liệu cùng lúc.
- **Phần cứng phổ thông:** HDFS được thiết kế để chạy trên phần cứng phổ thông, giúp giảm chi phí lưu trữ dữ liệu lớn.
HDFS cho phép các thành phần phần cứng có thể bị lỗi mà không ảnh hưởng đến toàn bộ hệ thống.
HDFS vẫn có thể hoạt động bình thường mà gần như người dùng không nhận thấy sự cố.

Những trường hợp **KHÔNG** nên sử dụng HDFS:
- **Cần truy cập với độ trễ thấp:** HDFS không phù hợp cho các ứng dụng yêu cầu truy cập dữ liệu với độ trễ thấp, như cơ sở dữ liệu giao dịch thời gian thực, ví dụ, trong 10 ms. Với trường hợp này, HBase hoặc Cassandra có thể là lựa chọn tốt hơn.
- **Dữ liệu nhỏ và tệp nhỏ:** HDFS không tối ưu cho việc lưu trữ và quản lý dữ liệu nhỏ hoặc tệp nhỏ vì chi phí quản lý metadata có thể vượt quá lợi ích của việc sử dụng HDFS.
- **Ghi dữ liệu song song:** Các file trong HDFS được ghi bởi một writer duy nhất tại một thời điểm. Do đó, nếu ứng dụng của bạn yêu cầu ghi dữ liệu song song từ nhiều nguồn, HDFS có thể không phải là lựa chọn tốt nhất.

## 2. Kiến trúc của HDFS

### Block

Tương tự như khái niệm block trong ổ cứng máy tính, HDFS chia dữ liệu thành các khối (block) có kích thước cố định để lưu trữ và quản lý.
Mặc định, kích thước của mỗi block trong HDFS là 128 MB.

Một file dữ liệu lớn, khi được lưu trữ trong HDFS, sẽ được chia thành nhiều block và mỗi block được lưu trữ như những đơn vị độc lập.
Nếu một file dữ liệu có kích thước nhỏ hơn kích thước block, nó sẽ chỉ sử dụng phần bộ nhớ tương ứng với kích thước của file đó.
Ví dụ: nếu một file có kích thước 100 MB, nó sẽ chỉ sử dụng 100 MB bộ nhớ trong HDFS, không phải 128 MB.

### NameNode

HDFS sử dụng kiến trúc Master-Slave, trong đó có một thành phần chính gọi là NameNode và nhiều thành phần phụ gọi là DataNode.

NameNode là thành phần quản lý của HDFS và nó đảm nhiệm nhiệm vụ quản lý metadata của hệ thống.
Metadata bao gồm thông tin về các tệp và thư mục, bao gồm danh sách các block và vị trí của chúng trên các DataNode.

NameNode cũng theo dõi tất cả các hoạt động đọc và ghi dữ liệu.
Trong một Hadoop cluster, chỉ có một NameNode duy nhất, do đó, điều này làm cho NameNode trở thành một điểm yếu tiềm ẩn.
Nếu NameNode gặp sự cố, toàn bộ hệ thống HDFS có thể bị tắt.

Hình dưới đây được lấy từ cuốn sách [Hadoop: The Definitive Guide, 4th Edition (2015)](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_the_definitive_guide_4th_edition_2015_tom_white.pdf), mô tả các bước đọc dữ liệu giữa client, NameNode và DataNode trong HDFS.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/2-hdfs/read_data.jpeg" style="width: 900px;"/>

### DataNode

DataNode là nơi thực tế lưu trữ dữ liệu và mỗi DataNode chứa các block và cung cấp khả năng lưu trữ và truy cập dữ liệu.
Trong một cụm Hadoop, có nhiều DataNode hoạt động cùng nhau để lưu trữ dữ liệu lớn.
Dữ liệu được phân chia thành các khối và lưu trữ trên các DataNode khác nhau, đảm bảo tính phân tán và sẵn sàng.

DataNode cũng có nhiệm vụ gửi thông tin về tình trạng và khả năng sử dụng tài nguyên của nó cho NameNode định kỳ để NameNode có thể quản lý và điều phối các hoạt động trong hệ thống HDFS.

DataNode thường duy trì một số bản sao (replicas) của các khối dữ liệu.
Số lượng bản sao có thể được cấu hình và thường là ba hoặc nhiều hơn.
Việc sao lưu dữ liệu đảm bảo tính đáng tin cậy của dữ liệu và giúp phục hồi dữ liệu trong trường hợp sự cố.

Với NameNode và DataNode, khi có yêu cầu đọc file dữ liệu từ client, quá trình diễn ra như sau:
- **Client mở file:** Client gọi `open()` trên `DistributedFileSystem`.
- **DistributedFileSystem hỏi NameNode:** Hệ thống gửi RPC (Remote Procedure Call - là cơ chế gọi thủ tục từ xa, cho phép một chương trình trên máy A gọi thực thi một hàm/thủ tục nằm trên máy B như thể nó đang chạy cục bộ) tới NameNode để lấy danh sách vị trí của các block đầu tiên của file.
- **NameNode trả về vị trí các block:** NameNode gửi danh sách các DataNode chứa bản sao của mỗi block, được sắp xếp theo mức độ gần với client.
NameNode gửi danh sách các DataNode chứa bản sao của mỗi block, được sắp xếp theo mức độ gần với client.
- **Trả về FSDataInputStream cho client:** Client nhận một `FSDataInputStream`, bên trong chứa `DFSInputStream` để xử lý I/O với NameNode và DataNode.
- **Client bắt đầu đọc dữ liệu:** Khi gọi `read()`, `DFSInputStream` kết nối tới DataNode gần nhất chứa block đầu tiên, bắt đầu stream dữ liệu.
- **Đọc hết một block:** Khi đến cuối block, kết nối tới DataNode được đóng.
`DFSInputStream` tự động tìm DataNode tối ưu cho block kế tiếp và tiếp tục đọc — hoàn toàn minh bạch với client.
- **Lấy thêm metadata khi cần:** Khi cần block mới vượt ngoài danh sách đã biết, `DFSInputStream` gửi thêm yêu cầu tới NameNode để lấy vị trí các block tiếp theo.
- **Xử lý lỗi và checksum:** Nếu một DataNode có lỗi, `DFSInputStream` chuyển sang DataNode khác chứa cùng block. Ghi nhớ các DataNode lỗi để tránh retry. Kiểm tra checksum, nếu block hỏng thì đọc bản sao khác và báo lỗi về NameNode.
- **Client đóng stream:** Sau khi đọc xong, client gọi `close()` trên `FSDataInputStream`.

### Secondary NameNode

Hình dưới đây được lấy từ cuốn sách [Hadoop: The Definitive Guide, 4th Edition (2015)](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_the_definitive_guide_4th_edition_2015_tom_white.pdf), mô tả các bước hoạt động của Secondary NameNode trong HDFS.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/2-hdfs/secondary_name_node.jpeg" style="width: 900px;"/>

Secondary NameNode không phải là một sao lưu thay thế cho NameNode, mà thực hiện các nhiệm vụ hỗ trợ.
Secondary NameNode thường được chạy trên một máy vật lý riêng biệt để tránh gây ảnh hưởng đến hiệu suất của NameNode.

Secondary NameNode thực hiện việc sao lưu metadata bằng cách thực hiện các bước sau:
- **Yêu cầu đóng file edits hiện tại:** Secondary NameNode yêu cầu Primary NameNode “roll” file edits đang ghi, để NameNode chuyển sang tạo một file edits mới.
- **Tải dữ liệu metadata hiện thời:** Secondary NameNode tải về bản fsimage mới nhất và file edits tương ứng từ Primary thông qua HTTP.
- **Tổng hợp metadata:** Secondary NameNode nạp fsimage, áp dụng tuần tự các giao dịch trong edits, sau đó tạo ra một file fsimage đã gộp (checkpointed fsimage).
- **Gửi bản fsimage đã gộp về NameNode:** Secondary gửi fsimage mới đó lên Primary qua HTTP, Primary lưu tạm thời với đuôi .ckpt.
- **Hoàn tất checkpoint:** Primary đổi tên file .ckpt thành fsimage chính thức, hoàn tất quá trình checkpoint.

Secondary NameNode thường được cấu hình để thực hiện các bước này theo lịch trình định kỳ, ví dụ: mỗi giờ.
Quá trình này giúp giảm nguy cơ mất dữ liệu và cải thiện tính đáng tin cậy của hệ thống HDFS bằng cách cập nhật metadata và duy trì một phiên bản mới nhất của nó.
