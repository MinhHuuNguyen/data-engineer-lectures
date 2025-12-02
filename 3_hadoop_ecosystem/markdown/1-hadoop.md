---
time: 10/11/2022
title: Hệ sinh thái Hadoop
description: Hệ sinh thái Hadoop là một nền tảng xử lý dữ liệu lớn được xây dựng xoay quanh khả năng lưu trữ phân tán và tính toán song song trên cụm máy chủ giá rẻ. Trung tâm của hệ sinh thái là HDFS đảm nhiệm lưu trữ dữ liệu dung lượng lớn theo dạng phân mảnh, YARN quản lý tài nguyên và lập lịch tác vụ. Nhiều thành phần mở rộng được phát triển để đáp ứng các nhu cầu khác nhau như MapReduce, Hive, HBase, Spark... Nhờ kiến trúc linh hoạt, Hadoop trở thành nền tảng phổ biến cho phân tích dữ liệu lớn, học máy và hệ thống kho dữ liệu hiện đại.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/1-hadoop/banner.jpeg
tags: [big-data, hadoop]
is_highlight: false
is_published: true
---

## 1. Tổng quan về hệ sinh thái Hadoop

Apache Hadoop là một khung phần mềm mã nguồn mở được thiết kế để xử lý và lưu trữ các tập dữ liệu rất lớn bằng cách phân tán chúng trên các cụm máy tính giá rẻ.
Được phát triển bởi Apache Software Foundation, Hadoop đã trở thành một công cụ quan trọng trong lĩnh vực xử lý dữ liệu lớn và khai thác dữ liệu.

Thiết kế của Hadoop hướng đến mở rộng quy mô và chịu lỗi: nó ưu tiên thông lượng đọc ghi cao và chạy các phép tính gần dữ liệu (data locality) để tránh nghẽn mạng.
Kết quả là Hadoop cho phép xử lý song song hàng petabyte dữ liệu, linh hoạt nâng cấp thêm máy khi cần mà không đòi hỏi phần cứng đắt tiền.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf) của tác giả Alex Holmes, mô tả tổng quan về đặc điểm của hệ sinh thái Hadoop.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/1-hadoop/idea.jpeg" style="width: 600px;"/>

Đặc điểm chính của Hadoop bao gồm:
- **Lưu trữ phân tán:** Dữ liệu được chia nhỏ thành các khối và phân phối trên nhiều node trong cụm, giúp tận dụng tối đa dung lượng lưu trữ và tăng khả năng chịu lỗi.
- **Tính toán phân tán:** Các tác vụ xử lý dữ liệu được chia nhỏ và chạy song song trên nhiều node, tận dụng sức mạnh tính toán của toàn bộ cụm.
- **Khả năng mở rộng:** Dễ dàng thêm hoặc bớt node trong cụm mà không ảnh hưởng đến hoạt động của hệ thống.

## 2. Các thành phần cốt lõi trong hệ sinh thái Hadoop

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), giới thiệu về các thành phần trong hệ sinh thái Hadoop.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/1-hadoop/ecosystem.jpeg" style="width: 1000px;"/>

Cấu trúc tổng quan của Hadoop gồm bốn thành phần chính hợp tác với nhau: **HDFS** (lưu trữ phân tán), **MapReduce** (mô hình xử lý phân tán), **YARN** (bộ điều phối tài nguyên), và **Hadoop Common** (thư viện dùng chung).
Trong đó, HDFS chịu trách nhiệm lưu trữ dữ liệu dưới dạng các khối (blocks) phân tán trên nhiều máy chủ, MapReduce chia nhỏ công việc xử lý thành các tác vụ song song, còn YARN quản lý tài nguyên và điều phối các tác vụ trong cụm.

Cách tiếp cận này giúp Hadoop lưu trữ và xử lý dữ liệu theo chiều ngang trên nhiều nút, đảm bảo dữ liệu an toàn ngay cả khi một số máy hỏng nhờ vào cơ chế nhân bản dữ liệu

