---
time: 11/09/2022
title: 
description: 
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/banner.jpeg
tags: [big-data, hadoop]
is_highlight: false
is_published: false
---

## 1. Giới thiệu về streaming data

Dữ liệu trực tiếp (streaming data) là một loại dữ liệu mà dữ liệu được truyền đi và nhận trong thời gian thực, thay vì được tải về và lưu trữ trước khi xử lý.

Điều này có nghĩa rằng dữ liệu được truyền từ nguồn gốc đến máy tính hoặc thiết bị khác một cách liên tục và không bị ngắt quãng.

<img src="https://static.packt-cdn.com/products/9781787281202/graphics/7799ffa6-f240-4c4e-8cd4-d2c70dc9aadd.jpeg" style="width: 1200px;"/>

### 1.1. Batch Processing (Xử lý theo lô):

- Tính chất:
    - Xử lý dữ liệu theo từng lô hoặc khối dữ liệu cố định tại một thời điểm.
    - Dữ liệu được lưu trữ và xử lý trong các chu kỳ rõ ràng.
    - Độ phức tạp thấp hơn.
- Thời gian xử lý:
    - Xử lý trong khoảng thời gian cố định và không yêu cầu xử lý ngay lập tức sau khi nó xuất hiện.
    - Thời gian phản hồi chậm hơn.
- Ứng dụng:
    - Phù hợp cho các tác vụ có thể được lên kế hoạch và không cần phản hồi ngay lập tức, các nhiệm vụ đòi hỏi xử lý toàn bộ tập dữ liệu hoặc tập dữ liệu lớn.

### 1.2. Stream Processing (Xử lý dữ liệu trực tiếp):

- Tính chất:
    - Xử lý dữ liệu ngay lập tức khi nó xuất hiện, không chờ đợi cho đến khi có một lô dữ liệu đầy đủ.
    - Độ phức tạp cao hơn.
- Thời gian xử lý:
    - Xử lý liên tục và theo thời gian thực, cho phép phản hồi ngay lập tức khi có dữ liệu mới.
    - Thời gian phản hồi nhanh hơn.
- Ứng dụng:
    - Phù hợp cho các ứng dụng đòi hỏi xử lý dữ liệu ngay lập tức, ví dụ: dữ liệu cảm biến, dữ liệu truyền phát trực tiếp, dữ liệu tài chính, crypto.

## 3. Giới thiệu về Apache Spark Streaming

### 3.1. So sánh giữa Apache Spark Streaming và Apache Kafka

Apache Spark Streaming và Apache Kafka là hai công nghệ quan trọng và thường được sử dụng trong lĩnh vực xử lý dữ liệu thời gian thực và xử lý dữ liệu lớn.
Tuy cả hai đều có vai trò quan trọng trong hệ thống xử lý streaming data, nhưng chúng có mục tiêu và tính năng khác nhau.

- Apache Kafka:
    - Là hệ thống hàng đợi tin nhắn phân tán, được thiết kế để truyền tải và lưu trữ dữ liệu thời gian thực.
    - Không phải là một công cụ xử lý streaming data mà thay vào đó tập trung vào việc truyền tải dữ liệu giữa các hệ thống.
- Apache Spark Streaming:
    - Là một thành phần của Apache Spark, chủ yếu được sử dụng cho việc xử lý và biến đổi dữ liệu thời gian thực.
    - Cung cấp khả năng tích hợp với các phần khác của Spark như Spark SQL và MLlib để thực hiện xử lý phức tạp trên dữ liệu thời gian thực.
- Sự kết hợp:
Kafka và Spark Streaming được sử dụng cùng nhau trong các ứng dụng xử lý dữ liệu thời gian thực.
Kafka được sử dụng để truyền tải dữ liệu đến Spark Streaming, nơi dữ liệu được xử lý và phản hồi trong thời gian thực.

### 3.2. Giới thiệu chung

Apache Spark Streaming là một mô-đun của Apache Spark, một hệ thống xử lý dữ liệu phân tán mã nguồn mở.

