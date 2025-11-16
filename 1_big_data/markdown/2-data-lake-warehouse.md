---
time: 09/13/2022
title: Mô hình lưu trữ dữ liệu và quy trình xử lý dữ liệu
description: Trong bối cảnh dữ liệu ngày càng trở thành tài sản chiến lược, các tổ chức cần nắm rõ cách dữ liệu được lưu trữ, tổ chức và xử lý để tối ưu hoá khả năng phân tích, khai thác giá trị và đảm bảo tính sẵn sàng. Các ý tưởng thiết kế hệ thống lưu trữ dữ liệu và quy trình xử lý dữ liệu cũng như các công cụ giúp triển khai từng phần trong thiết kế hệ thống đóng vai trò quan trọng trong việc xây dựng hệ thống dữ liệu hiệu quả.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/banner.jpeg
tags: [big-data]
is_highlight: false
is_published: true
---

## 1. Mô hình lưu trữ dữ liệu

### 1.1. Dữ liệu có cấu trúc

Để lưu trữ dữ liệu có cấu trúc, chúng ta thường sử dụng các hệ quản trị cơ sở dữ liệu quan hệ (RDBMS - Relational Database Management System) như MySQL, PostgreSQL, Oracle, SQL Server.

Để hiểu rõ hơn về các hệ quản trị cơ sở dữ liệu quan hệ (RDBMS), bạn có thể tham khảo bài viết về [Hệ quản trị cơ sở dữ liệu quan hệ (RDBMS)](/blog/he-quan-tri-co-so-du-lieu-quan-he-rdbms/).

### 1.2. Dữ liệu bán cấu trúc

Dữ liệu bán cấu trúc là dữ liệu không tuân theo một schema cố định như bảng quan hệ, nhưng vẫn chứa thông tin mô tả cấu trúc (như thẻ XML, cặp key–value trong JSON), giúp ta truy vấn và xử lý được.

Ví dụ: JSON, XML, YAML, log events ...

```json
{
  "id": 1,
  "ho_ten": "Nguyễn Văn A",
  "email": "a@example.com",
  "so_thich": ["bóng đá", "âm nhạc"],
  "dia_chi": {
    "tp": "Hà Nội",
    "quan": "Cầu Giấy"
  }
}
```

Để lưu trữ dữ liệu bán cấu trúc, chúng ta thường sử dụng các hệ quản trị cơ sở dữ liệu NoSQL (Not Only SQL) như:
- Nhóm **Document store** - Lưu trữ tài liệu: MongoDB, CouchDB.
- Nhóm **Key-Value store** - Lưu trữ cặp khóa-giá trị: Redis, DynamoDB (trong đó, DynamoDB hỗ trợ cả mô hình document như Document store).
- Nhóm **Wide-column Store** - Lưu trữ cột rộng: Apache Cassandra, HBase.
- Nhóm **Graph Database** - Cơ sở dữ liệu đồ thị: Neo4j, Amazon Neptune.

#### MongoDB - Nhóm Document store

MongoDB là hệ CSDL NoSQL dạng document, mã nguồn mở, đa nền tảng.
Lưu dữ liệu trong các document JSON-like (dạng BSON – Binary JSON).

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/document_store.jpeg" style="width: 800px;"/>

Mô hình dữ liệu của MongoDB gồm 3 cấp độ: Database -> Collection -> Document.

Ví dụ: Xét database "Customers", trong database này có collection "Users" và collection "Orders".
Một document trong collection "Users" có thể có cấu trúc như sau:

```json
{
  "_id": ObjectId("..."),
  "name": "Tran Thi C",
  "age": 25,
  "emails": ["c1@example.com", "c2@example.com"],
  "address": {
    "city": "Ho Chi Minh",
    "district": "1"
  }
}
```

Để truy vấn dữ liệu trong MongoDB, ta sử dụng ngôn ngữ truy vấn MongoDB Query Language (MQL).

Ví dụ: Truy vấn tất cả người dùng có tuổi lớn hơn 20 trong collection "Users":