### 2.1. Hadoop Distributed File System (HDFS)

HDFS (Hadoop Distributed File System) là hệ thống tệp phân tán được thiết kế để lưu trữ dữ liệu dung lượng rất lớn trên cụm máy chủ phổ thông, đồng thời đảm bảo khả năng chịu lỗi cao và thông lượng truy cập lớn.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả kiến trúc của HDFS.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/2-hdfs/architecture.jpeg" style="width: 900px;"/>

HDFS chia dữ liệu thành các khối (blocks) và phân phối chúng tới nhiều node khác nhau, kèm theo sao chép (replication) để đảm bảo dữ liệu vẫn an toàn khi một node gặp sự cố. Kiến trúc của HDFS gồm NameNode quản lý metadata và DataNode lưu trữ dữ liệu thực tế.
Mô hình này tối ưu cho các tác vụ đọc tuần tự và xử lý batch ở quy mô hàng terabyte đến petabyte.

Nhờ khả năng mở rộng tuyến tính và cơ chế tự phục hồi, HDFS trở thành lớp lưu trữ cốt lõi trong các hệ thống phân tích dữ liệu lớn và xử lý song song trong Hadoop.

Để hiểu rõ hơn về cơ chế hoạt động và các câu lệnh trong HDFS, bạn có thể tham khảo bài viết chi tiết [Hệ thống tệp phân tán Hadoop Distributed File System (HDFS)](/blog/he-thong-tep-phan-tan-hadoop-distributed-file-system-hdfs).

### 2.2. Hadoop MapReduce

Hadoop MapReduce là mô hình và framework xử lý dữ liệu lớn theo phương thức song song và phân tán trên cụm máy chủ.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả kiến trúc của Hadoop MapReduce.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/3-map-reduce/architecture.jpeg" style="width: 700px;"/>

Cơ chế hoạt động gồm hai giai đoạn: Map để phân tách dữ liệu đầu vào thành các cặp khóa–giá trị và xử lý chúng độc lập trên nhiều node, sau đó Reduce để tổng hợp, nhóm và kết xuất kết quả cuối cùng
Nhờ tận dụng tài nguyên từ toàn bộ cụm máy, MapReduce cho phép xử lý khối lượng dữ liệu rất lớn theo dạng batch với khả năng chịu lỗi cao. 

Đây là nền tảng truyền thống cho nhiều ứng dụng phân tích dữ liệu trong hệ sinh thái Hadoop.

Để hiểu rõ hơn về cơ chế hoạt động và các ví dụ về Hadoop MapReduce, bạn có thể tham khảo bài viết chi tiết [Framework xử lý dữ liệu Hadoop Map Reduce](/blog/framework-xu-ly-du-lieu-hadoop-map-reduce).

### 2.3. Yet Another Resource Negotiator (YARN)

Hadoop YARN (Yet Another Resource Negotiator) là lớp quản lý tài nguyên và lập lịch trung tâm trong hệ sinh thái Hadoop, chịu trách nhiệm phân phối tài nguyên tính toán cho các ứng dụng chạy trên cụm.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả kiến trúc của YARN.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/4-yarn/architecture.jpeg" style="width: 900px;"/>

Kiến trúc của YARN gồm ResourceManager điều phối tài nguyên toàn cụm và NodeManager quản lý từng node.
Khi một ứng dụng được gửi lên, YARN tạo ApplicationMaster để giám sát và yêu cầu tài nguyên cần thiết.

Nhờ cơ chế tách biệt giữa quản lý tài nguyên và mô hình xử lý, YARN cho phép nhiều framework như MapReduce, Spark, Tez cùng hoạt động linh hoạt trên cùng hạ tầng.

Để hiểu rõ hơn về cơ chế hoạt động và các câu lệnh trong YARN, bạn có thể tham khảo bài viết chi tiết [Lớp quản lý tài nguyên Hadoop Yet Another Resource Negotiator (YARN)](/blog/lop-quan-ly-tai-nguyen-hadoop-yet-another-resource-negotiator-yarn).

