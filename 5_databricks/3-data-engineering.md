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
| ------------------------- | ---------- |
| 1. Là khung ETL khai báo giúp đơn giản hóa quy trình tiết kiệm chi phí ETL trực tuyến và theo lô. | 1. Là dịch vụ điều phối tác vụ đa năng trên đám mây, được quản lý hoàn toàn cho toàn bộ nền tảng. |
| 2. Cung cấp khả năng tự mở rộng theo từng lượng công việc và quan sát các pipeline. | 2. Dành cho DE, DS và DA để xây dựng quy trình dữ liệu, phân tích và AI đáng tin cậy. |
| 3. Đơn giản hóa quy trình ETL, cho phép DE tập trung vào việc biến đổi dữ liệu thay vì quản lý vận hành. | 3. Giao diện dễ sử dụng với chức năng point-and-click. |
| 4. Dùng trong quá trình Data Ingestion và Transformation. | 4. Các pipeline của DLT có thể là một tác vụ trong Workflow. |
|  | 5. Dùng với các công việc phụ thuộc lẫn nhau hoặc theo lịch. |
|  | 6. Dùng với các công việc liên quan đến Machine Learning với MLFlow notebook. |
|  | 7. Dùng với API bên ngoài, các đoạn code và các tác cụ tuỳ chỉnh. |


---

## Luyện tập

<details>
<summary>Câu hỏi trắc nghiệm</summary>

**1. Ba tính năng và lợi ích chính mà Delta Live Tables (DLT) mang lại cho kỹ thuật dữ liệu trong Databricks là gì?**

**A.** Công cụ trực quan hóa dữ liệu

**B.** Hỗ trợ tinh chỉnh cơ sở hạ tầng thủ công

**C.** Hỗ trợ hợp nhất xử lý theo lô và streaming

**D.** Khung ETL khai báo

**E.** Xử lý tối ưu chỉ dành cho batch

**F.** Quản lý cơ sở hạ tầng tự động

**2. Vai trò của Databricks Workflows là gì?**

**A.** Cung cấp bảng điều khiển để theo dõi tất cả chi phí liên quan đến dữ liệu trong và ngoài nền tảng.

**B.** Quản lý cơ sở hạ tầng đám mây từ một giao diện duy nhất trong Databricks.

**C.** Điều phối tất cả các loại công việc trong nền tảng, cung cấp luồng điều khiển, trình kích hoạt và giám sát.

**3. Lợi ích chính của việc Delta Lake hỗ trợ giao dịch ACID là gì?**

**A.** Tăng cường tạo trực quan hóa dữ liệu

**B.** Đảm bảo độ tin cậy và nhất quán của dữ liệu

**C.** Tăng tốc độ sao chép dữ liệu

**D.** Tăng dung lượng lưu trữ

**4. Sản phẩm nào cung cấp khả năng kiểm soát truy cập tập trung, kiểm tra, theo dõi dòng dữ liệu và khám phá dữ liệu trên nhiều không gian làm việc của Databricks?**

**A.** Unity Catalog

**B.** Delta Lake

**C.** MosaicAI

**D.** DatabricksIQ

**5. Khi làm việc trong Databricks, bạn có một bảng tên là `customers` nằm trong schema `apj_region`. Schema này thuộc catalog `fin_serv`. Truy vấn nào sẽ chọn đúng tất cả các dòng từ bảng bằng Databricks SQL trên một dòng?**

**A.** `SELECT * FROM customers;`

**B.** `SELECT * FROM fin_serv.apj_region.customers;`

**C.** `SELECT * FROM apj_region.customers;`

**D.** `SELECT * FROM customers.apj_region.fin_serv;`

**6. Hai tính năng nào của Databricks là công cụ chính được sử dụng cho ETL và Orchestration trong nền tảng?**

**A.** Databricks SQL

**B.** Databricks Runtimes

**C.** Databricks Workflows

**D.** Delta Live Tables

**7. Là một kỹ sư dữ liệu, ba nhiệm vụ chính mà bạn chịu trách nhiệm trong Databricks Data Intelligence Platform là gì?**

**A.** Tạo và chia sẻ các phân tích trong dashboard

**B.** Thiết kế, xây dựng và duy trì các pipeline dữ liệu

**C.** Đảm bảo chất lượng và tính toàn vẹn của dữ liệu

**D.** Chuyển đổi dữ liệu thô thành dữ liệu sạch, đáng tin cậy

**E.** Thiết kế và chạy thử nghiệm để xây dựng mô hình ML

**8. Ba tính năng mong muốn nào có sẵn trong data lake khi sử dụng Delta Lake?**

**A.** Một khung quản trị dữ liệu toàn diện để tăng khả năng kiểm soát và minh bạch

**B.** Phân tích tích hợp để giám sát và trực quan hóa dữ liệu trong hồ dữ liệu

**C.** Hỗ trợ giao dịch ACID trên tất cả dữ liệu được lưu trữ trong hồ dữ liệu

**D.** Ghi nhật ký giao dịch tự động cho mọi thay đổi trên bảng