```javascript
db.Users.find({ age: { $gt: 20 } })
```

#### Redis - Nhóm Key-Value store

Redis là hệ CSDL NoSQL dạng key-value, mã nguồn mở, đa nền tảng.
Lưu trữ dữ liệu dưới dạng cặp khóa-giá trị (key-value pairs) và đặc biệt, Redis lưu trữ dữ liệu trong bộ nhớ (in-memory), giúp truy xuất dữ liệu rất nhanh.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/key_value_store.jpeg" style="width: 800px;"/>

Mô hình dữ liệu của Redis rất đơn giản, gồm các key và value, trong đó key là chuỗi (string) và value có thể là nhiều kiểu dữ liệu khác nhau như string, list, set, hash, sorted set ...

Ví dụ: Để lưu trữ thông tin người dùng trong Redis, ta có thể sử dụng key là "user:1" và value là một hash chứa các trường thông tin:

```
HMSET user:1001 name "Nguyen Huu Minh" age 30 email "minh@example.com"
```

Để truy vấn dữ liệu trong Redis, ta sử dụng các lệnh như:

```
HGETALL user:1001
HGET user:1001 name
```

#### Apache Cassandra - Nhóm Wide-column Store

Apache Cassandra là CSDL NoSQL phân tán mã nguồn mở, dùng mô hình wide-column.
Apache Cassandra dược thiết kế để xử lý khối lượng dữ liệu rất lớn và chạy trên nhiều node, nhiều datacenter, chịu lỗi tốt

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/wide_column_store.jpeg" style="width: 800px;"/>

Mô hình dữ liệu của Cassandra gồm các thành phần chính: Keyspace -> Table -> Partition key -> Clustering column.

Ví dụ: Xét keyspace (tương tự như database) "ecommerce", trong keyspace này có table "user_activity".
Một bảng trong Cassandra có thể có cấu trúc như sau:

```sql
CREATE TABLE user_activity (
    user_id UUID,
    activity_time TIMESTAMP,
    activity_type TEXT,
    details TEXT,
    PRIMARY KEY (user_id, activity_time)
) WITH CLUSTERING ORDER BY (activity_time DESC);
```

Trong ví dụ này, ta sử dụng:
- `user_id` làm partition key: → mọi activity của cùng 1 user nằm cùng 1 partition → truy vấn lịch sử của user rất nhanh.
- `activity_time` làm clustering column: trong mỗi partition (mỗi user), các dòng được sắp theo activity_time (thường DESC để lấy bản ghi mới nhất).

Để truy vấn dữ liệu trong Cassandra, ta sử dụng ngôn ngữ truy vấn Cassandra Query Language (CQL).

#### Neo4j - Nhóm Graph Database

Neo4j là hệ CSDL NoSQL dạng đồ thị (graph database), mã nguồn mở, đa nền tảng.
Các cơ sở dữ liệu đồ thị phù hợp để lưu trữ và truy vấn các dữ liệu có quan hệ phức tạp như mạng xã hội, hệ thống gợi ý, quản lý chuỗi cung ứng ...

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/graph_database.jpeg" style="width: 800px;"/>

Lưu trữ dữ liệu dưới dạng các nút (nodes), các cạnh (relationships) và các thuộc tính (properties).
- **Node (đỉnh):** đại diện cho thực thể. Ví dụ: người dùng User.
- **Relationship (cạnh):** quan hệ giữa các node. Ví dụ: quan hệ FRIEND, LIKES, FOLLOWS…
- **Property:** cặp key–value gắn với node hoặc relationship. Ví dụ: trên node User có name, age, city; trên relationship FRIEND có since.

Ví dụ: Xét một mạng xã hội đơn giản với các người dùng và quan hệ bạn bè giữa họ.