## 3. Các thành phần mở rộng phổ biến trong hệ sinh thái Hadoop

### 3.1. Hadoop Hive

Hive là một hệ thống kho dữ liệu phân tán được xây dựng trên Hadoop, cho phép truy vấn và phân tích dữ liệu lớn bằng ngôn ngữ SQL quen thuộc.

Về bản chất, Hive cung cấp lớp trừu tượng dạng bảng (table) và kho siêu dữ liệu (metastore) cho các file trên HDFS.
Người dùng viết câu lệnh HiveQL (một biến thể của SQL) để thực hiện truy vấn, sau đó Hive sẽ dịch các câu lệnh này thành các job MapReduce hoặc Tez để chạy trên cụm Hadoop.

Nhờ đó, các nhà phân tích và kỹ sư dữ liệu có thể thao tác với petabyte dữ liệu trên HDFS mà không cần lập trình MapReduce trực tiếp.
Hive thường được dùng để xây dựng Data Warehouse trên Hadoop, ví dụ lưu trữ thông tin bán hàng, log người dùng, hoặc tích hợp dữ liệu từ nhiều nguồn (quản lý bằng các bảng Hive).

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả kiến trúc của Hive.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/1-hadoop/hive.jpeg" style="width: 600px;"/>

Ví dụ minh họa: Một câu truy vấn HiveQL đơn giản như `SELECT user_id, COUNT(*) FROM logs GROUP BY user_id;` sẽ đếm số bản ghi cho mỗi người dùng trong bảng logs.
Hive tự động khởi tạo job, chạy MapReduce để thực thi phép tính này trên HDFS và trả kết quả đã tổng hợp.
Các tập lệnh lớn có thể được lên lịch bằng Oozie hoặc workflow để chạy định kỳ.

### 3.2. Hadoop Pig

Apache Pig là nền tảng xử lý dữ liệu dạng batch chạy trên Hadoop, sử dụng ngôn ngữ Pig Latin – một DSL ở mức cao trừu tượng hóa khỏi MapReduce.
Pig giúp lập trình viên không phải viết hàng trăm dòng Java cho MapReduce.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_alex_holmes.pdf), mô tả kiến trúc của Pig.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/1-hadoop/pig.jpeg" style="width: 400px;"/>

*Note: DSL – Domain-Specific Language là ngôn ngữ lập trình hoặc ngôn ngữ mô tả được thiết kế chỉ để giải quyết một nhóm vấn đề cụ thể, thay vì dùng cho mục đích chung.*
*Ví dụ: Pig Latin dùng cho ETL và xử lý dữ liệu batch trên Hadoop, SQL dùng cho truy vấn cơ sở dữ liệu quan hệ, Terraform HCL dùng cho khai báo hạ tầng, Regex dùng cho xử lý chuỗi ký tự ...*

Pig Latin sẽ được biên dịch thành DAG các job MapReduce hoặc chạy trên Tez/Spark tùy cấu hình.

*Note: DAG – Directed Acyclic Graph là đồ thị có hướng và không có chu trình, được sử dụng để mô hình hóa dòng dữ liệu hoặc chuỗi tác vụ nơi một tác vụ phụ thuộc vào tác vụ trước đó.*

Pig ngày nay ít được dùng do Spark đã thay thế, tuy nhiên, nếu bạn muốn học Pig Latin, bạn có thể tham khảo cuốn sách [Hadoop: The Definitive Guide, 4th Edition (2015)](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_the_definitive_guide_4th_edition_2015_tom_white.pdf) của tác giả Tom White.

Ví dụ dưới đây được trích từ cuốn sách trên, minh hoạ việc sử dụng Pig so sánh với việc viết MapReduce thuần tuý:

- Sử dụng Java để viết MapReduce:

