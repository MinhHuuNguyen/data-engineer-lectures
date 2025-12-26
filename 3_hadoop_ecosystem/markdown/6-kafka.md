---
time: 11/09/2022
title: Nền tảng streaming phân tán Apache Kafka
description: Apache Kafka là nền tảng streaming phân tán được thiết kế để xử lý dữ liệu theo thời gian thực với độ tin cậy và thông lượng rất cao. Kafka hoạt động như một hệ thống hàng đợi nhật ký (commit log), nơi dữ liệu được ghi vào các topics và lưu trữ bền vững, cho phép nhiều ứng dụng tiêu thụ song song. Nhờ khả năng mở rộng tuyến tính, chịu lỗi tốt và độ trễ thấp, Kafka trở thành thành phần cốt lõi trong các hệ thống phân tích thời gian thực, event-driven architecture và pipeline dữ liệu lớn.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/banner.jpeg
tags: [big-data, hadoop]
is_highlight: false
is_published: true
---

## 1. Vai trò của hệ thống Publish/Subscribe (pub/sub)

### 1.1. Vấn đề đặt ra

Vấn đề được đặt ra từ một hệ thống đơn giản và một nhu cầu đơn giản.

Ví dụ: Ta có một hệ thống nào đó và ta cần theo dõi các chỉ số metrics của hệ thống đó để phục vụ cho việc giám sát và cảnh báo nếu có sự cố xảy ra.
Để làm được điều này, ta mở một kết nối trực tiếp từ ứng dụng đang cần phải theo dõi tới một ứng dụng hiển thị số liệu trên dashboard và đẩy số liệu qua kết nối đó.
Đây là một giải pháp đơn giản cho một vấn đề đơn giản, và hoạt động tốt khi bạn mới bắt đầu giám sát một ứng dụng nào đó.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả về cách tương tác giữa thành phần tạo ra số liệu và thành phần sử dụng số liệu trong một hệ thống đơn giản.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/problem_simple.jpeg" style="width: 600px;"/>

Sau đó, ta cần phân tích số liệu trong thời gian dài hơn, ta có thêm một ứng dụng mới có thể nhận, lưu trữ và phân tích số liệu.
Lúc này, ứng dụng ban đầu cần phải mở hai kết nối trực tiếp tới hai ứng dụng khác nhau (một để hiển thị số liệu trên dashboard và một để phân tích).
Tiếp theo, ngoài ứng dụng ban đầu, ta còn có thêm nhiều ứng dụng khác cần phải gửi số liệu tới hai ứng dụng này và ngoài hai ứng dụng này, ta còn có thêm các ứng dụng khác cần nhận số liệu để phục vụ cho các mục đích khác nhau.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả vấn đề phát sinh khi có nhiều thành phần tạo ra số liệu và nhiều thành phần sử dụng số liệu trong một hệ thống phức tạp.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/problem_complex.jpeg" style="width: 600px;"/>

### 1.2. Hệ thống Publish/Subscribe (pub/sub)

Từ vấn đề trên, ta cần một giải pháp để tách biệt giữa thành phần tạo ra số liệu và thành phần sử dụng số liệu.
Nôm na là ta cần tìm giải pháp để giảm số lượng kết nối trực tiếp giữa các thành phần trong hệ thống.

Từ hệ thống phức tạp ở trên, ta xây dựng một ứng dụng trung gian ở giữa vừa đóng vai trò nhận số liệu từ các thành phần tạo ra số liệu, vừa đóng vai trò phát số liệu tới các thành phần sử dụng số liệu.
Kết quả là ta đã xây dựng được một hệ thống messaging theo mẫu Publish/Subscribe!

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả vị trí của hệ thống pub/sub trong kiến trúc tổng thể.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/solution_pub_sub.jpeg" style="width: 600px;"/>

Publish/subscribe (pub/sub) là một mô hình đặc trưng bởi việc người gửi (publisher) của một mẩu dữ liệu (message) không gửi trực tiếp đến một người nhận cụ thể.
Thay vào đó, publisher phân loại message theo một cách nào đó, và người nhận (subscriber) đăng ký để nhận các lớp message nhất định.
Hệ thống pub/sub thường có một broker — một điểm tập trung nơi messages được publish — để hỗ trợ mô hình này.

