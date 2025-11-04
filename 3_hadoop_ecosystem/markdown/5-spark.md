---
time: 09/09/2021
title: Giới thiệu về Apache Spark
description:
banner_url: 
tags: [big-data]
is_highlight: false
is_published: true
---

# Spark

## 1. Giới thiệu chung về Spark

Apache Spark là một hệ thống xử lý dữ liệu phân tán mã nguồn mở được phát triển bởi Apache Software Foundation.

<img src="https://techvccloud.mediacdn.vn/280518386289090560/2021/7/26/apache-spark-16272742352401372840332-60-0-397-600-crop-16272743360081603829654.jpg" style="width: 1200px;"/>


Các đặc trưng của Spark:
- **Xử lý dữ liệu lớn**:
Spark được thiết kế để xử lý và phân tích dữ liệu lớn.
Nó có khả năng phân phối dữ liệu trên nhiều nút và xử lý dữ liệu trên toàn cụm máy tính.
- **Resilient Distributed Dataset (RDD)**:
RDD là cấu trúc dữ liệu cốt lõi trong Spark, cho phép lưu trữ dữ liệu phân tán và thực hiện các phép biến đổi trên dữ liệu.
RDD có khả năng chịu lỗi và có thể phục hồi dễ dàng.
- **API Đa ngôn ngữ**:
Spark cung cấp API cho nhiều ngôn ngữ lập trình, bao gồm Scala, Java, Python (PySpark) và R (SparkR).
Điều này giúp người dùng có sự linh hoạt trong lựa chọn ngôn ngữ ưa thích của họ.
- **Hỗ trợ Machine Learning**:
Spark MLlib là một thư viện học máy tích hợp giúp xây dựng và triển khai các mô hình học máy trên dữ liệu lớn.
- **Xử lý luồng dữ liệu thời gian thực**:
Spark Streaming cho phép xử lý và phân tích dữ liệu luồng thời gian thực, giúp ứng dụng theo dõi và phản ứng đối với dữ liệu đang tạo ra.
- **Hỗ trợ đồ thị**:
Spark có thư viện GraphX cho xử lý đồ thị và phân tích mạng xã hội, đồ thị con người, và các ứng dụng liên quan đến đồ thị.
- **Hỗ trợ SQL và DataFrames**:
Spark SQL cho phép truy vấn dữ liệu bằng SQL trên các RDD, cùng với DataFrames, giúp làm việc với dữ liệu có cấu trúc một cách hiệu quả.
- **Tích hợp với Hadoop**:
Spark có tích hợp với Hadoop, cho phép sử dụng Hadoop Distributed File System (HDFS) và quản lý tài nguyên thông qua Apache Hadoop YARN.
- **Hiệu suất cao**:
Spark sử dụng bộ nhớ đệm và tối ưu hóa xử lý dữ liệu, giúp tăng hiệu suất so với các hệ thống truyền thống như Hadoop MapReduce.
- **Xử lý sự cố và khả năng mở rộng**:
Spark có khả năng xử lý lỗi và khả năng mở rộng tốt, cho phép tăng cường khả năng chịu tải khi cần thiết.


<img src="https://drive.google.com/uc?id=1MsNZkbkPqWPlc-zM-MtnwSnWLEBALXa7" style="width: 1200px;"/>


## 2. Chi tiết các thành phần trong Spark

<img src="https://drive.google.com/uc?id=1GAImR0WdOwbaaZ7NTeW0W6d5PU7mE_0g" style="width: 1200px;"/>

### 2.1. Spark Core

Apache Spark Core là một phần quan trọng và cốt lõi của Apache Spark, là một cơ sở cho toàn bộ hệ thống.
Nó cung cấp các chức năng cơ bản cho xử lý dữ liệu phân tán và quản lý tài nguyên trong cụm máy tính và là nền tảng cho các thành phần khác của Apache Spark như Spark SQL, Spark Streaming, Spark MLlib và Spark GraphX.

