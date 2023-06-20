---
layout: post
title:  "Spark"
summary: "Spark"
author: minhhuunguyen
date: '2023-04-08 15:04:00 +1997'
category: math
thumbnail: /assets/img/posts/hello.jpg
keywords: vector
permalink: /blog/gioi-thieu-chung-ve-rest-api/
usemathjax: true
---

# Streaming data

## 1. Giới thiệu chung về streaming data

Dữ liệu có thể được sinh ra liên tục từ một hoặc nhiều nguồn.
Các nguồn dữ liệu này có thể truyền dữ liệu đồng thời.

Streaming là việc ta thu thập dữ liệu từ một hoặc nhiều nguồn và dữ liệu này thường nặng tính theo đơn vị kilobyte.

<img src="https://static.packt-cdn.com/products/9781787281202/graphics/7799ffa6-f240-4c4e-8cd4-d2c70dc9aadd.png" style="width: 700px;"/>


## 2. Giới thiệu về Kafka

Apache Kafka là một hệ thống xử lý hàng đợi theo cơ chế publish-subscribe.

Kafka còn hỗ trợ triển khai hệ thống thu thập log theo mô hình phân tán (distribute), phân chia (partition), và đồng bộ (replicate).

Kafka được thiết kế cho việc xử lý dữ liệu lớn khi đọc/ghi dữ liệu, giảm độ trễ trong quá trình truyền tải dữ liệu.

<img src="https://images.viblo.asia/eabf0b4b-2cf2-4398-a20e-9dd312a93fb7.png" style="width: 700px;"/>

### 2.1. Producer và Consumer

- Producer: Một producer có thể là bất kì ứng dụng nào có chức năng publish message vào một topic.
- Consumer: Một consumer có thể là bất kì ứng dụng nào có chức năng subscribe vào một topic và tiêu thụ các tin nhắn.

### 2.2. Cluster và Broker

Cluster là hệ thống phần cứng bao gồm nhiều Broker khác nhau, trong đó, ta có 1 Broker chính và các Broker back up.
Thông thường, một cluster bao gồm tối thiểu 3 Broker.

### 2.3. Topic, Partition và Offset

- Topic là một category hoặc feed name nơi mà message được publish.
- Partition là đoạn nhỏ được tạo ra khi chia nhỏ các topic.
- Offset là giá trị ID được cho từng phần dữ liệu trong một partition

## 3. Giới thiệu chung về Apache Spark Streaming

Spark Streaming là hệ thống stream dữ liệu có khả năng mở rộng, thông lượng cao và có khả năng chịu lỗi.

<img src="https://dezyre.gumlet.io/images/blog/spark-streaming-example/image_795716530101640689003007.png" style="width: 1000px;"/>

Spark Streaming có kiến trúc micro-batch:
- Xem dữ liệu streaming dưới góc nhìn là chuỗi nhiều batch dữ liệu
- Mỗi batch dữ liệu được sinh ra sau một khoảng thời gian nào đó
- Độ lớn của khoảng thời gian để sinh ra batch dữ liệu được gọi là batch interval
- Batch interval thường nằm trong khoảng từ 500ms đến vài giây

<img src="https://spark.apache.org/docs/2.2.0/img/streaming-flow.png" style="width: 800px;"/>

### 2.1. Discretized Stream (DStream)

DStream đại diện cho stream dữ liệu liên tục.
DStream có thể được tạo ra từ việc stream dữ liệu nguyên bản từ nguồn hoặc biến đổi từ một DStream khác.

<img src="https://cdn.analyticsvidhya.com/wp-content/uploads/2020/11/vQp083.png" style="width: 800px;"/>

DStream được đại diện bởi một chuỗi liên tục các RDD, mỗi RDD chứa dữ liệu trong một khoảng thời gian nhất định.

<img src="https://cdn.analyticsvidhya.com/wp-content/uploads/2020/11/an6Nl4.png" style="width: 800px;"/>

Các phép biến đổi được sử dụng trên DStream được chuyển hoá thành các phép biến đổi trên từng RDD trong DStream đó.
Trong thực tế, các phép biến đổi trên từng RDD trong DStream được xử lý bởi Spark và người dùng hầu như chỉ cần quan tâm đến các phép biến đổi trên DStream mà thôi.

<!-- #### Input DStreams và Receivers

Input DStream là DStream lấy dữ liệu từ nguồn.
Spark Streaming cung cấp sẵn hai loại nguồn streaming:
- Basic sources: Nguồn được Sources directly available in the StreamingContext API. Examples: file systems, and socket connections.
- Advanced sources: Sources like Kafka, Flume, Kinesis, etc. are available through extra utility classes. These require linking against extra dependencies as discussed in the linking section. -->

### 2.2. Window

Window là một hàm được sử dụng trên DStream giúp tạo ra DStream mới thông qua window length và sliding interval.

<img src="https://cdn.analyticsvidhya.com/wp-content/uploads/2020/11/i8ChIj.png" style="width: 800px;"/>