Sau khi có hệ thống pub/sub phục vụ việc lưu trữ tạm và truyền tải các metrics, ta có thể dễ dàng thêm các hệ thống pub/sub tiếp theo để phục vụ mục đích như truyền tải logs, truyền tải hành vi người dùng ...

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả giải pháp sử dụng nhiều hệ thống pub/sub cho nhiều mục đích khác nhau trong một hệ thống phức tạp.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/solution_multiple_pub_sub.jpeg" style="width: 600px;"/>

Với các hệ thống pub/sub, kiến trúc tổng thể của hệ thống trở nên linh hoạt hơn rất nhiều so với việc xây dựng các kết nối point-to-point giữa các thành phần trong hệ thống.

Pub/sub chuyển kiến trúc từ mô hình kết nối trực tiếp nhiều-nhiều, phân mảnh và dễ phát sinh nợ kỹ thuật, sang mô hình có điểm trung tâm, tách rời các bên tham gia và linh hoạt mở rộng — từ đó giảm độ phức tạp, tăng khả năng tái sử dụng và đơn giản hóa vận hành cho các luồng dữ liệu trong doanh nghiệp.

Tóm lại, hệ thống pub/sub giúp:
- **Tách rời publisher và subscriber:** Publisher không cần biết ai sẽ tiêu thụ message; subscriber đăng ký các lớp message mình quan tâm. Điều này giảm phụ thuộc cứng giữa thành phần.
- **Điểm tập trung để quản lý:** Broker trung tâm thu nhận và phân phối message, giúp giảm số lượng kết nối trực tiếp giữa các hệ thống và làm cho luồng dữ liệu dễ theo dõi hơn.
- **Giảm trùng lặp và đơn giản hóa vận hành:** Thay vì nhiều hệ thống queue độc lập, dùng một nền tảng pub/sub chung giảm chi phí vận hành, cập nhật và sửa lỗi một lần cho nhiều trường hợp sử dụng.
- **Dễ mở rộng và mở rộng chức năng:** Khi có yêu cầu mới (ví dụ analytics, alerting, ML), chỉ cần thêm subscriber hoặc topic mới thay vì sửa mọi publisher.
- **Tăng khả năng tái sử dụng dữ liệu:** Một message có thể được tiêu thụ đồng thời bởi nhiều subscriber với mục đích khác nhau (báo cáo, lưu trữ, ML), tránh sao chép dữ liệu giữa hệ thống.

## 2. Giới thiệu về Apache Kafka

Apache Kafka được phát triển bởi LinkedIn vào năm 2011 và sau đó được chuyển giao cho Apache Software Foundation vào năm 2012 và trở thành một dự án mã nguồn mở.

Apache Kafka được phát triển như một hệ thống nhắn tin theo mô hình publish/subscribe, nhằm giải quyết các vấn đề về truyền tải và xử lý dữ liệu trong thời gian thực với độ tin cậy cao và khả năng mở rộng linh hoạt.

Kafka thường được mô tả là một "commit log phân tán" hoặc một "nền tảng streaming phân tán".
Dữ liệu trong Kafka được lưu trữ một cách bền vững, theo thứ tự, và có thể đọc một cách xác định.
Ngoài ra, dữ liệu có thể được phân phối trong hệ thống để cung cấp khả năng bảo vệ bổ sung trước lỗi, đồng thời tạo ra những cơ hội đáng kể để mở rộng hiệu năng.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), thể hiện các loại ứng dụng chính của Apache Kafka trong hệ sinh thái dữ liệu hiện đại.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/kafka_role.jpeg" style="width: 600px;"/>

Tóm lại, Kafka cung cấp một cơ chế lưu trữ và phân phối sự kiện có thứ tự, bền vững và dễ mở rộng, giúp xây dựng các hệ thống phân tán đáng tin cậy, có khả năng phục hồi và hỗ trợ xử lý dữ liệu thời gian thực.

## 3. Các thành phần của Apache Kafka

### 3.1. Messages và Batches