<img src="https://drive.google.com/uc?id=1YBj4Hm2RHCsiqC4QrNCKJ-BxTeRSS_Ms" style="width: 1200px;"/>

#### Resilient Distributed Dataset (RDD)

RDD là một khái niệm quan trọng trong Spark Core được sử dụng để lưu trữ và xử lý dữ liệu trên một cụm máy tính phân tán.
- **Phân phối dữ liệu**:
RDD chia dữ liệu thành các phần nhỏ và phân tán chúng trên các nút trong cụm.
Mỗi phần dữ liệu được lưu trữ trên một nút và có thể xử lý một cách độc lập.
- **Khả năng chịu lỗi và phục hồi**:
RDD có khả năng tự phục hồi khi có lỗi xảy ra trên một phần dữ liệu.
Điều này đạt được bằng cách lưu trạng thái gốc và sử dụng dữ liệu gốc để tái tính toán dữ liệu bị mất.
Ngoài ra, RDD là không thay đổi, nghĩa là sau khi tạo ra một RDD, bạn không thể thay đổi nó.
Thay vào đó, bạn tạo các RDD mới từ RDD gốc bằng cách sử dụng các phép biến đổi.
- **Lazy evaluation**:
RDD sử dụng cơ chế Lazy evaluation, cho phép xây dựng và tối ưu các phân tích dữ liệu phức tạp.
- **In-memory caching**:
RDD có khả năng lưu trữ dữ liệu trong bộ nhớ, giúp tối ưu hóa hiệu suất xử lý dữ liệu.
Khi dữ liệu đã được lưu trữ trong bộ nhớ, các phép tính toán sau này trên RDD có thể được thực hiện nhanh hơn vì không cần đọc dữ liệu từ đĩa.

#### Cơ chế Lazy evaluation

Lazy evaluation không phải là cơ chế được sáng tạo bởi nhà phát triển của Spark nhưng được ứng dụng vào Spark giúp tăng tốc hiệu quả xử lý dữ liệu lớn.

Có hai chiến lược đối nghịch nhau là Lazy Evaluation và Eager Evaluation:
- **Lazy Evaluation**:
    - Là một phương pháp trong đó biểu thức hoặc tính toán không được đánh giá ngay lập tức khi chúng được tạo ra.
    Thay vào đó, chúng được lưu trữ tạm thời và chỉ được tính toán khi cần thiết.
    - Giúp tối ưu hóa việc sử dụng tài nguyên bằng cách tránh tính toán không cần thiết.
    Nó đặc biệt hữu ích khi làm việc với dữ liệu lớn hoặc trong các tình huống cần tối ưu hóa hiệu suất.
- **Eager Evaluation**:
    - Là phương pháp trong đó biểu thức hoặc tính toán được đánh giá ngay lập tức khi chúng được tạo ra.
    Các giá trị kết quả được tính toán và lưu trữ ngay sau khi biểu thức được gọi.
    - Dễ dàng để hiểu và debug vì tất cả các biểu thức và tính toán đều được thực hiện ngay lập tức.
    - Có thể gây lãng phí tài nguyên và thời gian nếu các tính toán không cần thiết được thực hiện.

Ví dụ:
```python
# Ví dụ sử dụng Lazy Evaluation
def lazy_add(a, b):
    return lambda: a + b

result = lazy_add(3, 4)  # Không thực hiện phép cộng ngay lập tức
print("Biểu thức vẫn chưa được tính toán")
print("Kết quả sau khi tính toán:", result())  # Khi cần, biểu thức mới được tính toán
```

```python
# Ví dụ sử dụng Eager Evaluation
def eager_add(a, b):
    return a + b

result = eager_add(3, 4)  # Thực hiện phép cộng ngay lập tức
print("Biểu thức đã được tính toán")
print("Kết quả sau khi tính toán:", result)  # Kết quả đã được tính toán trước đó
```