```cypher
CREATE
  (:User {name: "An",   age: 25, city: "Hanoi"}),
  (:User {name: "Binh", age: 27, city: "Hanoi"}),
  (:User {name: "Chi",  age: 24, city: "HCM"});

MATCH (a:User {name: "An"}),
      (b:User {name: "Binh"}),
      (c:User {name: "Chi"})
CREATE
  (a)-[:FRIEND {since: 2020}]->(b),
  (b)-[:FRIEND {since: 2021}]->(c),
  (a)-[:FRIEND {since: 2022}]->(c);
```

### 1.3. Dữ liệu phi cấu trúc

Dữ liệu phi cấu trúc là dữ liệu không có cấu trúc rõ ràng hoặc không tuân theo một schema cố định như dữ liệu hình ảnh, video, âm thanh, tệp văn bản ...

Để lưu trữ dữ liệu phi cấu trúc, chúng ta thường sử dụng các hệ thống Data Lake, lưu trữ tệp phân tán như HDFS (Hadoop Distributed File System) hoặc các dịch vụ lưu trữ đám mây như Amazon S3, Google Cloud Storage, Microsoft Azure Blob Storage.
Dữ liệu phi cấu trúc thường được lưu trữ đơn giản trên các phần cứng lưu trữ kết hợp với phần mềm quản lý dữ liệu để tổ chức và truy xuất dữ liệu hiệu quả.

Tuy nhiên, trong thời gian gần đây, xuất hiện một hệ quản trị cơ sở dữ liệu mới được sử dụng rất nhiều trong việc lưu trữ và truy vấn dữ liệu phi cấu trúc, đó là Vector Database - được sử dụng rộng rãi trong các ứng dụng AI, đặc biệt là các ứng dụng liên quan đến xử lý ngôn ngữ tự nhiên (NLP) và thị giác máy tính (Computer Vision) và các hệ thống tìm kiếm nâng cao.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/vector_database.jpeg" style="width: 800px;"/>

Trong Vector database, mỗi vector đại diện cho một đối tượng dữ liệu (hình ảnh, văn bản, âm thanh ...) trong không gian đa chiều.

Mỗi bản ghi (record) trong vector DB thường có 3 phần chính:
- `id`: khoá định danh (string/number), ví dụ: `"doc_001"`.
- `vector`: embedding, mảng số thực, ví dụ: `[0.12, -0.03, 0.98, ...]`.
- `metadata` (tuỳ chọn): thông tin phụ để lọc, ví dụ: `{"title": "Giới thiệu vector DB", "tags": ["database", "ai"], "lang": "vi"}`.

| id      | vector (embedding)     | metadata                                       |
| ------- | ---------------------- | ---------------------------------------------- |
| doc_001 | [0.12, -0.03, 0.98, …] | {"title": "...", "tags": ["ai"], "lang": "vi"} |
| doc_002 | [0.31, 0.22, -0.45, …] | {"title": "...", "tags": ["db"], "lang": "en"} |

Vector database xây dựng chỉ mục (index) chuyên cho vector để tăng tốc tìm kiếm, ví dụ: IVF, HNSW, PQ (Product Quantization),…

Khi truy vấn, hệ thống dùng phép đo độ giống nhau giữa vector truy vấn $q$ và vector trong DB như:
- Cosine similarity (góc giữa 2 vector)
- Hoặc khoảng cách Euclid, dot product ...

Ví dụ: Người dùng cần tìm kiếm hình ảnh thông qua câu mô tả "chú mèo đang chơi với quả bóng".
- Bước 1: Chuyển câu mô tả thành vector truy vấn $q$ bằng mô hình embedding (như CLIP, BERT, …).
- Bước 2: Tìm kiếm trong vector DB các vector gần giống với $q$ dựa trên phép đo độ giống nhau đã chọn.
- Bước 3: Trả về các hình ảnh tương ứng với các vector tìm được.

Một số công cụ vector database phổ biến bao gồm Pinecone, Weaviate, Milvus, FAISS (Facebook AI Similarity Search).

## 2. Data Lake và Data Warehouse

### 2.1. Data Lake - Hồ dữ liệu