Message là đơn vị dữ liệu cơ bản trong Kafka, tương tự như một bản ghi (record) hoặc một dòng (row) trong cơ sở dữ liệu thông thường.
Kafka nhìn nhận message như một chuỗi byte, cho phép lưu trữ bất kỳ loại dữ liệu nào, từ văn bản đơn giản đến các cấu trúc phức tạp hơn.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/.jpeg" style="width: 600px;"/>

Trong một message, Key là một chuỗi byte tùy chọn được sử dụng để xác định message và thường chứa các metadata của message.
Key của một message chứa thông tin về phân vùng mà message sẽ được lưu trữ `partition_id = hash(key) mod num_partitions`.
Cách này đảm bảo các thông điệp có cùng khóa luôn được ghi vào cùng một phân vùng (khi số phân vùng giữ nguyên).

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/.jpeg" style="width: 600px;"/>

Để tăng hiệu quả, các thông điệp được ghi vào Kafka theo lô (batch) thay vì từng thông điệp riêng lẻ vì chi phí overhead sẽ rất lớn; gom các thông điệp lại thành batch sẽ giảm thiểu điều này.
Một batch chỉ đơn giản là một tập hợp các thông điệp, tất cả đều được sản xuất tới cùng một topic và cùng một partition.

Tất nhiên đây là một đánh đổi giữa độ trễ và thông lượng: batch càng lớn thì càng nhiều thông điệp được xử lý trên một đơn vị thời gian (thông lượng cao), nhưng thời gian để một thông điệp riêng lẻ lan truyền trong hệ thống sẽ tăng (độ trễ cao hơn).
Các batch thường được nén (compression), giúp truyền và lưu trữ dữ liệu hiệu quả hơn nhưng đổi lại tiêu tốn thêm tài nguyên xử lý (CPU).

### 3.2. Schemas

Mặc dù Kafka nhìn nhận message như một chuỗi byte không có cấu trúc, trong thực tế, ta nên áp dụng thêm cấu trúc hoặc schema cho message để dễ hiểu và xử lý dữ liệu hơn.
Có nhiều lựa chọn cho schema của tin nhắn, tùy theo nhu cầu riêng của ứng dụng như JavaScript Object Notation (JSON) và Extensible Markup Language (XML) hoặc sử dụng một framework định dạng dữ liệu nhị phân như Apache Avro.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/.jpeg" style="width: 600px;"/>

Một định dạng dữ liệu nhất quán rất quan trọng trong Kafka vì nó cho phép việc ghi và đọc tin nhắn được tách rời độc lập.
Nếu hai việc này không tách rời, nếu ta cần update format message mới, các consumers phải được cập nhật trước để xử lý định dạng dữ liệu mới song song với định dạng cũ trước khi ta cập nhật producers để sử dụng định dạng mới.
Bằng cách sử dụng các schema được định nghĩa rõ ràng và lưu chúng trong một kho chung, các tin nhắn trong Kafka có thể được hiểu mà không cần phối hợp chặt chẽ giữa producers và consumers.

### 3.3. Topics và Partitions

Các messages trong Kafka được tổ chức thành các chủ đề (topics), tương tự như các bảng trong cơ sở dữ liệu truyền thống hoặc các thư mục trong hệ thống tệp.
Các topics được chia nhỏ thành các phân vùng (partitions) để tăng khả năng mở rộng và hiệu suất, trong đó, mỗi partition có được host trên một server riêng biệt.

Từ đó, hiệu suất đọc ghi của một topic có thể được tăng lên bằng cách thêm nhiều partitions và phân phối chúng trên nhiều servers.
Hơn nữa, các partitions cũng có thể được sao chép (replicated) để đảm bảo độ tin cậy và khả năng chịu lỗi.

Một topic có thể có một hoặc nhiều partitions, thứ tự của các messages trong một topic không được đảm bảo, nhưng thứ tự trong mỗi partition thì được đảm bảo.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả mối quan hệ giữa topics và partitions.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/topic_partition.jpeg" style="width: 600px;"/>

Stream là một khái niệm thường được sử dụng trong các hệ thống như Kafka, để mô tả luồng dữ liệu liên tục từ producers đến một topic của Kafka đến consumers mà không quan tâm cụ thể đến các partitions trong topic đó.