**E.** Tiến hóa và thực thi schema tự động cho bảng

**9. Bảng `customers` trong Databricks có 7 phiên bản. Truy vấn nào dưới đây sẽ lấy đúng dữ liệu từ phiên bản 3 của bảng `customers`?**

**A.** `SELECT * FROM customers VERSION AS OF 3`

**B.** `SELECT * FROM customers VERSION 3`

**C.** `SELECT * FROM customers HISTORY WHERE version = 3`

**D.** `SELECT * FROM customers VERSION &3`

**10. Câu nào đúng về tính chất idempotency của câu lệnh `COPY INTO` trong Databricks?**

**A.** `COPY INTO` sẽ ghi đè toàn bộ bảng đích mỗi khi được thực thi.

**B.** Chạy `COPY INTO` nhiều lần sẽ dẫn đến việc thêm các dòng trùng lặp vào bảng đích.

**C.** `COPY INTO` sẽ bỏ qua các bản ghi đã tải, giúp chạy nhiều lần mà không tạo dữ liệu trùng lặp.

**D.** `COPY INTO` yêu cầu can thiệp thủ công để xóa các bản sao nếu chạy nhiều lần.

**11. Trong kiến trúc Medallion của Databricks, mục đích chính của lớp Bronze là gì?**

**A.** Lưu trữ dữ liệu thô, chưa được xử lý khi nhập từ nhiều nguồn khác nhau

**B.** Lưu trữ dữ liệu tổng hợp cấp cao sẵn sàng cho báo cáo kinh doanh

**C.** Cung cấp tập dữ liệu được tinh chỉnh và làm giàu cho phân tích

**D.** Dùng làm bản sao lưu dữ liệu lịch sử để khôi phục khi hệ thống gặp sự cố

**12.Trong Databricks, công cụ nào thường được sử dụng để điều phối một pipeline đầu-cuối bao gồm nhập dữ liệu, chuyển đổi dữ liệu và thực thi thuật toán ML?**

**A.** Databricks Workflows

**B.** Databricks SQL

**C.** Databricks Delta Live Tables (DLT)

**D.** Databricks Notebooks

</details>

<details>
<summary>Đáp án</summary>

**1. B, D, F** vì Delta Live Tables giúp đơn giản hóa việc xây dựng pipeline dữ liệu bằng cách hỗ trợ cả xử lý theo lô (batch) và luồng (streaming). DLT sử dụng phương pháp khai báo (declarative ETL), nghĩa là người dùng chỉ cần khai báo dữ liệu đầu vào, logic xử lý, còn Databricks tự động tối ưu hóa. DLT cũng giúp quản lý hạ tầng tự động, giảm công sức bảo trì.

**2. C** vì Databricks Workflows giúp tự động hóa quy trình xử lý dữ liệu, hỗ trợ lên lịch chạy job và theo dõi hiệu suất.

**3. B** vì hỗ trợ giao dịch ACID giúp Delta Lake duy trì tính nhất quán và đáng tin cậy của dữ liệu, ngay cả khi có lỗi hệ thống hoặc nhiều người cùng thao tác dữ liệu.

**4. A** vì Unity Catalog cung cấp quyền truy cập tập trung, kiểm tra, theo dõi dòng dữ liệu và khám phá dữ liệu trên nhiều không gian làm việc Databricks.

**5. B** vì trong Databricks SQL, truy vấn đầy đủ phải bao gồm cả **catalog.schema.table** để đảm bảo truy xuất chính xác dữ liệu.

**6. C, D** vì Databricks Workflows: Dùng để điều phối quy trình ETL tự động. Delta Live Tables: Dùng để xây dựng và quản lý pipeline dữ liệu liên tục.

**7. B, C, D** vì đó là trách nhiệm cốt lõi của kỹ sư dữ liệu trong Databricks.

**8. C, D, E** vì Delta Lake hỗ trợ giao dịch ACID, tự động điều chỉnh schema và lịch sử thay đổi dữ liệu.

**9. A** vì cú pháp `VERSION AS OF` giúp truy xuất dữ liệu từ một phiên bản cụ thể của bảng.

**10. C** vì tính chất idempotency của `COPY INTO` giúp bỏ qua các bản ghi đã tải trước đó, tránh việc nhập dữ liệu trùng lặp.

**11. A** vì trong kiến trúc **Medallion** của Databricks: Bronze layer chứa dữ liệu thô từ các nguồn khác nhau. Silver layer làm sạch và xử lý dữ liệu. Gold layer chứa dữ liệu sẵn sàng cho phân tích và báo cáo.

**12. A** vì Databricks Workflows là công cụ giúp điều phối toàn bộ pipeline từ ingestion, transformation, đến ML execution.

</details>

<details>
<summary>Demo</summary>

**1. Thao tác với Delta Table**

**2. Ingest dữ liệu vào Delta Lake**

**3. Biến đổi dữ liệu sử dụng kiến trúc Medallion**

**4. Xây một workflow cơ bản trên DataBricks**

</details>