**Định nghĩa:** Data Lake là một hệ thống lưu trữ dữ liệu quy mô lớn, không có sự cấu trúc cố định, cho phép lưu trữ mọi loại dữ liệu, bao gồm dữ liệu có cấu trúc, bán cấu trúc và phi cấu trúc.

Nói cách khác, Data Lake gồm một phần cứng để lưu trữ dữ liệu như một ổ cứng máy tính đi kèm với một phần mềm quản lý dữ liệu giúp tổ chức và truy xuất dữ liệu lớn một cách hiệu quả.

Hình ảnh dưới đây được lấy từ tài liệu của DataBricks mô tả Data Lake:

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/lake.jpeg" style="width: 500px;"/>

- **Ưu điểm:**
    - Linh hoạt trong việc lưu trữ các loại dữ liệu khác nhau như cơ sở dữ liệu quan hệ, hình ảnh, video, âm thanh, tệp văn bản ...
    - Giá thành thấp khi mở rộng lưu trữ.
    - Là xuất phát điểm tốt cho các hệ thống lưu trữ dữ liệu.
    - Hỗ trợ các trường hợp sử dụng AI do có thể lưu trữ dữ liệu thô.

- **Nhược điểm:**
    - Hiệu suất truy vấn thấp hơn so với Data Warehouse do không có cấu trúc cố định.
    - Có thể trở thành "đầm lầy dữ liệu" không đáng tin cậy nếu không được quản lý đúng cách.
    - Có thể gặp phải các vấn đề trong việc quản trị dữ liệu như bảo mật, quyền truy cập và tuân thủ quy định.
    - Vẫn cần sử dụng đi kèm với các database hoặc data warehouse.

Một số công nghệ phổ biến để xây dựng Data Lake bao gồm:
- **Apache Hadoop với HDFS (Hadoop Distributed File System):**
HDFS đóng vai trò là hệ thống lưu trữ cốt lõi trong hệ sinh thái Apache Hadoop.
HDFS cho phép phân mảnh dữ liệu và lưu trữ trên nhiều nút khác nhau, đảm bảo khả năng chịu lỗi và mở rộng linh hoạt.
Nền tảng này đặc biệt phù hợp cho các bài toán xử lý dữ liệu lớn theo mô hình phân tán.
- **Amazon S3 (Simple Storage Service):**
Amazon S3 là dịch vụ lưu trữ đối tượng trên nền tảng đám mây của AWS, cung cấp khả năng lưu trữ linh hoạt, độ bền dữ liệu cao và truy xuất toàn cầu.
S3 hỗ trợ nhiều lớp lưu trữ tối ưu chi phí và tích hợp chặt chẽ với các dịch vụ phân tích dữ liệu của AWS, thích hợp cho cả lưu trữ dữ liệu thô và dữ liệu phục vụ phân tích.
- **Azure Data Lake Storage:**
Azure Data Lake Storage là dịch vụ lưu trữ được tối ưu hóa cho phân tích dữ liệu quy mô lớn trên nền tảng Microsoft Azure.
Dịch vụ hỗ trợ lưu trữ không giới hạn, quản lý phân quyền chi tiết và tích hợp sâu với các công cụ phân tích như Azure Databricks và Azure Synapse.
- **Google Cloud Storage:**
Google Cloud Storage cung cấp khả năng lưu trữ đối tượng có tính sẵn sàng cao, bền vững và hiệu năng ổn định trên nền tảng Google Cloud.
Dịch vụ hỗ trợ nhiều lớp lưu trữ, tích hợp tốt với hệ sinh thái dữ liệu của Google như BigQuery hay Dataflow, đồng thời đảm bảo hiệu quả về chi phí cho nhiều nhóm khối lượng công việc khác nhau.