### 3.4. Producers và Consumers

Producers và Consumers có thể được coi là các khách hàng (clients) của hệ thống Kafka.

#### Producers

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/producer.jpeg" style="width: 600px;"/>


#### Consumers

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/consumer.jpeg" style="width: 600px;"/>

### 3.5. Brokers và Clusters

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/architecture.jpeg" style="width: 600px;"/>


Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/broker.jpeg" style="width: 600px;"/>




Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/multi_clusters.jpeg" style="width: 600px;"/>



## 4. Mối quan hệ giữa Apache Kafka và Apache Zookeeper


Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/with_zookeeper.jpeg" style="width: 600px;"/>



## 2. Giới thiệu về Apache Kafka


### 2.2. Producer - Broker - Consumer

- Producer là thành phần đầu tiên trong kiến trúc Kafka, chịu trách nhiệm sản xuất (produce) dữ liệu và truyền tải nó đến Kafka.
    - Producer nhận dữ liệu từ nguồn gốc, như ứng dụng, cảm biến hoặc dịch vụ khác, và gửi dữ liệu này vào Kafka.
    - Producer lựa chọn topic trong Kafka để gửi dữ liệu vào.
    - Producer có khả năng đảm bảo độ tin cậy bằng cách ghi thông điệp vào Kafka và theo dõi sự xác nhận từ Kafka rằng thông điệp đã được ghi thành công.
- Broker là thành phần trung tâm của kiến trúc Kafka, chịu trách nhiệm lưu trữ và quản lý thông điệp.
    - Broker nhận dữ liệu từ producer và lưu trữ chúng trong các topic và partition.
    - Dữ liệu trong các topic Kafka có thể được chia thành nhiều partitions, giúp tăng hiệu suất và khả năng mở rộng của hệ thống.
    Mỗi partition có thể tồn tại trên một máy chủ riêng biệt.
    - Broker đảm bảo độ tin cậy bằng cách lưu trữ thông điệp và sao lưu chúng.
    Thông điệp không bao giờ bị mất và có thể được đọc bởi consumer.
- Consumer là thành phần cuối cùng trong kiến trúc Kafka, chịu trách nhiệm đọc và xử lý dữ liệu từ Kafka.
    - Consumer đọc dữ liệu từ các topic và partition và xử lý nó dựa trên mục tiêu của ứng dụng.
    - Consumer có thể đọc dữ liệu từ một hoặc nhiều topic và partition.
    Điều này cho phép nó theo dõi nhiều nguồn dữ liệu cùng một lúc.
    - Consumer đảm bảo độ tin cậy bằng cách theo dõi vị trí đọc của họ và đảm bảo rằng họ không bỏ lỡ bất kỳ thông điệp nào.

### 2.3. Topic - Partition

- Topic đóng vai trò như một thư mục hoặc danh mục dữ liệu, cho phép bạn phân loại và quản lý dữ liệu dựa trên nội dung hoặc mục tiêu sử dụng.
    - Dữ liệu được gửi vào Kafka thông qua các topic.
    Mỗi topic đại diện cho một loại dữ liệu cụ thể hoặc một dự án, và nó là nơi mà dữ liệu sẽ được lưu trữ.
    - Có thể quản lý topic, tạo mới chúng và cấu hình các thuộc tính của chúng.
    Topic có thể được sử dụng bởi producer để gửi dữ liệu và bởi consumer để đọc dữ liệu.
- Partition cho phép dữ liệu trong một topic được phân tải và phân phối trên nhiều máy chủ.
    - Một topic Kafka có thể được chia thành nhiều partition, mỗi partition là một đơn vị xử lý dữ liệu độc lập.
    - Sử dụng partition, Kafka tối ưu hiệu suất và khả năng mở rộng.
    Mỗi partition có thể tồn tại trên một máy chủ riêng biệt và xử lý dữ liệu riêng lẻ.
    - Mỗi partition có thể có nhiều bản sao để đảm bảo độ tin cậy và không bao giờ bị mất dữ liệu.
    Kafka quản lý sự phân tải của dữ liệu trên các partition và sao lưu thông điệp theo cách mà bạn không cần phải lo lắng về điều đó.
