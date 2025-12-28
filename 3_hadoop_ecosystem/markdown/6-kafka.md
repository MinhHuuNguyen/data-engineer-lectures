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

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/problem_simple.jpeg" style="width: 500px;"/>

Sau đó, ta cần phân tích số liệu trong thời gian dài hơn, ta có thêm một ứng dụng mới có thể nhận, lưu trữ và phân tích số liệu.
Lúc này, ứng dụng ban đầu cần phải mở hai kết nối trực tiếp tới hai ứng dụng khác nhau (một để hiển thị số liệu trên dashboard và một để phân tích).
Tiếp theo, ngoài ứng dụng ban đầu, ta còn có thêm nhiều ứng dụng khác cần phải gửi số liệu tới hai ứng dụng này và ngoài hai ứng dụng này, ta còn có thêm các ứng dụng khác cần nhận số liệu để phục vụ cho các mục đích khác nhau.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả vấn đề phát sinh khi có nhiều thành phần tạo ra số liệu và nhiều thành phần sử dụng số liệu trong một hệ thống phức tạp.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/problem_complex.jpeg" style="width: 800px;"/>

### 1.2. Hệ thống Publish/Subscribe (pub/sub)

Từ vấn đề trên, ta cần một giải pháp để tách biệt giữa thành phần tạo ra số liệu và thành phần sử dụng số liệu.
Nôm na là ta cần tìm giải pháp để giảm số lượng kết nối trực tiếp giữa các thành phần trong hệ thống.

Từ hệ thống phức tạp ở trên, ta xây dựng một ứng dụng trung gian ở giữa vừa đóng vai trò nhận số liệu từ các thành phần tạo ra số liệu, vừa đóng vai trò phát số liệu tới các thành phần sử dụng số liệu.
Kết quả là ta đã xây dựng được một hệ thống messaging theo mẫu Publish/Subscribe!

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả vị trí của hệ thống pub/sub trong kiến trúc tổng thể.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/solution_pub_sub.jpeg" style="width: 800px;"/>

Publish/subscribe (pub/sub) là một mô hình đặc trưng bởi việc người gửi (publisher) của một mẩu dữ liệu (message) không gửi trực tiếp đến một người nhận cụ thể.
Thay vào đó, publisher phân loại message theo một cách nào đó, và người nhận (subscriber) đăng ký để nhận các lớp message nhất định.
Hệ thống pub/sub thường có một broker — một điểm tập trung nơi messages được publish — để hỗ trợ mô hình này.

Sau khi có hệ thống pub/sub phục vụ việc lưu trữ tạm và truyền tải các metrics, ta có thể dễ dàng thêm các hệ thống pub/sub tiếp theo để phục vụ mục đích như truyền tải logs, truyền tải hành vi người dùng ...

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả giải pháp sử dụng nhiều hệ thống pub/sub cho nhiều mục đích khác nhau trong một hệ thống phức tạp.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/solution_multiple_pub_sub.jpeg" style="width: 800px;"/>

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

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/kafka_role.jpeg" style="width: 500px;"/>

Tóm lại, Kafka cung cấp một cơ chế lưu trữ và phân phối sự kiện có thứ tự, bền vững và dễ mở rộng, giúp xây dựng các hệ thống phân tán đáng tin cậy, có khả năng phục hồi và hỗ trợ xử lý dữ liệu thời gian thực.

## 3. Các thành phần của Apache Kafka

### 3.1. Messages và Batches

Message là đơn vị dữ liệu cơ bản trong Kafka, tương tự như một bản ghi (record) hoặc một dòng (row) trong cơ sở dữ liệu thông thường.
Kafka nhìn nhận message như một chuỗi byte, cho phép lưu trữ bất kỳ loại dữ liệu nào, từ văn bản đơn giản đến các cấu trúc phức tạp hơn.

Trong một message, Key là một chuỗi byte tùy chọn được sử dụng để xác định message và thường chứa các metadata của message.
Key của một message chứa thông tin về phân vùng mà message sẽ được lưu trữ `partition_id = hash(key) mod num_partitions`.
Cách này đảm bảo các thông điệp có cùng khóa luôn được ghi vào cùng một phân vùng (khi số phân vùng giữ nguyên).

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/message.jpeg" style="width: 1000px;"/>

Để tăng hiệu quả, các thông điệp được ghi vào Kafka theo lô (batch) thay vì từng thông điệp riêng lẻ vì chi phí overhead sẽ rất lớn; gom các thông điệp lại thành batch sẽ giảm thiểu điều này.
Một batch chỉ đơn giản là một tập hợp các thông điệp, tất cả đều được sản xuất tới cùng một topic và cùng một partition.