Để hiểu rõ hơn về các công cụ trên, bạn có thể tham khảo bài viết:
- [Giới thiệu về Hadoop Distributed File System (HDFS)](/blog/gioi-thieu-ve-hadoop-distributed-file-system-hdfs/)
- [Tổng quan về Amazon S3 - Dịch vụ lưu trữ đám mây của AWS](/blog/tong-quan-ve-amazon-s3-dich-vu-luu-tru-dam-may-cua-aws/)
- [Tổng quan về Google Cloud Storage - Dịch vụ lưu trữ đám mây của Google](/blog/tong-quan-ve-google-cloud-storage-dich-vu-luu-tru-dam-may-cua-google/)
- [Tổng quan về Azure Data Lake Storage - Dịch vụ lưu trữ đám mây của Microsoft](/blog/tong-quan-ve-azure-data-lake-storage-dich-vu-luu-tru-dam-may-cua-microsoft/)

### 2.2. Data Warehouse - Kho dữ liệu

**Định nghĩa:** Data Warehouse là một hệ thống lưu trữ dữ liệu quy mô lớn, được cấu trúc theo một mô hình tổ chức cụ thể.
Dữ liệu trong Data Warehouse đã được biến đổi và làm sạch trước khi lưu trữ, để phục vụ tốt cho các mục đích phân tích kinh doanh.

Nói cách khác, ta có thể hiểu Data Warehouse là một hệ thống lưu trữ dữ liệu gồm nhiều các database được tổ chức theo một bản thiết kế cụ thể.

Điểm khác biệt giữa Data Warehouse và các hệ quản trị cơ sở dữ liệu truyền thống là Data Warehouse được thiết kế để tối ưu hóa cho việc truy vấn và phân tích dữ liệu lớn.

Hình ảnh dưới đây được lấy từ tài liệu của DataBricks mô tả Data Warehouse:

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/warehouse.jpeg" style="width: 500px;"/>

- **Ưu điểm:**
    - Mục đích xây dựng dành cho BI và báo cáo do có cấu trúc rõ ràng và tốc độ truy vấn cao.
    - Lưu trữ dữ liệu sạch, có cấu trúc với một schema chuẩn, từ đó dễ dàng nâng cấp và bảo trì.
- **Nhược điểm:**
    - Không hỗ trợ lưu trữ dữ liệu bán cấu trúc hoặc phi cấu trúc, từ đó, hỗ trợ kém cho các trường hợp sử dụng AI.
    - Cần một bản thiết kế schema kỹ lưỡng trước khi triển khai.
    - Cần thời gian và công sức để làm sạch và biến đổi dữ liệu trước khi nạp vào kho dữ liệu.
    - Giá thành cao hơn khi mở rộng lưu trữ.

Một số công nghệ phổ biến để xây dựng Data Warehouse bao gồm:
- **Amazon Redshift:**
Amazon Redshift là dịch vụ kho dữ liệu (data warehouse) dạng cột, được tối ưu hóa cho truy vấn phân tích với tốc độ cao.
Redshift sử dụng kiến trúc MPP (Massively Parallel Processing) giúp xử lý khối lượng lớn dữ liệu trên nhiều nút tính toán.
- **Google BigQuery:**
Google BigQuery là kho dữ liệu phân tích dạng serverless, cho phép thực thi truy vấn SQL trên dữ liệu khổng lồ với tốc độ cao.
BigQuery tự động quản lý tài nguyên và mở rộng theo nhu cầu, phù hợp cho doanh nghiệp cần phân tích dữ liệu thời gian thực và triển khai mô hình dữ liệu hiện đại mà không cần quản trị hạ tầng.
- **Snowflake:**
Snowflake là nền tảng kho dữ liệu đám mây đa cụm, tách biệt hoàn toàn giữa lớp lưu trữ và lớp tính toán.
Kiến trúc này cho phép người dùng mở rộng độc lập tài nguyên, tối ưu chi phí và đảm bảo hiệu năng ổn định.
Snowflake hỗ trợ xử lý dữ liệu có cấu trúc và bán cấu trúc, thích hợp cho các tổ chức triển khai phân tích toàn diện.
- **Microsoft Azure Synapse Analytics**
Azure Synapse Analytics là nền tảng phân tích hợp nhất, kết hợp khả năng lưu trữ dữ liệu, xử lý dữ liệu lớn và phân tích BI trong một dịch vụ duy nhất.
Synapse cho phép thực thi truy vấn theo mô hình kho dữ liệu truyền thống hoặc Spark phân tán, đồng thời tích hợp liền mạch với Power BI và Data Factory để xây dựng quy trình phân tích đầu cuối.

