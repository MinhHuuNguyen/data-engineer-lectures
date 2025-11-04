---
time: 09/09/2021
title: Giới thiệu về Hadoop Distributed File System (HDFS)
description:
banner_url: 
tags: [big-data]
is_highlight: false
is_published: true
---

# Hadoop

## 1. Hadoop là gì?

Hadoop là một hệ thống phân tán mã nguồn mở được thiết kế để xử lý và lưu trữ dữ liệu lớn trên các máy chủ phân tán.
Được phát triển bởi Apache Software Foundation, Hadoop đã trở thành một công cụ quan trọng trong lĩnh vực xử lý dữ liệu lớn và khai thác dữ liệu.

Nó được thiết kế để mở rộng từ một server đơn lẻ đến hàng ngàn máy tính, mỗi máy tính đều cung cấp tính toán và lưu trữ cục bộ.

Hadoop có thể xử lý dữ liệu có cấu trúc và không có cấu trúc.

<img src="https://www.edureka.co/blog/wp-content/uploads/2016/10/HADOOP-ECOSYSTEM-Edureka.jpeg" style="width: 1200px;"/>

Hệ sinh thái Hadoop bao gồm một loạt các thành phần và dự án phụ để hỗ trợ việc xử lý và quản lý dữ liệu lớn.

Ta có 3 thành phần chính:
- HDFS (Hadoop Distributed File System):
HDFS là hệ thống tệp phân tán của Hadoop, được sử dụng để lưu trữ dữ liệu lớn trên nhiều máy chủ.
- MapReduce:
MapReduce là mô hình lập trình và khung công việc dùng để xử lý dữ liệu phân tán.
Nó chia công việc thành hai phần, gọi là Map (Ánh xạ) và Reduce (Thu gọn), để thực hiện tính toán trên dữ liệu lớn.
- YARN (Yet Another Resource Negotiator):
YARN quản lý tài nguyên máy chủ và phân chia chúng cho các ứng dụng chạy trên Hadoop.
Đây là thành phần quan trọng để tối ưu hóa việc sử dụng tài nguyên.

Các thành phần khác trong hệ sinh thái của Hadoop:
- Hive:
Hive là một khung dữ liệu và truy vấn dựa trên SQL dùng để truy vấn và xử lý dữ liệu lớn trên Hadoop.
Nó biên dịch truy vấn SQL thành các công việc MapReduce.
- Pig:
Pig là một ngôn ngữ lập trình dựa trên kịch bản (scripting) để xử lý dữ liệu lớn trên Hadoop.
Nó cung cấp một cách trừu tượng hóa để thực hiện các công việc xử lý dữ liệu.
- HBase:
HBase là một cơ sở dữ liệu cột dựa trên Hadoop, được sử dụng cho lưu trữ và truy xuất dữ liệu có tính đối tượng và lớn.
- Spark:
Spark là một khung công việc xử lý dữ liệu lớn có hiệu suất cao, thường được sử dụng thay thế cho MapReduce trong một số trường hợp.
- Ambari:
Ambari là một công cụ quản lý và giám sát hệ thống Hadoop, giúp quản trị viên quản lý các tài nguyên và ứng dụng trên hệ thống Hadoop.
- ZooKeeper:
ZooKeeper là một dự án để quản lý và phân phối thông tin cấu hình và dịch vụ trên các máy chủ trong hệ thống Hadoop.
- Oozie:
Oozie là một hệ thống quản lý và lập lịch công việc trong môi trường Hadoop, cho phép bạn tự động hóa luồng công việc xử lý dữ liệu.
- Flume và Kafka: Flume và Kafka là dự án được sử dụng để thu thập và truyền dữ liệu từ nguồn khác nhau vào hệ thống Hadoop.

<img src="https://drive.google.com/uc?id=1iQqZLmqWmIXhgnyKyXaIkO5x5470x3uP" style="width: 1200px;"/>

## 2. Hadoop Distributed File System (HDFS)

### 2.1. Distributed File System (DFS)

DFS là một hệ thống tệp phân tán, cho phép lưu trữ và quản lý dữ liệu trên nhiều máy tính hoặc máy chủ trong một mạng phân tán.
Mục tiêu chính của DFS là cung cấp khả năng truy cập và quản lý tệp và dữ liệu trên một mạng rộng (WAN), cho phép người dùng và ứng dụng truy cập dữ liệu từ bất kỳ máy tính nào trong hệ thống, bất kể vị trí đặc biệt của dữ liệu đó.

