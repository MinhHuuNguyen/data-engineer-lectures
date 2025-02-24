---
time: 11/01/2025
title: Xử lý dữ liệu với DataBricks
description: DataBricks là một nền tảng xử lý dữ liệu thông minh, giúp người dùng quản lý dữ liệu một cách hiệu quả và linh hoạt.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/intro.png
tags: []
is_highlight: false
is_published: true
---

## 1. Tổng quan về quy trình ETL trong DataBricks

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/overall.png" style="width: 1200px;"/>

## 2. DeltaLake - Lưu trữ dữ liệu linh hoạt và hiệu quả

Delta Lake là một giao thức mã nguồn mở phục vụ cho việc đọc và ghi file dữ liệu vào các kho dữ liệu đám mây.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/delta_lake.png" style="width: 1200px;"/>

Delta Lake đảm bảo giao dịch ACID - ACID Transactions ở cấp độ bảng cho dữ liệu được lưu trữ trong bộ lưu trữ đối tượng trên nền tảng đám mây.
- Tính nguyên tử (Atomicity): Toàn bộ giao dịch được thực hiện hoàn chỉnh.
- Tính nhất quán (Consistency): Dữ liệu tuân thủ các quy tắc, nếu không sẽ bị hoàn tác.
- Tính độc lập (Isolation): Một giao dịch được hoàn thành trước khi giao dịch khác bắt đầu.
- Tính bền vững (Durability): Dữ liệu được lưu ở trạng thái bền vững sau khi hoàn tất.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/delta_lake_table.png" style="width: 1200px;"/>

Delta Lake hỗ trợ các phép DML (Data Manipulation Language) như:
- INSERT: thêm các bản ghi mới
- UPDATE: cập nhật các giá trị
- DELETE: xoá các bản ghi
- MERGE: Truy vấn bản ghi từ bảng nguồn và thực hiện nhiều phép DML ở bảng đích.

Delta Lake có tính năng Time Travel, lưu giữ các nhật ký giao dịch với mỗi phiên bản (mỗi lần ghi) của các bảng
- Lịch sử truy vấn
- Các snapshot độc lập
- Lịch sử kiểm soát

Delta Lake hỗ trợ các tính năng schema:
- Schema Evolution: Delta Lake tự động tinh chỉnh schema của bảng khi dữ liệu thay đổi.
- Schema Enforcement: Delta Lake đảm bảo các bản ghi dữ liệu khi được đưa vào bảng sẽ phù hợp với schema của bảng đã được định nghĩa từ trước.

Delta Lake hỗ trợ đồng nhất giữa xử lý theo lô (batching) và xử lý trực tuyến (streaming), theo dõi và tối ưu hiệu năng và khả năng mở rộng metadata.

## 3. Data Ingestion - Nhập dữ liệu vào Delta Lake

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/ingestion.png" style="width: 1200px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/ingestion_create.png" style="width: 1200px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/ingestion_copy.png" style="width: 1200px;"/>

## 4. Data Transformation - Biến đổi dữ liệu trong Delta Lake

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/transformation.png" style="width: 1200px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/transformation_architecture.png" style="width: 1200px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/transformation_bronze.png" style="width: 1200px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/transformation_silver.png" style="width: 1200px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/transformation_gold.png" style="width: 1200px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/transformation_bronze_silver_gold.png" style="width: 1200px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/transformation_bronze_silver_gold_complex.png" style="width: 1200px;"/>

## 5. Data Orchestration - Xây dựng workflow trong DataBricks

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/3-data-engineering/orchestration.png" style="width: 1200px;"/>

--------------------------------------
| Delta Live Tables (DLT) | Workflow |
|-------------------------|----------|


---

## Luyện tập

<details>
<summary>Câu hỏi trắc nghiệm</summary>

</details>

<details>
<summary>Đáp án</summary>

</details>

<details>
<summary>Demo</summary>

**1. Thao tác với Delta Table**

**2. Ingest dữ liệu vào Delta Lake**

**3. Biến đổi dữ liệu sử dụng kiến trúc Medallion**

**4. Xây một workflow cơ bản trên DataBricks**

</details>
