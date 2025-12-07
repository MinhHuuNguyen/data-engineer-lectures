---
time: 10/31/2022
title: Framework xử lý dữ liệu Hadoop Map Reduce
description: Hadoop MapReduce là mô hình và framework xử lý dữ liệu lớn theo phương thức song song và phân tán trên cụm máy chủ. Nhờ tận dụng tài nguyên từ toàn bộ cụm máy, MapReduce cho phép xử lý khối lượng dữ liệu rất lớn theo dạng batch với khả năng chịu lỗi cao. Đây là nền tảng truyền thống cho nhiều ứng dụng phân tích dữ liệu trong hệ sinh thái Hadoop.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/1-hadoop/banner.jpeg
tags: [big-data, hadoop]
is_highlight: false
is_published: true
---

## 1. Kiến trúc tổng quát của MapReduce

MapReduce là một khuôn mẫu xử lý phân tán theo lô (batch-based), được mô phỏng theo bài báo nghiên cứu [MapReduce: Simplified Data Processing on Large Clusters](https://static.googleusercontent.com/media/research.google.com/en//archive/mapreduce-osdi04.pdf) của Google.

MapReduce cho phép song song hóa xử lý trên một lượng lớn dữ liệu thô, bằng cách chia nhỏ công việc thành các tác vụ độc lập có thể chạy đồng thời trên nhiều nút trong cụm máy tính.
Những tác vụ, vốn có thể mất hàng ngày hoặc lâu hơn nếu dùng cách lập trình tuần tự thông thường, có thể được giảm xuống chỉ còn vài phút khi chạy bằng MapReduce trên một cụm Hadoop.

Mô hình MapReduce đơn giản hóa việc xử lý song song bằng cách che giấu những phức tạp liên quan đến hệ thống phân tán, như song song hóa tính toán, phân phối công việc và xử lý lỗi phần cứng hoặc phần mềm.
Nhờ lớp trừu tượng này, MapReduce giúp lập trình viên tập trung vào việc giải quyết yêu cầu nghiệp vụ thay vì bị cuốn vào các vấn đề của hệ thống phân tán.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả kiến trúc tổng quát của MapReduce.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/3-map-reduce/architecture.jpeg" style="width: 600px;"/>

MapReduce phân rã khối công việc do client gửi vào các tác vụ nhỏ chạy song song, gồm các tác vụ **map** và **reduce**.
Hai thành phần map và reduce sử dụng mô hình “shared-nothing” nhằm loại bỏ các phụ thuộc song song, tránh những điểm đồng bộ hóa hoặc chia sẻ trạng thái không cần thiết.

Với sự xuất hiện của YARN trong Hadoop 2, MapReduce được viết lại thành một ứng dụng chạy trên YARN (được quản lý bởi YARN) và được gọi là MapReduce 2 (MRv2).
Về mặt lập trình, MapReduce trong Hadoop 2 hoạt động tương tự như Hadoop 1, và mã nguồn viết cho Hadoop 1 có thể chạy trên Hadoop 2 mà không cần chỉnh sửa.
Tuy nhiên, kiến trúc vật lý và cơ chế nội bộ của MRv2 có một số thay đổi.

### 1.1. Hàm Map

Hàm Map giữ vai trò là giai đoạn xử lý đầu tiên trong chu trình MapReduce.
Mục tiêu chính của hàm Map là:
- Chuyển đổi dữ liệu thành dạng chuẩn hóa để hệ thống có thể phân tán và xử lý song song.
- Tách lọc, tiền xử lý và cấu trúc lại thông tin để phục vụ cho giai đoạn Reduce.
- Phân rã dữ liệu lớn thành các đơn vị độc lập, giúp xử lý phân tán đạt hiệu quả tối đa.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả hàm Map trong MapReduce.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/3-map-reduce/map_function.jpeg" style="width: 900px;"/>

Cơ chế hoạt động của hàm Map:
- **Nhận dữ liệu đầu vào dưới dạng cặp key-value:** Mỗi bản ghi từ nguồn dữ liệu đầu vào được biểu diễn dưới dạng một cặp (key, value).
Mỗi hàm Map xử lý từng cặp một cách độc lập, không chia sẻ trạng thái với các hàm Map khác.
- **Biến đổi dữ liệu và tạo ra 0 hoặc 1 hoặc nhiều cặp key/value mới:** Từ một cặp đầu vào, hàm Map có thể sinh ra:
    - **Không có cặp nào:** khi dữ liệu không thỏa điều kiện xử lý (ví dụ: thao tác lọc).
    - **Một cặp duy nhất:** khi chỉ cần chuyển đổi trực tiếp dữ liệu.
    - **Nhiều cặp:** khi cần tách hoặc phân rã dữ liệu (demultiplexing).
- **Gửi đầu ra cho giai đoạn Shuffle & Sort:** Các cặp key/value do hàm Map tạo ra được gửi đến giai đoạn tiếp theo.

Ví dụ về một trường hợp sử dụng hàm Map để lọc dữ liệu:

Ta có bộ dữ liệu như sau:

```
(ID: 1, Name: "Alice", Age: 30)
(ID: 2, Name: "Bob", Age: 25)
(ID: 3, Name: "Charlie", Age: 35)
(ID: 4, Name: "David", Age: 28)
(ID: 5, Name: "Eve", Age: 22)
```

Giả sử ta muốn lọc ra những người có tuổi trên 28.
Hàm Map có thể được viết như sau:

```python
def map_function(record):
    _id, name, age = record
    if age > 28:
        yield (name, age)
```

Kết quả đầu ra từ hàm Map sẽ là: ```("Alice", 30) ("Charlie", 35)```

Những bản ghi có tuổi 28 trở xuống (Bob, David, Eve) sẽ không tạo ra cặp key/value nào, do đó chúng bị loại bỏ trong quá trình xử lý.

### 1.2. Giai đoạn Shuffle và Sort

Sau khi Map hoàn tất, Shuffle và Sort đảm nhận nhiệm vụ bảo đảm rằng dữ liệu trung gian được chuyển đến đúng nơi để thực hiện Reduce một cách hiệu quả.
Mục tiêu chính của giai đoạn này là:
- **Phân vùng dữ liệu (Partitioning):** Xác định cặp key/value nào sẽ được gửi tới reducer nào.
Tất cả dữ liệu mang cùng một khóa phải được đưa đến cùng một reducer để xử lý.
- **Sắp xếp dữ liệu theo khóa (Sorting):** Bảo đảm mọi cặp key/value gửi tới từng reducer đều được sắp xếp theo khóa.
Điều này tạo điều kiện cho Reduce xử lý tuần tự từng khóa một cách ổn định và hiệu quả.

Nhờ đó, Shuffle và Sort là cầu nối giữa Map và Reduce, bảo đảm dữ liệu trung gian được tổ chức chính xác và tối ưu cho giai đoạn tổng hợp cuối cùng.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả giai đoạn Shuffle và Sort trong MapReduce.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/3-map-reduce/shuffle_sort_phase.jpeg" style="width: 900px;"/>

Shuffle là quá trình di chuyển và phân phối dữ liệu từ các mapper đến các reducer phù hợp.
Mỗi cặp (key, value) do Map tạo ra sẽ được đưa vào một hàm phân vùng (partition function) và hàm này quyết định xem khóa đó thuộc về reducer nào.

Trước khi reducer nhận dữ liệu, hệ thống thực hiện Sort, sắp xếp toàn bộ các khóa thuộc về cùng reducer theo thứ tự nhất định.
Nhờ sorting, reducer có thể xử lý từng khóa theo từng nhóm mà không cần tìm kiếm hay tổ chức lại dữ liệu.
Sorting theo khóa là bước bắt buộc, vì reduce xử lý theo đơn vị khóa, không phải từng bản ghi rời rạc.

### 1.3. Hàm Reduce

Reduce tổng hợp dữ liệu theo khóa (gọi là aggregation) và chịu trách nhiệm xử lý **một lần cho mỗi khóa duy nhất**, thực hiện các phép tổng hợp, gom nhóm, tính toán cuối cùng theo khóa đó.

Reduce biến dữ liệu trung gian thành kết quả cuối cùng: Các giá trị trung gian được gộp lại và tạo ra kết quả đầu ra (có thể là 0 hoặc 1 hoặc nhiều cặp key/value).

Reduce còn chịu trách nhiệm ghi kết quả ra hệ thống đích như file HDFS, database NoSQL, hoặc bất kỳ nơi nào khác.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả hàm Reduce trong MapReduce.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/3-map-reduce/reduce_function.jpeg" style="width: 700px;"/>

Cơ chế hoạt động của hàm Reduce:
- **Nhận input đã gom nhóm:** Sau shuffle & sort, reducer nhận một cặp (key, [list_of_values]).
Danh sách giá trị này là tập hợp mọi value liên quan đến key trên toàn bộ cluster.
- **Xử lý theo logic nghiệp vụ:** Trong hàm reduce, lập trình viên áp dụng logic xử lý như: tổng (sum), đếm (count), trung bình (avg), hợp nhất danh sách (concat), lọc (filter) ...
Hàm reduce có thể trả về: Không có output (ví dụ: lọc toàn bộ giá trị), hoặc 1 hoặc nhiều cặp key/value.
- **Sử dụng iterator/stream:** Hàm reduce thường dùng iterator để duyệt các giá trị thay vì nạp toàn bộ vào bộ nhớ, giúp xử lý giá trị lớn mà không vượt bộ nhớ.
- **Ghi kết quả vào đầu ra:** Output của reducer được ghi vào hệ thống đích như file HDFS, database NoSQL, hoặc bất kỳ nơi nào khác.

Hình dưới đây được lấy từ cuốn sách [Hadoop in practice - Second edition](https://github.com/MinhHuuNguyen/ai-lectures/blob/master/books/hadoop_in_practice_second_edition_alex_holmes.pdf), mô tả luồng tương tác giữa các thành phần trong quá trình MapReduce.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/3-map-reduce/process.jpeg" style="width: 800px;"/>

Tuy nhiên, ở phiên bản Hadoop 2 trở đi, kiến trúc MapReduce đã được cải tiến để tận dụng YARN, hay nói cách khác, MapReduce trở thành một ứng dụng chạy trên YARN và YARN chịu trách nhiệm quản lý tài nguyên và lập lịch cho các tác vụ MapReduce.
Do đó, một số thành phần như JobTracker và TaskTracker trong Hadoop 1 đã được thay thế bằng ResourceManager và NodeManager của YARN.

## 2. Ví dụ: Đếm từ trong văn bản - Word Count

### 2.1. Dữ liệu mẫu (input)

```makefile
Hello world
Hello, Hadoop!
Goodbye world.
```

Kết quả mong muốn (output):

```makefile
goodbye    1
hadoop     1
hello      2
world      2
```

### 2.2. Thiết kế Map – Reduce

#### Bước 1: InputSplit & Mapper

- Hệ thống chia file thành các `InputSplit`, mỗi split được xử lý bởi một `Mapper`.
- Mỗi dòng được tách thành các word (tokenize), loại bỏ dấu câu và chuyển về chữ thường, có thể bổ sung thêm các bước tiền xử lý dữ liệu văn bản như loại bỏ stop words...
- Mapper trả đầu ra: key = `word`, value = `1`.

```rust
map emits:
("hello",1),
("world",1)
("hello",1),
("hadoop",1)
("goodbye",1),
("world",1)
```

#### Bước 2: Combiner, Spill và Sort cục bộ trên mỗi node mapper

Nếu được bật cấu hình này, combiner nhận nhiều value cùng key trên cùng node và gộp.
Ví dụ trên node chứa hai dòng của "hello", combiner có thể xuất `("hello", 2)` thay vì hai cặp riêng rẽ.
Từ đó, giảm số cặp phải gửi qua mạng, giảm I/O và thời gian shuffle.

Mapper có bộ đệm để lưu trữ output; khi đầy, dữ liệu được lưu ra ổ cứng và tạo thành một spill, mỗi spill được sắp xếp theo key.
Cuối khi mapper hoàn tất, các spill được merge-sorted thành một luồng sắp xếp theo key để chuyển vào giai đoạn shuffle.

#### Bước 3: Shuffle & Sort toàn cục

Hệ thống lấy các khóa từ mọi mapper, xác định reducer đích bằng partitioner, và truyền các phần dữ liệu tương ứng tới reducer đó.

Mỗi reducer nhận dữ liệu đã sort theo key.
Nếu một key nằm ở nhiều mapper, tất cả values tương ứng sẽ đến cùng reducer và được group lại.

#### Bước 4: Reducer

Reducer nhận `word` và list các giá trị `1` — đếm số lượng phần tử trong list.
Cuối cùng ghi ra output.

```rust
reduce input for "hello": [1, 1]
reducer computes count = 2

reduce input for "world": [1, 1]
reducer computes count = 2

reduce input for "hadoop": [1]
reducer computes count = 1

reduce input for "goodbye": [1]
reducer computes count = 1
```

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/3_hadoop_ecosystem/images/3-map-reduce/map_reduce.jpeg" style="width: 800px;"/>

## 3. Ví dụ: Tính giá trị trung bình nhiệt độ theo sensor

### 3.1. Dữ liệu mẫu (input)

```makefile
s1,2025-12-01T10:00:00,22.5
s2,2025-12-01T10:01:00,18.0
s1,2025-12-01T10:05:00,23.0
s2,2025-12-01T10:06:00,19.5
s3,2025-12-01T10:07:00,30.0
```

Kết quả mong muốn (output):

```makefile
s1    22.75  (tổng 45.5 / 2)
s2    18.75  (tổng 37.5 / 2)
s3    30.0   (tổng 30.0 / 1)
```

### 3.2. Thiết kế Map – Reduce

#### Bước 1: InputSplit & Mapper

- Hệ thống chia file thành các `InputSplit`, mỗi split được xử lý bởi một `Mapper`.
- Mỗi dòng được parse: `sensorId = s1`, `temp = 22.5`.
- Mapper trả đầu ra: key = `sensorId`, value = (sum = `temp`, count = 1).

```rust
map emits:
(s1) -> (22.5,1)
(s2) -> (18.0,1)
(s1) -> (23.0,1)
(s2) -> (19.5,1)
(s3) -> (30.0,1)
```

#### Bước 2: Combiner, Spill và Sort cục bộ trên mỗi node mapper

Nếu được bật cấu hình này, combiner nhận nhiều value cùng key trên cùng node và gộp.
Ví dụ trên node chứa hai dòng của s1, combiner có thể xuất `(s1) -> (45.5, 2)` thay vì hai cặp riêng rẽ.
Từ đó, giảm số cặp phải gửi qua mạng, giảm I/O và thời gian shuffle.

Mapper có bộ đệm để lưu trữ output; khi đầy, dữ liệu được lưu ra ổ cứng và tạo thành một spill, mỗi spill được sắp xếp theo key.
Cuối khi mapper hoàn tất, các spill được merge-sorted thành một luồng sắp xếp theo key để chuyển vào giai đoạn shuffle.

#### Bước 3: Shuffle & Sort toàn cục

Hệ thống lấy các khóa từ mọi mapper, xác định reducer đích bằng partitioner, và truyền các phần dữ liệu tương ứng tới reducer đó.

Mỗi reducer nhận dữ liệu đã sort theo key.
Nếu một key nằm ở nhiều mapper, tất cả values tương ứng sẽ đến cùng reducer và được group lại.

#### Bước 4: Reducer

Reducer nhận `sensorId` và list các giá trị `(partial_sum, partial_count)` — cộng tất cả `partial_sum` lại, cộng tất cả `partial_count` lại.

Cuối cùng tính `average = total_sum / total_count` và ghi ra output.

```rust
reduce input for s1: [(22.5,1), (23.0,1)]  (hoặc nếu combiner đã chạy: [(45.5,2)])
reducer computes total_sum = 45.5, total_count = 2 → average = 22.75

reduce input for s2: [(18.0,1), (19.5,1)]  (hoặc nếu combiner đã chạy: [(37.5,2)])
reducer computes total_sum = 37.5, total_count = 2 → average = 18.75

reduce input for s3: [(30.0,1)]
reducer computes total_sum = 30.0, total_count = 1 → average = 30.0
```