Trong Spark, Lazy evaluation cho phép ta định nghĩa nhiều phép biến đổi dữ liệu (Transformation) trước khi chúng được thực sự tiến hành khi một hành động (Action) được gọi.
**Do đó, Transformations are lazy but actions are eager.**

Có hai loại toán tử tương tác với RDD:
- **Transformation** là các toán tử trả đầu ra là một RDD mới sau khi thực hiện biến đổi RDD
    - **Narrow transformations**
        - là các phép biến đổi mà mỗi phần tử đầu ra chỉ phụ thuộc vào một vài phần tử đầu vào và không cần truy cập đến tất cả các phần tử trong các phân vùng (partitions) của RDD.
        - thực hiện song song trên từng phân vùng riêng lẻ mà không cần giao tiếp hoặc trao đổi dữ liệu giữa các phân vùng.
        Do đó, chúng có hiệu suất cao hơn và không yêu cầu nhiều bước tính toán phức tạp.
        - ví dụ: select, map, filter ...
    - **Wide transformations**: Dữ liệu cần để thực hiện biến đổi nằm trên các partition khác nhau
        - là các phép biến đổi mà mỗi phần tử đầu ra có thể phụ thuộc vào tất cả các phần tử trong các phân vùng của RDD hoặc có khả năng giao tiếp và trao đổi dữ liệu giữa các phân vùng.
        - thường gây ra sự di chuyển dữ liệu giữa các phân vùng, đòi hỏi nhiều bước tính toán và có thể làm giảm hiệu suất
        - ví dụ: groupBy, join, sort, ...
- **Action** là các toán tử trả đầu ra là các giá trị sau khi thực hiện tính toán trên RDD
Ví dụ: show, count, first, save, ...


Ví dụ: Ta có một RDD chứa dữ liệu của các học sinh trong một lớp học.
Ta muốn tính tổng điểm của tất cả các học sinh trong lớp.
Để làm điều này, ta có thể sử dụng phương pháp Eager Evaluation như sau:

```python
# Eager Evaluation
# Tính tổng điểm của tất cả các học sinh trong lớp
total_score = 0
for student in students:
    total_score += student.score
```

Tuy nhiên, nếu ta muốn tính tổng điểm của các học sinh có điểm trên 8, ta sẽ phải thực hiện lại vòng lặp trên như sau:

```python
# Eager Evaluation
# Tính tổng điểm của tất cả các học sinh có điểm trên 8 trong lớp
total_score = 0
for student in students:
    if student.score > 8:
        total_score += student.score
```

Để tránh việc thực hiện lại vòng lặp, ta có thể sử dụng phương pháp Lazy Evaluation như sau:

```python
# Lazy Evaluation
# Tính tổng điểm của tất cả các học sinh trong lớp
total_score = students.map(lambda student: student.score).reduce(lambda x, y: x + y)
```

```python
# Lazy Evaluation
# Tính tổng điểm của tất cả các học sinh có điểm trên 8 trong lớp
total_score = students.filter(lambda student: student.score > 8).map(lambda student: student.score).reduce(lambda x, y: x + y)
```

#### Spark’s Catalyst Optimizer

Apache Spark's Catalyst Optimizer là một trong những thành phần quan trọng của Spark.

Catalyst là một bộ tối ưu hóa truy vấn được sử dụng để cải thiện hiệu suất và tối ưu hóa kế hoạch thực hiện truy vấn.
Nó là một bộ tối ưu hóa dựa trên quy tắc (rule-based optimizer) và được sử dụng để biến đổi câu truy vấn và kế hoạch thực hiện câu truy vấn để tạo ra kế hoạch thực hiện hiệu quả hơn.

<img src="https://miro.medium.com/v2/0*cWEUvlErq9Mf3pdr" style="width: 1200px;"/>