Spark Streaming giúp xử lý streaming data, cho phép bạn xử lý dữ liệu khi nó được tạo ra hoặc truyền tải đến hệ thống mà không cần lưu trữ và xử lý dữ liệu sau khi nó được nhận.
Nó cho phép việc giám sát thời gian thực, phát hiện sự cố, và tạo ra báo cáo thời gian thực.

<img src="https://dezyre.gumlet.io/images/blog/spark-streaming-example/image_795716530101640689003007.jpeg" style="width: 1200px;"/>

- Xử lý dữ liệu thời gian thực:
Spark Streaming cho phép bạn xử lý dữ liệu thời gian thực mà không cần đợi đến khi dữ liệu được tập trung và lưu trữ hoặc xử lý sau này.
Điều này rất quan trọng trong các tình huống đòi hỏi phản hồi nhanh và quyết định dựa trên thông tin mới.
- Biến đổi và tính toán dữ liệu:
Spark Streaming cung cấp các công cụ để biến đổi và tính toán dữ liệu theo từng micro-batch.
Điều này cho phép bạn thực hiện các phân tích, lọc, và tính toán trên streaming data.
- Kết hợp với dữ liệu tĩnh:
Spark Streaming có tích hợp với Apache Spark, cho phép bạn kết hợp xử lý streaming data với dữ liệu tĩnh, giúp tạo ra các ứng dụng phức tạp và mạnh mẽ.

<img src="https://spark.apache.org/docs/2.2.0/img/streaming-flow.jpeg" style="width: 1200px;"/>

### 3.3. Kiến trúc của Apache Spark Streaming

Spark Streaming là một mô-đun của Apache Spark và sử dụng kiến trúc dựa trên micro-batch để xử lý streaming data.
- Xem dữ liệu streaming dưới góc nhìn là chuỗi nhiều batch dữ liệu
- Mỗi batch dữ liệu được sinh ra sau một khoảng thời gian nào đó
- Độ lớn của khoảng thời gian để sinh ra batch dữ liệu được gọi là batch interval
- Batch interval thường nằm trong khoảng từ 500ms đến vài giây

<img src="https://cdn.analyticsvidhya.com/wp-content/uploads/2020/11/vQp083.jpeg" style="width: 1200px;"/>

<img src="https://cdn.analyticsvidhya.com/wp-content/uploads/2020/11/an6Nl4.jpeg" style="width: 1200px;"/>

Spark Streaming gồm các thành phần:
- Input Data:
    - Streaming data được gửi đến Spark Streaming từ các nguồn như Kafka, Flume, socket, HDFS, và nhiều nguồn khác.
    - Dữ liệu này được chia thành các đợt nhỏ gọi là micro-batch và sau đó được xử lý.
- Spark Streaming Context:
    - Spark Streaming bắt đầu bằng việc tạo một StreamingContext, đây là điểm khởi đầu cho ứng dụng Spark Streaming.
    - StreamingContext được cấu hình để xác định thời gian của mỗi micro-batch và cách xử lý dữ liệu.
- DStream (Discretized Stream): là một khái niệm quan trọng trong Spark Streaming.
    - Đại diện cho dữ liệu trực tiếp được chia thành các RDD (Resilient Distributed Dataset) nhỏ trong từng micro-batch.
    - DStream cho phép bạn thực hiện các phép biến đổi và tính toán trên dữ liệu.
- Xử lý DStream: DStream hỗ trợ các phép biến đổi dựa trên trạng thái và không có trạng thái.
    - Phép biến đổi dựa trên trạng thái (stateful transformations):
        - Đòi hỏi lưu trữ trạng thái của dữ liệu qua các micro-batch liền kề.
        - Cần duyệt qua nhiều micro-batch để tính toán thông tin trạng thái
        - Ví dụ: tính tổng cộng tích lũy, đếm sự kiện trong một khoảng thời gian, sự thay đổi theo thời gian ...
    - Phép biến đổi không có trạng thái (stateless transformations):
        - Không lưu trữ thông tin về trạng thái trước đó và chỉ xử lý dữ liệu trong mỗi micro-batch riêng lẻ.
        - Chỉ cần thực hiện tính toán trên dữ liệu trong từng micro-batch mà không quan tâm đến thông tin lịch sử.