<img src="https://media.geeksforgeeks.org/wp-content/cdn-uploads/20200728155638/Hadoop-HDFS-Hadoop-Distributed-File-System.jpeg" style="width: 1200px;"/>

### 2.2. Hadoop Distributed File System (HDFS)

HDFS (Hadoop Distributed File System) là một hệ thống tệp phân tán và là một trong những thành phần quan trọng nhất của hệ sinh thái Hadoop.
HDFS được thiết kế để lưu trữ và quản lý dữ liệu lớn trên một tập hợp các máy chủ phân tán, và nó cung cấp tính đáng tin cậy và khả năng mở rộng cao.
- Phân tán và lưu trữ dữ liệu lớn:
HDFS chia dữ liệu thành các khối nhỏ (thường là 128 MB hoặc 256 MB mỗi khối) và lưu trữ chúng trên nhiều máy chủ.
Điều này cho phép HDFS lưu trữ và quản lý dữ liệu lớn một cách hiệu quả.
- Tính toàn vẹn và đáng tin cậy:
HDFS đảm bảo tính toàn vẹn của dữ liệu bằng cách lưu trữ nhiều bản sao (replicas) của mỗi khối dữ liệu trên các máy chủ khác nhau.
Nếu một máy chủ hoặc khối dữ liệu bị hỏng, HDFS có khả năng phục hồi từ bản sao khác.
- Kiến trúc hai phần:
HDFS có kiến trúc hai phần gồm NameNode và DataNode.
NameNode là nút chủ quản lý metadata của hệ thống và DataNode là các nút chứa dữ liệu thực tế.
Điều này giúp phân quản lý metadata và dữ liệu thực tế, tối ưu hóa hiệu năng và khả năng mở rộng.
- Cấu trúc thư mục và tệp:
HDFS hỗ trợ cấu trúc thư mục và tệp tương tự như hệ thống tệp thông thường.
Người dùng có thể tổ chức dữ liệu vào các thư mục và tạo, sao chép, di chuyển và xóa tệp dễ dàng.
- Hỗ trợ đọc/ghi song song:
HDFS cung cấp khả năng đọc và ghi dữ liệu song song.
Điều này cho phép nhiều ứng dụng cùng truy cập và thay đổi dữ liệu trên HDFS một cách hiệu quả.
- Khả năng mở rộng dễ dàng:
HDFS có khả năng mở rộng dễ dàng bằng cách thêm máy chủ vào hệ thống.
Điều này cho phép nó xử lý dữ liệu lớn và mở rộng theo nhu cầu.

<img src="https://www.researchgate.net/profile/Zhang-Jianbo-2/publication/348387085/figure/fig4/AS:981518453309440@1611023643650/The-overview-of-the-Hadoop-Distributed-File-System-HDFS.ppm" style="width: 1200px;"/>

Kiến trúc của HDFS bao gồm ba thành phần chính:
- NameNode:
    - NameNode là thành phần quản lý của HDFS và nó đảm nhiệm nhiệm vụ quản lý metadata của hệ thống.
    Metadata bao gồm thông tin về các tệp và thư mục, bao gồm danh sách các khối dữ liệu và vị trí của chúng trên các DataNode.
    - NameNode cũng theo dõi tất cả các hoạt động đọc và ghi dữ liệu.
    - Trong một Hadoop cluster, chỉ có một NameNode duy nhất.
    Điều này làm cho NameNode trở thành một điểm yếu tiềm ẩn.
    Nếu NameNode gặp sự cố, toàn bộ hệ thống HDFS có thể bị tắt.
- DataNode:
    - DataNode là nơi thực tế lưu trữ dữ liệu.
    Mỗi DataNode chứa các khối dữ liệu (thường là 128 MB hoặc 256 MB mỗi khối) và cung cấp khả năng lưu trữ và truy cập dữ liệu.
    DataNode cũng gửi thông tin về tình trạng và khả năng sử dụng tài nguyên của nó cho NameNode.
    - Trong một cụm Hadoop, có nhiều DataNode hoạt động cùng nhau để lưu trữ dữ liệu lớn.
    Dữ liệu được phân chia thành các khối và lưu trữ trên các DataNode khác nhau, đảm bảo tính phân tán và sẵn sàng.
    - DataNode thường duy trì một số bản sao (replicas) của các khối dữ liệu.
    Số lượng bản sao có thể được cấu hình và thường là ba hoặc nhiều hơn.
    Sao lưu dữ liệu đảm bảo tính đáng tin cậy của dữ liệu và giúp phục hồi dữ liệu trong trường hợp sự cố.