Các bước biến đổi trong Catalyst Optimizer:
- **Preprocessing**:
Trước khi bắt đầu quá trình tối ưu hóa, Catalyst thực hiện một số bước tiền xử lý cơ bản.
Điều này bao gồm việc phân tích cú pháp của truy vấn, xây dựng cây truy vấn Logic Plan và kiểm tra cú pháp.
- **Apply Optimization Rules**:
Catalyst sử dụng danh sách các quy tắc tối ưu hóa (optimization rules) để biến đổi cây truy vấn Logic Plan.
Mỗi quy tắc tối ưu hóa thực hiện một biến đổi cụ thể trên cây truy vấn.
- **Rule Application Order**:
Catalyst quyết định thứ tự áp dụng các quy tắc tối ưu hóa.
Thông thường, các quy tắc hiệu quả hơn được áp dụng trước.
Ví dụ, các quy tắc liên quan đến lọc có thể được áp dụng trước khi xem xét join hoặc sắp xếp.
- **Plan Optimization**:
Catalyst có thể cải thiện kế hoạch thực hiện truy vấn bằng cách biến đổi kế hoạch để sử dụng các phép toán thích hợp hơn, giảm bước trung gian không cần thiết và cải thiện hiệu suất tổng thể của truy vấn.
- **Expression Optimization**:
Catalyst cũng tối ưu hóa các biểu thức trong truy vấn bằng cách sử dụng trình biên dịch (Expression Compiler) để biên dịch các biểu thức thành mã máy hiệu quả.
- **Final Physical Plan**:
Sau khi tất cả các biến đổi và tối ưu hóa đã được áp dụng, Catalyst xây dựng kế hoạch thực hiện truy vấn cuối cùng.
Kế hoạch này thể hiện cấu trúc thực hiện truy vấn sau khi tất cả tối ưu hóa đã hoàn thành.
- **Query Execution**:
Kế hoạch thực hiện cuối cùng sau bước tối ưu hóa được sử dụng để thực hiện truy vấn trên dữ liệu thực tế.
Trong quá trình này, dữ liệu được đọc, biến đổi và tính toán dựa trên kế hoạch tối ưu hóa đã xây dựng.

<img src="https://miro.medium.com/v2/resize:fit:828/0*8jymyiQyW1D3lS-0" style="width: 1200px;"/>

Ví dụ:
```sql
SELECT employees.name, departments.department_name
FROM employees
JOIN employee_departments ON employees.employee_id = employee_departments.employee_id
JOIN departments ON employee_departments.department_id = departments.department_id
WHERE employees.salary > 50000 AND departments.location = 'New York'
```
- Preprocessing: Tạo cây truy vấn Logic Plan.
- Apply Optimization Rules:
Quy tắc có thể bao gồm "PushDownPredicate" để đẩy điều kiện lọc "salary > 50000" xuống càng gần dữ liệu và "PushDownJoin" để xác định thứ tự thực hiện các phép nối.
- Rule Application Order:
Quy tắc "PushDownPredicate" được áp dụng trước để đẩy điều kiện lọc xuống gần với dữ liệu.
Sau đó, quy tắc "PushDownJoin" có thể xác định thứ tự thực hiện các phép nối sao cho hiệu suất tối ưu.
- Plan Optimization:
Catalyst có thể cải thiện kế hoạch bằng cách loại bỏ các bước trung gian không cần thiết và cải thiện hiệu suất tổng thể.
- Expression Optimization:
Catalyst cũng tối ưu hóa các biểu thức trong truy vấn, ví dụ: "salary > 50000" có thể được biên dịch thành mã máy hiệu quả.
- Final Physical Plan:
Áp dụng tất cả các quy tắc tối ưu hóa và biến đổi có thể biểu diễn bằng một kế hoạch thực hiện truy vấn cụ thể.
- Query Execution:
Kế hoạch thực hiện cuối cùng được sử dụng để thực hiện truy vấn trên dữ liệu thực tế, với tất cả các tối ưu hóa và biến đổi đã áp dụng.

### 2.2. Spark SQL