```java
import java.io.IOException;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class MaxTemperatureMapper
 extends Mapper<LongWritable, Text, Text, IntWritable> {
 private static final int MISSING = 9999;

 @Override
 public void map(LongWritable key, Text value, Context context)
 throws IOException, InterruptedException {

 String line = value.toString();
 String year = line.substring(15, 19);
 int airTemperature;
 if (line.charAt(87) == '+') { // parseInt doesn't like leading plus signs
 airTemperature = Integer.parseInt(line.substring(88, 92));
 } else {
 airTemperature = Integer.parseInt(line.substring(87, 92));
 }
 String quality = line.substring(92, 93);
 if (airTemperature != MISSING && quality.matches("[01459]")) {
 context.write(new Text(year), new IntWritable(airTemperature));
 }
 }
}

public class MaxTemperatureReducer
 extends Reducer<Text, IntWritable, Text, IntWritable> {

 @Override
 public void reduce(Text key, Iterable<IntWritable> values, Context context)
 throws IOException, InterruptedException {

 int maxValue = Integer.MIN_VALUE;
 for (IntWritable value : values) {
 maxValue = Math.max(maxValue, value.get());
 }
 context.write(key, new IntWritable(maxValue));
 }
}

public class MaxTemperature {
 public static void main(String[] args) throws Exception {
 if (args.length != 2) {
 System.err.println("Usage: MaxTemperature <input path> <output path>");
 System.exit(-1);
 }

 Job job = new Job();
 job.setJarByClass(MaxTemperature.class);
 job.setJobName("Max temperature");
 FileInputFormat.addInputPath(job, new Path(args[0]));
 FileOutputFormat.setOutputPath(job, new Path(args[1]));

 job.setMapperClass(MaxTemperatureMapper.class);
 job.setReducerClass(MaxTemperatureReducer.class);
 job.setOutputKeyClass(Text.class);
 job.setOutputValueClass(IntWritable.class);

 System.exit(job.waitForCompletion(true) ? 0 : 1);
 }
}
```

- Sử dụng Pig:

```pig-latin
records = LOAD 'input/ncdc/micro-tab/sample.txt'
 AS (year:chararray, temperature:int, quality:int);
filtered_records = FILTER records BY temperature != 9999 AND
 quality IN (0, 1, 4, 5, 9);
grouped_records = GROUP filtered_records BY year;
max_temp = FOREACH grouped_records GENERATE group,
 MAX(filtered_records.temperature);
DUMP max_temp;
```

### 3.3. Hadoop HBase

HBase là cơ sở dữ liệu dạng cột phân tán được xây dựng trên HDFS, tối ưu cho việc truy cập đọc / ghi ngẫu nhiên theo thời gian thực trên các tập dữ liệu rất lớn.

Hình dưới đây được lấy từ cuốn sách [Hadoop: The Definitive Guide, 4th Edition (2015)](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_the_definitive_guide_4th_edition_2015_tom_white.pdf), mô tả kiến trúc của HBase.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/1-hadoop/hbase.jpeg" style="width: 600px;"/>

Trong HBase, dữ liệu được tổ chức thành các bảng gồm hàng (rows) và cột (columns), nhưng khác với cơ sở dữ liệu quan hệ, mỗi hàng có thể có một tập hợp cột khác nhau.
Cell là đơn vị dữ liệu cơ bản trong HBase — một ô chứa giá trị và được xác định duy nhất bởi bộ bốn: `(rowKey, columnFamily, qualifier(column), timestamp)`, trong đó:
- `rowKey`: Khóa chính của hàng, dùng để xác định và truy cập hàng.
- `columnFamily`: Tên của nhóm cột, giúp tổ chức và lưu trữ dữ liệu.
- `qualifier(column)`: Tên cụ thể của cột trong nhóm.
- `timestamp`: Dấu thời gian của phiên bản dữ liệu, cho phép lưu trữ nhiều phiên bản của cùng một ô.