- Secondary NameNode:
    - Secondary NameNode không phải là một sao lưu thay thế cho NameNode, mà thực hiện các nhiệm vụ hỗ trợ.
    Secondary NameNode thực hiện việc sao lưu metadata bằng cách thực hiện các bước sau:
        - Lấy bản sao của metadata từ NameNode
        - Lấy dữ liệu từ edit log
        - Kết hợp bản sao metadata và dữ liệu từ edit log
        - Gửi bản sao mới của metadata cho NameNode
        - Cắt edit log (edit log trimming)
    - Secondary NameNode thường được cấu hình để thực hiện các bước này theo lịch trình định kỳ, ví dụ: mỗi giờ.
    Quá trình này giúp giảm nguy cơ mất dữ liệu và cải thiện tính đáng tin cậy của hệ thống HDFS bằng cách cập nhật metadata và duy trì một phiên bản mới nhất của nó.

<img src="https://drive.google.com/uc?id=1_l69cdlf71wQNiSlvjfER3XK3qKiJuSQ" style="width: 1200px;"/>

## 3. MapReduce

MapReduce được thiết kế để xử lý và phân tích dữ liệu lớn một cách hiệu quả bằng cách phân tách công việc thành các phần nhỏ hơn có thể thực hiện song song trên nhiều máy tính.

Cấu trúc MapReduce gồm 3 bước:
- Map:
Bước Map chấp nhận dữ liệu đầu vào và thực hiện một tập hợp các phép biến đổi, tạo ra các cặp key-value.
Bước này tách dữ liệu thành các phần nhỏ và độc lập xử lý chúng trên các máy tính khác nhau.
Kết quả của bước Map là một tập hợp các cặp key-value tạo ra bởi các hàm Map.
- Shuffle and Sort:
Bước Shuffle và Sort sắp xếp và trộn các cặp key-value để đảm bảo rằng các value có cùng key được gom lại với nhau.
Điều này làm cho việc chuyển dữ liệu từ bước Map sang bước Reduce hiệu quả hơn.
- Reduce:
Bước Reduce nhận các cặp key-value sau khi đã được sắp xếp và trộn.
Nó thực hiện các phép biến đổi hoặc tính toán trên các value có cùng key để tạo ra kết quả cuối cùng.
Bước Reduce có thể thực hiện song song trên nhiều máy tính.

<img src="https://editor.analyticsvidhya.com/uploads/90908example-of-mapreduce.jpeg" style="width: 1200px;"/>

Ví dụ 1: Đếm từ trong một tài liệu văn bản lớn
- Yêu cầu:
Giả sử bạn có một tài liệu văn bản lớn (có thể là một tập hợp các sách, bài viết, hoặc văn bản từ trang web) và bạn muốn đếm số lần xuất hiện của mỗi từ trong tài liệu này bằng cơ chế MapReduce.
- Lời giải:
    - Map:
    Trong bước Map, bạn chia tài liệu thành các phần nhỏ hơn (đoạn văn bản hoặc câu).
    Tạo ra các cặp key-value, trong đó, key ở đây là từ và value số lần xuất hiện của từ đó.
    - Shuffle và Sort:
    Hệ thống MapReduce tự động sắp xếp và trộn các cặp key-value sao cho các từ cùng key được gom lại với nhau.
    - Reduce:
    Tổng hợp số lần xuất hiện của từng từ bằng cách thêm value của từng key.
    Kết quả là bạn sẽ có một danh sách các từ và số lần xuất hiện của mỗi từ trong tài liệu.

Ví dụ 2: Phân tích dữ liệu truy cập máy chủ web
- Yêu cầu:
Giả sử bạn quản lý một trang web và muốn phân tích dữ liệu truy cập để biết được thời gian nào trong ngày người dùng truy cập nhiều nhất.
Bạn có một tập hợp các tệp nhật ký máy chủ web chứa thông tin từ người dùng.
Bạn muốn sử dụng MapReduce để tìm ra thời gian trong ngày có lượng truy cập cao nhất.
- Lời giải:
    - Map:
    Thời gian có thể được tách thành giờ (ví dụ: 00:00-00:59, 01:00-01:59, và cứ thế).
    Tạo ra các cặp key-value, trong đó key là khoảng thời gian và value là số lần truy cập vào thời điểm đó.
    - Shuffle và Sort:
    Hệ thống MapReduce sẽ tự động sắp xếp và trộn các cặp key-value sao cho các cặp có cùng key (khoảng thời gian) được gom lại với nhau.
    - Reduce:
    Tổng hợp số lượng truy cập trong mỗi khoảng thời gian bằng cách thêm value của từng key.
    Kết quả sẽ cho biết khoảng thời gian nào trong ngày có lượng truy cập cao nhất.