Spark SQL là một thành phần quan trọng của Apache Spark, cung cấp khả năng thực thi truy vấn SQL trên dữ liệu phân tán.

- **Hỗ trợ SQL truyền thống**:
Spark SQL cho phép bạn thực hiện truy vấn SQL truyền thống trên dữ liệu phân tán.
Có thể sử dụng các truy vấn SELECT, JOIN, GROUP BY, và nhiều lệnh SQL khác để truy vấn và xử lý dữ liệu.
- **Tích hợp dữ liệu cấu trúc và bán cấu trúc**:
Spark SQL cho phép làm việc với dữ liệu cấu trúc (Structured Data) thông qua các DataFrame, cũng như dữ liệu bán cấu trúc (Semi-structured Data) bằng cách sử dụng các RDD (Resilient Distributed Datasets).
- **Tương thích với nhiều nguồn dữ liệu**:
Spark SQL có khả năng làm việc với nhiều nguồn dữ liệu khác nhau, bao gồm Parquet, JSON, CSV, và cơ sở dữ liệu HDFS, Hive, và nhiều hệ thống lưu trữ dữ liệu khác.
- **Catalyst Optimizer**:
Spark SQL sử dụng Catalyst Optimizer để tối ưu hóa các truy vấn SQL.
Catalyst là một bộ tối ưu hóa dựa trên quy tắc (rule-based optimizer) giúp cải thiện hiệu suất truy vấn.
- **Hỗ trợ cho UDFs (User-Defined Functions)**:
Có thể định nghĩa và sử dụng các hàm người dùng (UDFs) trong truy vấn SQL để thực hiện tính toán tùy chỉnh trên dữ liệu.
- **Lập trình bằng nhiều ngôn ngữ**:
Spark SQL hỗ trợ nhiều ngôn ngữ lập trình, bao gồm Scala, Java, Python và R, giúp bạn làm việc với dữ liệu trong ngôn ngữ mà bạn thoải mái.
- **Hỗ trợ cho BI Tools**:
Spark SQL có thể tích hợp với các công cụ Business Intelligence (BI) như Tableau, QlikView, và Power BI để trực quan hóa và trình bày dữ liệu.
- **Hỗ trợ cho MLlib và GraphX**:
Dữ liệu có thể được trực tiếp chuyển đổi thành các đối tượng sử dụng trong thư viện MLlib và GraphX của Spark để thực hiện học máy và xử lý đồ thị.

<img src="https://drive.google.com/uc?id=1epRfkR7EHlyw_p36reBp_0TuBjcrZ-7-" style="width: 1200px;"/>

#### DataFrame DSL (Domain-Specific Language)

DataFrame DSL (Domain-Specific Language) là một ngôn ngữ cụ thể cho việc làm việc với DataFrame trong Apache Spark.

Nó không phải là một ngôn ngữ riêng lẻ, mà thay vào đó, nó là một tập hợp các phương thức và toán tử được cung cấp bởi Spark để thực hiện các thao tác trên DataFrame một cách dễ dàng và mạnh mẽ.

DataFrame DSL được thiết kế để cho phép người lập trình sử dụng Spark SQL để truy vấn và biến đổi dữ liệu dưới dạng DataFrame bằng cách sử dụng một ngôn ngữ dễ đọc và dễ hiểu.

Ví dụ:
```scala
// Tạo một DataFrame từ một nguồn dữ liệu
val df = spark.read.json("data.json")

// Hiển thị 10 dòng đầu tiên của DataFrame
df.show(10)

// Lọc dữ liệu dựa trên một điều kiện
val filteredDF = df.filter(df("age") > 25)

// Nhóm dữ liệu và tính tổng trên một cột
val groupByDF = df.groupBy("gender").agg(sum("salary"))

// Kết hợp hai DataFrame
val joinedDF = df1.join(df2, "employee_id")
```