Khác với các hệ quản trị quan hệ truyền thống, vốn gặp khó khăn khi mở rộng và mất nhiều tính năng khi thực hiện phân mảnh hoặc sao chép, HBase được thiết kế ngay từ đầu để mở rộng tuyến tính bằng cách chỉ cần bổ sung thêm node.
Dù không hỗ trợ SQL hay các đặc trưng quan hệ phức tạp, HBase có thể lưu trữ những bảng cực lớn, thưa dữ liệu, trên hạ tầng phần cứng phổ thông do mỗi hàng có thể có cấu trúc cột khác nhau.

### 3.4. Hadoop ZooKeeper

ZooKeeper là một dịch vụ điều phối cho các ứng dụng phân tán, cung cấp các chức năng như đồng bộ hóa, quản lý cấu hình và đặt tên trong môi trường phân tán.
Một số cơ chế điều phối quan trọng mà ZooKeeper cung cấp như khóa phân tán (distributed locks), hàng đợi phân tán (distributed queues), bầu cử (leader election).

Hình dưới đây được lấy từ cuốn sách [Hadoop: The Definitive Guide, 4th Edition (2015)](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_the_definitive_guide_4th_edition_2015_tom_white.pdf), mô tả kiến trúc của ZooKeeper.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/1-hadoop/zookeeper.jpeg" style="width: 400px;"/>

ZooKeeper không loại bỏ được lỗi một phần (partial failure) vốn là tính chất của hệ phân tán, nhưng cung cấp các công cụ an toàn và đã được kiểm chứng để xử lý các tình huống đó, giúp nhà phát triển tránh những điểm đơn lẻ gây mất tin cậy và giảm độ phức tạp khi triển khai các giao thức điều phối.

*Note: Lỗi một phần là khi mạng hoặc tiến trình gặp sự cố, gửi tin nhắn giữa hai node có thể thất bại mà không rõ kết quả — đây là lỗi một phần. ZooKeeper không che giấu hay loại bỏ bản chất này, nhưng cung cấp cơ chế để ứng dụng phát hiện trạng thái, đồng bộ hoá và phục hồi một cách an toàn.*

### 3.5. Apache Spark

Apache Spark là nền tảng xử lý dữ liệu lớn in-memory được thiết kế cho hiệu năng cao và khả năng xử lý linh hoạt.
Khác với MapReduce chỉ hoạt động theo mô hình batch, Spark giữ dữ liệu trong bộ nhớ qua nhiều bước tính toán, giúp tăng tốc đáng kể các tác vụ lặp như học máy, phân tích biểu đồ và xử lý tương tác. 
Nhờ khả năng mở rộng và tốc độ vượt trội, Spark trở thành lựa chọn phổ biến trong các hệ thống phân tích dữ liệu hiện đại.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả kiến trúc của Spark.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/5-spark/architecture.jpeg" style="width: 800px;"/>

Để hiểu rõ hơn về cơ chế hoạt động và các câu lệnh trong Spark, bạn có thể tham khảo bài viết chi tiết [Nền tảng xử lý dữ liệu lớn Apache Spark](/blog/nen-tang-xu-ly-du-lieu-lon-apache-spark).

### 3.6. Apache Kafka

Apache Kafka là nền tảng streaming phân tán được thiết kế để xử lý dữ liệu theo thời gian thực với độ tin cậy và thông lượng rất cao.

Kafka hoạt động như một hệ thống hàng đợi nhật ký (commit log), nơi dữ liệu được ghi vào các topics và lưu trữ bền vững, cho phép nhiều ứng dụng tiêu thụ song song.
Nhờ khả năng mở rộng tuyến tính, chịu lỗi tốt và độ trễ thấp, Kafka trở thành thành phần cốt lõi trong các hệ thống phân tích thời gian thực, event-driven architecture và pipeline dữ liệu lớn.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả kiến trúc của Kafka.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/6-kafka/architecture.jpeg" style="width: 800px;"/>

Để hiểu rõ hơn về cơ chế hoạt động và các câu lệnh trong Kafka, bạn có thể tham khảo bài viết chi tiết [Nền tảng streaming phân tán Apache Kafka](/blog/nen-tang-streaming-phan-tan-apache-kafka).