- Output Operations: Sau khi xử lý, có thể gửi kết quả xử lý đến nhiều đích khác nhau:
    - HDFS
    - Database
    - Logging
    - Apache Kafka
    - ...
- Driver Program:
Spark Streaming Context chạy trên driver program của ứng dụng Spark, và nó tạo ra các công việc (jobs) để xử lý dữ liệu trực tiếp trên các executor.
- Windows Operations:
Spark Streaming hỗ trợ các phép biến đổi trên cửa sổ dữ liệu, cho phép bạn thực hiện các phép biến đổi trên một khoảng thời gian cố định.
    - Window size: là khoảng thời gian trong đó bạn muốn thực hiện xử lý dữ liệu.
        - Ví dụ, nếu bạn muốn tính toán tổng cộng của dữ liệu trong mỗi giờ, thì kích thước cửa sổ sẽ là 1 giờ.
    - Sliding interval: là khoảng thời gian sau mỗi lần thực hiện xử lý trong cửa sổ.
    Khoảng thời gian này thường ngắn hơn kích thước cửa sổ.
        - Ví dụ, nếu bạn muốn tính toán tổng cộng mỗi giờ và mỗi 15 phút, khoảng thời gian trượt sẽ là 15 phút.

<img src="https://cdn.analyticsvidhya.com/wp-content/uploads/2020/11/i8ChIj.jpeg" style="width: 1200px;"/>

### 3.4. Bước hoạt động của Spark Streaming

- Bước 1: Tạo và cấu hình StreamingContext:
    - StreamingContext được tạo bằng cách truyền SparkContext và batch interval cho nó.
    - Batch interval là khoảng thời gian để sinh ra một micro-batch.
    - StreamingContext cũng có thể được tạo bằng cách khôi phục từ checkpoint.
- Bước 2: Tiếp nhận data và tạo DStream:
    - Dữ liệu được nhận từ các nguồn khác nhau như Kafka, Flume, socket, HDFS, và nhiều nguồn khác.
    - Mỗi micro-batch dữ liệu trực tiếp được biến đổi thành một DStream, là một chuỗi các RDD.
    - DStream là đơn vị cơ bản để xử lý dữ liệu trực tiếp.
- Bước 3: Xử lý DStream:
    - DStream được xử lý bằng cách áp dụng các phép biến đổi và tính toán trên từng micro-batch.
    - Phép biến đổi này có thể làm thay đổi cấu trúc dữ liệu, tính toán tổng hợp, lọc, hoặc thực hiện các phân tích trên dữ liệu.
- Bước 4: Gửi Kết Quả:
    -  Kết quả xử lý có thể được gửi đến các đích khác nhau như lưu trữ dữ liệu hoặc gửi thông báo thời gian thực.

Ví dụ:
Bước 1: Tạo và cấu hình StreamingContext

```python
from pyspark import SparkContext
from pyspark.streaming import StreamingContext

# Tạo một SparkContext
sc = SparkContext("local[2]", "SparkStreamingExample")

# Tạo một StreamingContext với chu kỳ 1 giây
ssc = StreamingContext(sc, 1)
```

Bước 2: Tạo DStream từ Kafka
```python
from pyspark.streaming.kafka import KafkaUtils

# Thiết lập thông tin Kafka
kafka_params = {
    "metadata.broker.list": "localhost:9092",  # Địa chỉ máy chủ Kafka
    "auto.offset.reset": "smallest"  # Xác định điểm bắt đầu
}

# Tạo một DStream từ Kafka topic "my-topic"
kafka_stream = KafkaUtils.createStream(
    ssc,
    "localhost:2181",  # Địa chỉ máy chủ ZooKeeper
    "my-consumer-group",
    {"my-topic": 1},  # Số luồng xử lý
    kafka_params
)
```

Bước 3: Xử lý DStream
```python
# Xử lý dữ liệu trực tiếp: Ví dụ đơn giản - đếm số lượng từ trong mỗi micro-batch
word_counts = kafka_stream.flatMap(lambda x: x[1].split(" ")).countByValue()
```

Bước 4: Gửi Kết Quả
```python
# Gửi kết quả đến Kafka topic "result-topic"
word_counts.foreachRDD(lambda rdd: rdd.foreachPartition(send_to_kafka))
```