#### HQL (Hive Query Language)
HQL, hay còn gọi là HiveQL, là một ngôn ngữ truy vấn sử dụng trong hệ sinh thái Apache Hive.
Hive là một lớp trừu tượng trên Hadoop HDFS và cung cấp cách truy vấn dữ liệu có cấu trúc sử dụng ngôn ngữ SQL-similar gọi là HQL.


### 2.3. Spark Streaming

Apache Spark Streaming là một thành phần quan trọng của hệ sinh thái Apache Spark, được thiết kế để xử lý và phân tích dữ liệu trực tiếp (real-time data) với tốc độ và khả năng mở rộng cao.

- **Hỗ trợ cho các nguồn dữ liệu đa dạng**:
Xử lý dữ liệu trực tiếp từ nhiều nguồn như streaming data (logs, sự kiện, dữ liệu sensor), batch data, và hệ thống hàng đợi tin nhắn (message queues) như Apache Kafka.
- **API đồng nhất với Spark**:
Tích hợp chặt chẽ với Apache Spark, giúp bạn sử dụng cùng một API.
- **Khả năng mở rộng**: 
Có khả năng mở rộng ngang (horizontal scaling), cho phép xử lý dữ liệu để đối phó với tải công việc cao và dữ liệu đầu vào lớn.
- **Near Real-Time**:
Mặc dù Spark Streaming không đạt đến thời gian thực (real-time) chính xác, nó cung cấp khả năng xử lý dữ liệu gần thời gian thực (near real-time) với độ trễ thấp.
- **Tích hợp với thư viện Spark**:
Có thể sử dụng các thư viện khác của Spark như Spark SQL, MLlib, và GraphX để xử lý dữ liệu trực tiếp.
- **Windowed Processing**:
Spark Streaming cho phép bạn thực hiện xử lý dữ liệu trong cửa sổ thời gian, giúp bạn tính toán tổng hợp và thống kê trên dữ liệu trong khoảng thời gian nhất định.

<img src="https://drive.google.com/uc?id=1MYQ3SRohKQTpkGEjQK2oJ_lPi5HnD-ht" style="width: 1200px;"/>

### 2.4. Spark MLlib

Apache Spark MLlib (Machine Learning Library) là một thư viện machine learning mã nguồn mở và phân tán được tích hợp chặt chẽ với Apache Spark.
MLlib cung cấp một loạt các mô hình machine learning và công cụ cho việc xây dựng, đào tạo và triển khai mô hình học máy trên dữ liệu lớn.

- **Tích hợp với Apache Spark**:
Tích hợp chặt chẽ với Apache Spark, cho phép sử dụng ngôn ngữ Scala, Java, Python hoặc R để làm việc với dữ liệu và thực hiện machine learning trên cụm Spark.
Điều này mang lại sự mạnh mẽ và khả năng mở rộng của Spark cho việc xử lý dữ liệu lớn.
- **Mô hình Machine Learning**:
Cung cấp một loạt các mô hình machine learning khác nhau bao gồm cả machine learning cổ điển và deep learning như: classification, regression, clustering.
Các mô hình này đã được tối ưu hóa để hoạt động trên cụm và xử lý dữ liệu phân tán.
- **Các công cụ và tính năng liên quan đến ML**:
Cung cấp các công cụ và tính năng liên quan đến machine learning như model evaluation, data pipeline, model pipeline.
- **Khả năng mở rộng**:
Có khả năng mở rộng và có thể xử lý cả dữ liệu lớn và cụm máy tính phân tán, cho phép bạn đào tạo mô hình trên dữ liệu lớn và tận dụng các tài nguyên cụm.
- **Hỗ trợ cho Spark Streaming và Spark SQL**:
Tích hợp với Spark Streaming và Spark SQL, cho phép bạn xây dựng ứng dụng thực hiện machine learning trên dữ liệu trực tiếp và dữ liệu cấu trúc.
- **Sự phát triển và cộng đồng mạnh mẽ**:
Là một dự án mã nguồn mở phát triển mạnh mẽ và có sự đóng góp từ cộng đồng rộng rãi. Điều này đảm bảo tính cập nhật, sửa lỗi và bổ sung mới liên tục.