Để hiểu rõ hơn về các công cụ trên, bạn có thể tham khảo bài viết:
- [Tổng quan về Amazon Redshift - Dịch vụ kho dữ liệu của AWS](/blog/tong-quan-ve-amazon-redshift-dich-vu-kho-du-lieu-cua-aws/)
- [Tổng quan về Google BigQuery - Dịch vụ kho dữ liệu của Google](/blog/tong-quan-ve-google-bigquery-dich-vu-kho-du-lieu-cua-google/)
- [Tổng quan về Snowflake - Nền tảng kho dữ liệu đám mây](/blog/tong-quan-ve-snowflake-nen-tang-kho-du-lieu-dam-may/)
- [Tổng quan về Microsoft Azure Synapse Analytics - Nền tảng phân tích hợp nhất của Microsoft](/blog/tong-quan-ve-microsoft-azure-synapse-analytics-nen-tang-phan-tich-hop-nhat-cua-microsoft/)

Hình ảnh dưới đây được lấy từ tài liệu của DataBricks mô tả chi tiết sự khác biệt giữa Data Lake và Data Warehouse:

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/warehouse_vs_lake_detail.jpeg" style="width: 1000px;"/>

### 2.3. Data Mart - Thị trường dữ liệu

**Định nghĩa:** Data Mart là một tập hợp con của Data Warehouse, chứa dữ liệu đã được chọn lọc và tổ chức theo nhu cầu của từng bộ phận như Marketing, Sales, Finance, hay HR.
Thay vì phải truy vấn trên Data Warehouse quy mô lớn, Data Mart cung cấp dữ liệu tập trung hơn, giúp truy xuất nhanh và hiệu quả.

- **Ưu điểm** và **Nhược điểm** của Data Mart tương tự như Data Warehouse.

Hình ảnh dưới đây được lấy từ tài liệu của DataBricks mô tả sự khác biệt giữa Data Lake và Data Warehouse tương ứng với sự phát triển của dữ liệu và Trí tuệ nhân tạo (AI):

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/4-data-analysis/warehouse_vs_lake.jpeg" style="width: 1000px;"/>

### 2.4. Data Lakehouse

**Định nghĩa:** Data Lakehouse là một mô hình lưu trữ dữ liệu kết hợp các ưu điểm của cả Data Lake và Data Warehouse.
Kết hợp các ưu điểm của Data Lake và Data Warehouse, Data Lakehouse giúp giảm thiểu các hạn chế của cả hai mô hình truyền thống.

Hình ảnh dưới đây được lấy từ tài liệu của DataBricks mô tả sự kết hợp giữa Data Lake và Data Warehouse trong mô hình Data Lakehouse:

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/lakehouse_combination.jpeg" style="width: 1000px;"/>

- **Ưu điểm:**
    - Kiến trúc đồng nhất: Dữ liệu được lưu trữ trong một hệ thống duy nhất, giúp giảm thiểu sự phân mảnh.
    - Môi trường mở: Hỗ trợ nhiều ngôn ngữ lập trình và công cụ, giúp tăng cường sự linh hoạt và tính tương tác.
    - Tối ưu chi phí và khả năng mở rộng: Tích hợp và quản lý trên đám mây giúp giảm chi phí so với các hệ thống truyền thống.
- **Nhược điểm:**
    - Vẫn còn là một khái niệm mới, do đó, có thể gặp phải các thách thức trong việc triển khai và quản lý.
    - Chi phí ban đầu có thể cao do cần đầu tư vào công nghệ và hạ tầng mới.