Tất nhiên đây là một đánh đổi giữa độ trễ và thông lượng: batch càng lớn thì càng nhiều thông điệp được xử lý trên một đơn vị thời gian (thông lượng cao), nhưng thời gian để một thông điệp riêng lẻ lan truyền trong hệ thống sẽ tăng (độ trễ cao hơn).
Các batch thường được nén (compression), giúp truyền và lưu trữ dữ liệu hiệu quả hơn nhưng đổi lại tiêu tốn thêm tài nguyên xử lý (CPU).

### 3.2. Schemas

Mặc dù Kafka nhìn nhận message như một chuỗi byte không có cấu trúc, trong thực tế, ta nên áp dụng thêm cấu trúc hoặc schema cho message để dễ hiểu và xử lý dữ liệu hơn.
Có nhiều lựa chọn cho schema của messages, tùy theo nhu cầu riêng của ứng dụng như JavaScript Object Notation (JSON) và Extensible Markup Language (XML) hoặc sử dụng một framework định dạng dữ liệu nhị phân như Apache Avro.

Apache Avro là một framework để serialize và mô tả schema, thường dùng cùng với Kafka để đảm bảo dữ liệu trao đổi giữa producer/consumer có định dạng rõ ràng, nhỏ gọn và hỗ trợ evolution (thay đổi schema theo thời gian) một cách có kiểm soát.