<img src="https://drive.google.com/uc?id=1OXiPvRFYB6cc_-XaaZjntl_m14eSppP3" style="width: 1200px;"/>

### 2.5. Spark GraphX

Apache Spark GraphX là một thư viện mã nguồn mở trong hệ sinh thái Apache Spark, được thiết kế để xử lý và phân tích dữ liệu đồ thị.
Thư viện này cung cấp các cấu trúc dữ liệu và các thuật toán đồ thị để giúp bạn nghiên cứu, phân tích mạng xã hội, xử lý dữ liệu đồ thị trong lĩnh vực khai thác dữ liệu và học máy.

- **Xử lý dữ liệu đồ thị**:
Xử lý dữ liệu đồ thị, trong đó các đỉnh và cạnh của đồ thị có thể đại diện cho các thực thể và mối quan hệ giữa chúng.
Điều này phù hợp cho việc nghiên cứu các mạng xã hội, mạng lưới, mạng thông tin, và nhiều ứng dụng khác.
- **API đồng nhất với Spark**:
Tích hợp chặt chẽ với Apache Spark, giúp bạn sử dụng cùng một API để xử lý dữ liệu đồ thị và dữ liệu lớn.
Điều này giúp tận dụng sức mạnh của Spark trong việc xử lý phân tán.
- **Cấu trúc dữ liệu linh hoạt**:
Cung cấp cấu trúc dữ liệu linh hoạt để biểu diễn dữ liệu đồ thị, bao gồm đồ thị hướng và đồ thị không hướng.
Điều này cho phép bạn biểu diễn một loạt các dữ liệu đồ thị phức tạp.
- **Các thuật toán đồ thị tích hợp**:
Cung cấp một loạt các thuật toán đồ thị như duyệt đồ thị (graph traversal), tính toán đường đi ngắn nhất (shortest path), tìm kiếm đồ thị (graph search), tính toán bậc và thuật toán phân cụm (clustering algorithms) để phân tích và khám phá thông tin từ dữ liệu đồ thị.
- **Khả năng mở rộng**:
Có khả năng mở rộng và tối ưu hóa hiệu suất, cho phép xử lý các đồ thị lớn trên cụm máy tính phân tán.
- **Hỗ trợ cho tích hợp với MLlib**:
GraphX có thể tích hợp với Spark MLlib, cho phép bạn sử dụng machine learning để phân tích dữ liệu đồ thị và xây dựng các mô hình học máy dựa trên thông tin từ đồ thị.
- **Hỗ trợ cho Spark Streaming và Spark SQL**:
GraphX có thể được tích hợp với Spark Streaming và Spark SQL để xử lý và phân tích dữ liệu đồ thị trong các ứng dụng thời gian thực và các truy vấn SQL.

<img src="https://drive.google.com/uc?id=1UU-AgvHOHQ6Lf_SQTKFV9c9HuBHYPrkj" style="width: 1200px;"/>


<!-- ## 3. Phân biệt một số khái niệm

### 3.1. SparkContext và SparkSession

Đối với SparkContext:
- SparkContext được sử dụng trong phiên bản Spark trước 2.0.
- SparkContext làm việc với dữ liệu phi cấu trúc thông qua RDD.
- SparkContext là một đối tượng chính của SparkCore giúp quản lý tài nguyên và phân phối các nhiệm vụ trên cụm.

Đối với SparkSession:
- SparkSession được giới thiệu từ phiên bản Spark 2.0 trở lên.
- SparkSession làm việc với dữ liệu có cấu trúc thông qua DataFrame.
- SparkSession hoạt động với Spark SQL và Hive, tổng hợp các tính năng của SparkContext, SQLContext và HiveContext.

### 3.2. RDD và DataFrame
 -->