Một trong số những công nghệ phổ biến để xây dựng Data Lakehouse là D**atabricks Intelligent Data Lakehouse Platform**.
Là nền tảng hợp nhất giữa data lake và data warehouse, hỗ trợ lưu trữ, quản trị và phân tích dữ liệu trên cùng một kiến trúc.
Nền tảng cung cấp khả năng xử lý dữ liệu mạnh mẽ thông qua Apache Spark, tích hợp AI/ML, đồng thời đảm bảo tính nhất quán, hiệu năng truy vấn cao và quản lý dữ liệu ở quy mô lớn.

## 3. Quy trình xử lý dữ liệu

Data engineering gồm các công việc xây dựng hệ thống và cơ sở hạ tầng để thu thập, xử lý và lưu trữ dữ liệu.
Cụ thể, các công việc này được chia làm ba phần chính:
- Biến đổi từ dữ liệu thô thành dữ liệu sạch và đáng tin cậy.
    - Data Extraction: Trích xuất dữ liệu từ các nguồn khác nhau.
    - Data Cleaning: Làm sạch dữ liệu để loại bỏ các giá trị không hợp lệ hoặc thiếu hoặc không nhất quán.
    - Data Transformation: Biến đổi dữ liệu thành định dạng phù hợp cho phân tích.
- Đảm bảo chất lượng và tính sẵn sàng của dữ liệu.
    - Data Monitoring: Xây dựng quy trình để theo dõi và bảo trì chất lượng dữ liệu.
    - Data Governance: Thiết lập các chính sách và quy trình để quản lý dữ liệu, đảm bảo tính bảo mật và tuân thủ quy định.
- Thiết kế và xây dựng data pipeline.
    - Đóng gói các bước trên thành một quy trình tự động để thu thập, xử lý và lưu trữ dữ liệu liên tục.
    - Tối ưu hóa hiệu suất và khả năng mở rộng của hệ thống dữ liệu.

Hình ảnh dưới đây được lấy từ tài liệu của DataBricks mô tả tổng quan về data pipeline:

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/data_pipeline_general.jpeg" style="width: 800px;"/>

### 3.1. Data pipeline

Data pipeline là một chuỗi các bước tự động để thu thập, xử lý và lưu trữ dữ liệu từ các nguồn khác nhau đến đích cuối cùng như Data Warehouse hoặc Data Lake hoặc cả hai.

Từ Data Warehouse và Data Lake, ta có thể tiếp tục xây dựng các data pipeline tiếp theo để phục vụ các mục đích phân tích dữ liệu, báo cáo kinh doanh, hoặc huấn luyện mô hình machine learning.

Khi xây dựng data pipeline, một số yếu tố quan trọng cần xem xét bao gồm:
- **Data sources:** Xác định các nguồn dữ liệu cần thu thập, bao gồm cơ sở dữ liệu, API, tệp dữ liệu, hoặc các dịch vụ đám mây.
Việc xem xét kỹ càng các nguồn dữ liệu giúp đảm bảo tính toàn vẹn và độ tin cậy của dữ liệu cũng như khả năng mở rộng trong tương lai, do việc trích xuất dữ liệu từ nguồn, không chỉ phụ thuộc vào logic của data pipeline mà còn phụ thuộc vào đặc điểm của nguồn dữ liệu.
- **Data orchestration:** Sau khi thiết kế các bước trong data pipeline và xác định nơi lưu trữ dữ liệu, ta cần xây dựng một hệ thống để quản lý và điều phối các bước này.
Việc sử dụng các công cụ Data Orchestration giúp tự động hóa việc thực thi các bước trong data pipeline, theo dõi trạng thái và xử lý lỗi.
Điều này là không thể thiếu, đặc biệt đối với các data pipeline vừa mới được xây dựng hoặc có tính phức tạp cao.
- **Data governance:** Với đa dạng các loại dữ liệu và nguồn dữ liệu, việc thiết lập các chính sách và quy trình quản lý dữ liệu là rất quan trọng.
Điều này bao gồm việc xác định quyền truy cập dữ liệu, bảo mật dữ liệu, và tuân thủ các quy định liên quan đến dữ liệu.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/data_pipeline_on_cloud.jpeg" style="width: 800px;"/>