## 4. Yet Another Resource Negotiator (YARN)

Được giới thiệu từ phiên bản Hadoop 2.0 trở đi.
YARN là một khung làm việc phân tán và quản lý tài nguyên trong môi trường xử lý dữ liệu lớn.
Nó giúp tối ưu hóa việc quản lý tài nguyên và thực hiện các ứng dụng phân tán hiệu quả hơn.

Các công việc của YARN:
- Quản lý tài nguyên:
YARN quản lý tài nguyên trong một cụm Hadoop.
- Lên lịch công việc:
YARN cho phép lên lịch và quản lý các công việc trên cụm.
- Hỗ trợ đa dạng công việc:
YARN hỗ trợ nhiều loại công việc khác nhau, bao gồm MapReduce, Spark.
- Khả năng mở rộng:
YARN được thiết kế để khái quát hóa việc quản lý tài nguyên và lên lịch, cho phép nó mở rộng dễ dàng để xử lý cụm lớn và tải công việc nặng.

## 4.1. Kiến trúc YARN:

YARN bao gồm hai thành phần chính: ResourceManager và NodeManager.
- ResourceManager:
Đây là thành phần trung tâm của YARN và quản lý tài nguyên toàn bộ cụm.
ResourceManager chịu trách nhiệm quản lý tài nguyên, lên lịch công việc, và theo dõi trạng thái của các ứng dụng.
- NodeManager:
Mỗi máy chủ trong cụm Hadoop có một NodeManager.
NodeManager quản lý tài nguyên cục bộ trên máy chủ, đảm bảo rằng tài nguyên có sẵn để thực hiện công việc và báo cáo trạng thái của tài nguyên cho ResourceManager.
- ApplicationMaster:
Mỗi ứng dụng trong cụm Hadoop có một ApplicationMaster.
ApplicationMaster chịu trách nhiệm quản lý các tài nguyên cụ thể được cấp cho ứng dụng đó.
Nó cũng theo dõi trạng thái của các tác vụ và báo cáo trạng thái cho ResourceManager.

<img src="https://drive.google.com/uc?id=1JUM6etug4feIKkLKs3BvAFPMNC12fbI_" style="width: 1200px;"/>

## 4.2. Các bước hoạt động của YARN:

Trước khi nhận yêu cầu từ người dùng:
- Khởi động ResourceManager
- Khởi động NodeManager trên mỗi máy chủ trong cụm
- Đăng ký NodeManager với ResourceManager

<img src="https://www.edureka.co/blog/wp-content/uploads/2018/06/Components-of-YARN-1.jpeg" style="width: 1200px;"/>

Khi hệ thống đã sẵn sàng và nhận yêu cầu từ người dùng:
- Bước 1: YARN Client gửi yêu cầu đến ResourceManager để chạy ứng dụng.
- Bước 2: ResourceManager chấp nhận yêu cầu và gửi yêu cầu đến NodeManager trên máy chủ đầu tiên.
- Bước 3: NodeManager chấp nhận yêu cầu và khởi chạy ApplicationMaster trên máy chủ đó.
- Bước 4: ApplicationMaster yêu cầu ResourceManager cấp tài nguyên cho ứng dụng.
- Bước 5: ResourceManager chấp nhận yêu cầu và gửi yêu cầu đến NodeManager trên máy chủ thứ hai.
- Bước 6: NodeManager chấp nhận yêu cầu và khởi chạy các tác vụ của ứng dụng trên máy chủ đó.
- Bước 7: Các tác vụ của ứng dụng chạy trên các máy chủ khác nhau và gửi trạng thái của chúng cho ApplicationMaster.
- Bước 8: ApplicationMaster gửi trạng thái của các tác vụ cho ResourceManager.
- Bước 9: ResourceManager gửi trạng thái của các tác vụ cho YARN Client.
- Bước 10: YARN Client hiển thị trạng thái của các tác vụ cho người dùng.
- Bước 11: Khi các tác vụ hoàn thành, kết quả được trả về ResourceManager và ResourceManager gửi thông báo cho YARN Client.
- Bước 12: YARN Client hiển thị thông báo cho người dùng.