Một số giá trị chính của Apache Avro mang lại cho Kafka:
- **Định nghĩa schema rõ ràng:** Avro cho phép mô tả cấu trúc message (field, kiểu dữ liệu, default value, logical types) dưới dạng schema (thường là JSON).
Điều này giúp người phát triển và hệ thống hiểu chính xác nội dung message.
- **Mã hóa nhị phân gọn nhẹ và nhanh:** Avro serializes dữ liệu thành định dạng nhị phân compact (không kèm tên trường), làm giảm băng thông và thời gian xử lý so với JSON thuần túy.
- **Hỗ trợ đa ngôn ngữ:** Avro có thư viện cho nhiều ngôn ngữ (Java, Python, C#, Go...), thuận tiện cho hệ phân tán nhiều thành phần viết bằng ngôn ngữ khác nhau.
- **Schema Registry & quản lý phiên bản:** Khi kết hợp với một Schema Registry, schema được lưu và quản lý tập trung.
Messages gửi vào Kafka chỉ chứa schema id (không phải toàn bộ schema), giúp tiết kiệm lưu lượng nhưng vẫn cho phép consumer biết cách giải mã.
- **Kiểm soát tương thích (compatibility):** Registry cung cấp các chế độ tương thích (BACKWARD, FORWARD, FULL) để đảm bảo schema mới không phá vỡ consumer/producers hiện có — rất quan trọng trong hệ thống phân tán sản xuất.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/schema.jpeg" style="width: 600px;"/>

Một định dạng dữ liệu nhất quán rất quan trọng trong Kafka vì nó cho phép việc ghi và đọc messages được tách rời độc lập.
Nếu hai việc này không tách rời, nếu ta cần update format message mới, các consumers phải được cập nhật trước để xử lý định dạng dữ liệu mới song song với định dạng cũ trước khi ta cập nhật producers để sử dụng định dạng mới.
Bằng cách sử dụng các schema được định nghĩa rõ ràng và lưu chúng trong một kho chung, các messages trong Kafka có thể được hiểu mà không cần phối hợp chặt chẽ giữa producers và consumers.

### 3.3. Topics và Partitions

Các messages trong Kafka được tổ chức thành các chủ đề (topics), tương tự như các bảng trong cơ sở dữ liệu truyền thống hoặc các thư mục trong hệ thống tệp.
Các topics được chia nhỏ thành các phân vùng (partitions) để tăng khả năng mở rộng và hiệu suất, trong đó, mỗi partition có được host trên một server riêng biệt.

Từ đó, hiệu suất đọc ghi của một topic có thể được tăng lên bằng cách thêm nhiều partitions và phân phối chúng trên nhiều servers.
Hơn nữa, các partitions cũng có thể được sao chép (replicated) để đảm bảo độ tin cậy và khả năng chịu lỗi.

Một topic có thể có một hoặc nhiều partitions, thứ tự của các messages trong một topic không được đảm bảo, nhưng thứ tự trong mỗi partition thì được đảm bảo.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả mối quan hệ giữa topics và partitions.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/topic_partition.jpeg" style="width: 800px;"/>

Stream là một khái niệm thường được sử dụng trong các hệ thống như Kafka, để mô tả luồng dữ liệu liên tục từ producers đến một topic của Kafka đến consumers mà không quan tâm cụ thể đến các partitions trong topic đó.

### 3.4. Producers và Consumers

Producers và Consumers có thể được coi là các khách hàng (clients) của hệ thống Kafka.

#### Producers

Producers là thành phần đầu tiên trong kiến trúc Kafka.
Producers tạo ra message mới và được gửi tới một topic cụ thể, trong các hệ thống pub/sub khác, có thể được gọi là publishers hoặc writers.

Mặc định, producer sẽ phân phối message đều lên tất cả các partition của một topic, một số trường hợp khác, producer sẽ gửi message tới các partition cụ thể.
Producer có khả năng đảm bảo độ tin cậy bằng cách ghi thông điệp vào Kafka và theo dõi sự xác nhận từ Kafka rằng thông điệp đã được ghi thành công.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/producer.jpeg" style="width: 600px;"/>

Để gửi message tới một partition cụ thể:
- **Bước 1:** producer tạo một ProducerRecord, bao gồm topic mà ta muốn gửi tin nhắn tới và value. Ngoài ra, ta có thể tùy chọn chỉ định key, partition, timestamp và/hoặc tập hợp headers.
- **Bước 2:** producer thực hiện là serialize các đối tượng key và value thành các mảng byte, để có thể truyền qua mạng.
- **Bước 3:** nếu chúng ta không chỉ định partition một cách tường minh, dữ liệu sẽ được chuyển tới partitioner.
Partitioner sẽ chọn một partition cho bản ghi, thường dựa trên key của ProducerRecord. 
Khi partition đã được chọn, producer biết chính xác bản ghi sẽ được gửi tới topic và partition nào.
- **Bước 4:** producer thêm bản ghi này vào một batch các bản ghi khác, tất cả đều sẽ được gửi tới cùng topic và partition.
Một luồng riêng biệt sẽ chịu trách nhiệm gửi các batch bản ghi này tới broker Kafka tương ứng.
- **Bước 5:** Khi broker nhận được các tin nhắn, nó sẽ gửi lại một phản hồi.
    - Nếu các tin nhắn được ghi thành công vào Kafka, broker sẽ trả về một đối tượng RecordMetadata chứa thông tin topic, partition và offset của bản ghi trong partition đó.
    - Nếu broker không thể ghi tin nhắn, nó sẽ trả về một lỗi. Khi producer nhận được lỗi, nó có thể thử gửi lại tin nhắn thêm một vài lần trước khi bỏ cuộc và trả lỗi về cho ứng dụng.

#### Consumers

Consumer là thành phần cuối cùng trong kiến trúc Kafka, chịu trách nhiệm đọc và xử lý dữ liệu từ Kafka.
Consumers nhận message mới, trong các hệ thống pub/sub khác, có thể được gọi là subscribers hoặc readers.

Consumer subscribe tới một hoặc nhiều topic và đọc các message theo thứ tự mà chúng đã được tạo trong từng partition.
Consumer đảm bảo độ tin cậy bằng cách theo dõi vị trí đọc của họ và đảm bảo rằng họ không bỏ lỡ bất kỳ thông điệp nào.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả cách mà các consumers trong một consumer group tiêu thụ các messages từ các partitions của một topic.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/consumer_group.jpeg" style="width: 800px;"/>

Consumer theo dõi những message đã tiêu thụ bằng cách lưu trữ offset của message.
Offset là một giá trị nguyên liên tục tăng và là một phần metadata mà Kafka thêm vào mỗi message khi nó được tạo.
Mỗi message trong một partition nhất định có một offset duy nhất, và message tiếp theo có offset lớn hơn.
Bằng cách lưu offset tiếp theo có thể đọc cho mỗi partition, consumer có thể dừng và khởi động lại mà không mất vị trí.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả cách mà các trường hợp consumer tiêu thụ các messages từ các partitions của một topic: có một consumer tiêu thụ từ tất cả các partitions (hình 1), có hai consumers tiêu thụ từ các partitions khác nhau (hình 2), có số lượng consumers bằng số lượng partitions (hình 3), có số lượng consumers lớn hơn số lượng partitions (hình 4), và có số lượng consumers lớn hơn số lượng partitions nhưng thuộc về các consumer groups khác nhau (hình 5).

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/consumer.jpeg" style="width: 1000px;"/>

Consumers hoạt động như một phần của consumer group, tức là một hoặc nhiều consumers cùng phối hợp để tiêu thụ một topic.

Group đảm bảo rằng mỗi partition chỉ được tiêu thụ bởi duy nhất một thành viên trong group, nếu trong group có nhiều thành viên hơn số partition, một số thành viên sẽ không tiêu thụ gì cả.
Một partition chỉ có thể được tiêu thụ bởi nhiều hơn một consumer nếu các consumers đó thuộc các consumer groups khác nhau.

### 3.5. Brokers và Clusters

Một máy chủ Kafka đơn lẻ được gọi là broker.
Broker nhận các tin nhắn từ producers, gán offset cho chúng và ghi các tin nhắn đó xuống bộ nhớ lưu trữ trên đĩa.
Broker cũng phục vụ các consumers, xử lý các yêu cầu fetch cho các partition và trả về các tin nhắn đã được publish.

Các broker được thiết kế vận hành theo dạng cụm (cluster).
Trong một cụm broker, sẽ có một broker được bầu làm controller của cụm (được bầu tự động từ các thành viên đang hoạt động của cụm).

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả một kiến trúc tổng thể của Apache Kafka với producers, brokers và consumers.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/architecture.jpeg" style="width: 500px;"/>

Controller chịu trách nhiệm các thao tác hành chính, bao gồm phân bổ partition cho các broker và giám sát sự cố broker.
Mỗi partition được sở hữu (owned) bởi một broker duy nhất trong cụm, broker đó gọi là leader của partition.
Một partition được replicate (nhân bản) sẽ được gán thêm cho các broker khác, gọi là followers của partition.

Replication cung cấp tính dư thừa cho các tin nhắn trong partition, sao cho một trong các followers có thể tiếp quản làm leader nếu có broker bị lỗi.
Tất cả producers phải kết nối tới leader để publish tin nhắn, nhưng consumers có thể fetch từ leader hoặc từ một trong các followers.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả kiến trúc với hai broker, mỗi broker là một leader cho một partition và là follower cho partition còn lại.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/broker.jpeg" style="width: 700px;"/>

Một tính năng then chốt của Apache Kafka là retention — lưu trữ bền vững các tin nhắn trong một khoảng thời gian.
Các broker Kafka được cấu hình với thiết lập retention mặc định cho các topics, hoặc giữ tin nhắn theo một khoảng thời gian (ví dụ 7 ngày) hoặc cho tới khi partition đạt tới một kích thước nhất định (ví dụ 1 GB).
Khi đạt tới giới hạn đó, tin nhắn sẽ bị hết hạn và xóa.

Như vậy, cấu hình retention định nghĩa lượng dữ liệu tối thiểu có sẵn tại bất kỳ thời điểm nào.
Các topic riêng lẻ có thể được cấu hình retention riêng để chỉ lưu trữ tin nhắn trong thời gian cần thiết.

Ví dụ, một topic tracking có thể được giữ trong vài ngày, trong khi metric ứng dụng có thể chỉ giữ vài giờ.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/multi_clusters.jpeg" style="width: 700px;"/>

Một phiên bản mở rộng hơn là kiến trúc Multi-cluster của Kafka giúp mang lại một số lợi ích như Phân tách các loại dữ liệu (segregation of data types), Cô lập vì yêu cầu bảo mật (isolation for security) và Nhiều datacenter (disaster recovery).

Khi làm việc với nhiều datacenter, thường cần sao chép tin nhắn giữa các cụm để ứng dụng trực tuyến có thể truy cập hoạt động người dùng ở cả hai site.
Kafka cung cấp công cụ MirrorMaker để replicate dữ liệu giữa các cụm.
MirrorMaker là một consumer và producer liên kết với một queue: nó tiêu thụ từ cụm nguồn và produce sang cụm đích.

Mô hình đơn giản này cho phép xây dựng các pipeline dữ liệu phức tạp — ví dụ gom dữ liệu từ hai cụm local vào một cụm tổng hợp rồi sao chép sang các datacenter khác.

## 4. Mối quan hệ giữa Apache Kafka và Apache Zookeeper

Kafka dùng ZooKeeper làm dịch vụ điều phối bên ngoài để lưu metadata của cụm (thông tin broker, topic/partition, controller election, cấu hình, v.v.).
Điều này giúp các broker Kafka đồng thuận về trạng thái cụm.

Tuy nhiên trong những năm gần đây Kafka phát triển KRaft (Kafka Raft) — một control plane nội bộ dùng Raft để quản lý metadata, làm giảm/loại bỏ phụ thuộc vào ZooKeeper cho các cụm mới.

Hình dưới đây được lấy từ cuốn sách [Kafka The Definitive Guide: Real-Time Data and Stream Processing at Scale](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/kafka_the_definitive_guide_real_time_data_and_stream_processing_at_scale_2nd_edition_gwen_shapira_todd_palino_rajini_sivaram_krit_petty.pdf), mô tả

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/with_zookeeper.jpeg" style="width: 500px;"/>

Vai trò của ZooKeeper với Kafka:
- **Lưu metadata và trạng thái cụm:** ZooKeeper lưu thông tin broker đăng ký, danh sách topic và phân vùng, một số cấu hình chạy động.
Broker và các công cụ đọc/ghi metadata từ ZooKeeper. 
- **Phát hiện broker chết & bầu controller:** Kafka dùng các ephemeral node của ZooKeeper để phát hiện broker mất kết nối; khi cần, ZooKeeper hỗ trợ cơ chế bầu broker làm controller chịu trách nhiệm phân bổ lãnh đạo phân vùng và điều phối.