Hình ảnh trên đây được lấy từ cuốn sách [Cloud Data Engineering for dummies](https://github.com/MinhHuuNguyen/data-engineer-lectures/blob/master/books/cloud_data_engineering_for_dummies.pdf) mô tả chi tiết hơn về các thành phần trong data pipeline trên nền tảng đám mây.

### 3.2. ETL vs ELT

ETL và ELT là hai phương pháp thường được sử dụng trong việc xây dựng data pipeline để trích xuất, biến đổi và nạp dữ liệu.

- **Chữ E** đại diện cho **"Extract" (Trích xuất)**, tức là quá trình lấy dữ liệu từ các nguồn khác nhau.
- **Chữ T** đại diện cho **"Transform" (Biến đổi)**, tức là quá trình xử lý và biến đổi dữ liệu để phù hợp với mục đích sử dụng.
- **Chữ L** đại diện cho **"Load" (Nạp)**, tức là quá trình nạp dữ liệu đã được biến đổi vào hệ thống lưu trữ đích như Data Warehouse hoặc Data Lake.

Điểm khác biệt chính giữa ETL và ELT nằm ở thứ tự thực hiện giữa **"Transform" (Biến đổi)** và **"Load" (Nạp)** dữ liệu.

#### Đối với ETL (Extract, Transform, Load):

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/etl.jpeg" style="width: 800px;"/>

Với ETL, dữ liệu phải được biến đổi bên ngoài hệ thống đích bằng một công cụ xử lý riêng, dẫn đến việc di chuyển dữ liệu không cần thiết, phát sinh thay đổi và thường chậm.

#### Đối với ELT (Extract, Load, Transform):

Các tác vụ tích hợp dữ liệu hiện đại đã được cải thiện nhờ khai thác sức mạnh xử lý của hệ quản trị dữ liệu đích.
Trong những trường hợp này, pipeline được thiết kế theo hướng trích xuất và tải dữ liệu trước, sau đó mới biến đổi (ELT).

ELT đặc biệt phù hợp cho phân tích nâng cao.
Ví dụ, các nhà khoa học dữ liệu thường tải dữ liệu vào data lake rồi kết hợp với nguồn khác hoặc dùng để huấn luyện mô hình dự đoán.
Việc giữ dữ liệu ở trạng thái thô (hoặc ít xử lý hơn) giúp họ linh hoạt trong sử dụng.

Cách tiếp cận này nhanh hơn vì tận dụng được khả năng xử lý của các engine hiện đại và giảm thiểu việc di chuyển dữ liệu.
ELT hiệu quả không yêu cầu xác định schema ngay từ đầu, kể cả với dữ liệu bán cấu trúc.
Dữ liệu có thể được tải ở dạng thô và chỉ biến đổi khi đã rõ cách sử dụng cuối cùng.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/2-data-lake-warehouse/elt.jpeg" style="width: 800px;"/>

| Đặc điểm                     | ETL                                                  | ELT                                                |
| ---------------------------- | ---------------------------------------------------- | -------------------------------------------------- |
| Đường đi dữ liệu.            | Từ nguồn, qua staging rồi vào data warehouse         | Trực tiếp từ nguồn vào data warehouse và data lake |
| Kích thước dữ liệu           | Dữ liệu kích thước nhỏ hơn                           | Dữ liệu kích thước lớn hơn                         |
| Phép biến đổi dữ liệu        | Phép biến đổi phức tạp và đòi hỏi tính toán nhiều    | Phép biến đổi đơn giản                             |
| Thời gian truyền tải dữ liệu | Khi kích thước dữ liệu tăng lên, thời gian tăng theo | Tốc độ không phụ thuộc vào kích thước của dữ liệu  |
| Hỗ trợ Data lake             | Không                                                | Có                                                 |
| Chi phí                      | Chi phí cao hơn                                      | Chi phí thấp hơn                                   |


<!-- Data Engineer là người chịu trách nhiệm 

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
