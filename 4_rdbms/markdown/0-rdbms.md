---
time: 04/28/2023
title:
description:
banner_url:
tags: []
is_highlight: false
is_published: false
---

Bài giảng: Mô hình lưu trữ dữ liệu cho Dữ liệu có cấu trúc
Mục tiêu bài giảng

Sau bài này, học viên sẽ:

Hiểu các mô hình lưu trữ phổ biến dành cho dữ liệu có cấu trúc và khi nào nên dùng mỗi mô hình.

Nắm được khác biệt giữa row-store và column-store, tác động tới hiệu năng truy vấn.

Biết các kỹ thuật thực tế: chuẩn hóa/phi chuẩn hóa, phân vùng, phân mảnh (sharding), chỉ mục, nén và mã hóa.

Hiểu các yếu tố vận hành: tính nhất quán/điều khoản giao dịch (ACID/MVCC), sao lưu/phục hồi, bảo mật và quản trị dữ liệu.

Có bộ thực hành / quyết định để thiết kế hệ thống lưu trữ cho các bài toán OLTP/OLAP/HTAP.

1. Tổng quan & phân loại theo mục đích sử dụng

Dữ liệu có cấu trúc: dữ liệu có schema cố định (cột/kiểu rõ ràng) — ví dụ bảng RDBMS, bảng trong data warehouse, Parquet/ORC file có schema.

Mục tiêu lưu trữ khác nhau dẫn tới mô hình khác nhau:

OLTP (Giao dịch trực tuyến): nhiều giao dịch nhỏ, yêu cầu độ trễ thấp, ACID. Thường dùng row-store RDBMS.

OLAP (Phân tích / báo cáo): truy vấn tập lớn, scan cột, nén cao, throughput cao. Thường dùng columnar DB hoặc data warehouse.

HTAP (Hybrid Transactional/Analytical): một hệ thống xử lý cả giao dịch và phân tích (những trade-off phức tạp).

Phân loại kỹ thuật: Row-oriented RDBMS, Columnar DB / Data Warehouse, Key-value/Map store (khi cần lookup rất nhanh), Distributed file formats (Parquet/ORC) cho big-data.

2. Mô hình quan hệ (Relational) — logic & vật lý
2.1 Logic (schema)

Bảng, cột, kiểu dữ liệu, ràng buộc (PK, FK, UNIQUE, CHECK), quan hệ (1-n, n-m).

Thiết kế chuẩn (normalization): tránh dư thừa, tăng tính nhất quán.

1NF, 2NF, 3NF, BCNF — mục tiêu chính: loại bỏ dư thừa và anomaly khi cập nhật.

2.2 Vật lý

Row-store (hàng lưu theo record liên tiếp): tối ưu cho OLTP (đọc/ghi một hàng nhiều cột).

Column-store (cột lưu liên tiếp): tối ưu cho OLAP (scan cột, nén tốt).

Storage engines: mỗi DB có engine khác nhau (transaction log, buffer pool, MVCC). Quan trọng khi quyết định hiệu năng ghi/đọc và tính nhất quán.

3. Row-store vs Column-store — so sánh và hệ quả
Tiêu chí	Row-store	Column-store
Tốt cho	Transactional, read/write theo hàng	Aggregate, scan cột, analytic queries
Truy vấn loại	SELECT * WHERE id = ?	SELECT SUM(col) WHERE ...
Nén	Khó nén hiệu quả cho cùng cột	Nén rất hiệu quả (đồng kiểu, lặp lại)
I/O	Đọc toàn hàng => nhiều I/O khi chỉ cần vài cột	Đọc cột cần thiết => ít I/O
Update	Cập nhật nhiều cột trong hàng dễ dàng	Update tốn kém (phụ thuộc engine)

Hệ quả kiến trúc: chọn row-store cho hệ thống giao dịch, column-store/Parquet cho kho dữ liệu phân tích.

4. Kỹ thuật thiết kế schema cho dữ liệu có cấu trúc
4.1 Chuẩn hóa vs Phi chuẩn hóa

Chuẩn hóa (normalize): giảm dư thừa, tốt cho OLTP, dễ duy trì ràng buộc.

Phi chuẩn hóa (denormalize): giảm JOIN, tăng tốc đọc báo cáo, thường dùng cho OLAP hoặc caches/materialized views.

4.2 Mô hình dữ liệu OLAP

Star schema: fact table + multiple dimension tables — dễ hiểu và tối ưu cho phân tích.

Snowflake schema: dimension được chuẩn hóa thêm — giảm dung lượng, phức tạp hơn.

4.3 Ví dụ SQL (OLTP)
CREATE TABLE customer (
  customer_id BIGINT PRIMARY KEY,
  name VARCHAR(200),
  email VARCHAR(200) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
  order_id BIGINT PRIMARY KEY,
  customer_id BIGINT REFERENCES customer(customer_id),
  amount DECIMAL(12,2),
  status VARCHAR(50),
  created_at TIMESTAMP
);

4.4 Ví dụ (OLAP star schema)
-- Fact table
CREATE TABLE sales_fact (
  sale_id BIGINT,
  product_id INT,
  store_id INT,
  date_id DATE,
  units_sold INT,
  revenue DECIMAL(18,2),
  PRIMARY KEY(sale_id)
);

-- Dimension
CREATE TABLE dim_product (
  product_id INT PRIMARY KEY,
  product_name TEXT,
  category TEXT
);

5. Chỉ mục (Indexing) — nguyên tắc & chiến lược

B-tree: chỉ mục chung cho range queries, equality + order-by.

Hash index: equality lookup nhanh (không hỗ trợ range).

Bitmap index: rất tốt cho cột có độ cardinal thấp trong kho dữ liệu.

Composite index: thứ tự cột trong index quan trọng.

Covering index: index chứa đủ cột để tránh lookup table.

Full-text index: tìm kiếm văn bản.

Nguyên tắc:

Đánh đổi: chỉ mục tăng tốc đọc nhưng làm chậm ghi và tốn dung lượng.

Index nên dùng cho cột thường xuất hiện trong WHERE, JOIN, ORDER BY.

Giám sát usage và periodically rebuild/compact nếu cần.

6. Phân vùng (Partitioning) và Phân mảnh (Sharding)

Partitioning (trong một node / cluster): chia bảng theo phạm vi ngày, hash, list. Giúp query prune (loại bỏ phân vùng không cần thiết), quản lý dữ liệu cũ, VACUUM/maintenance dễ hơn.

Ví dụ: PARTITION BY RANGE (created_at).

Sharding (cross-node): chia dữ liệu sang nhiều node theo key (user_id % N) — để scale storage và throughput. Phức tạp hơn: routing, rebalancing, transaction xuyên-shard.

Lưu ý:

Chọn key phân vùng/shard cẩn trọng để tránh “hot shard”.

Thiết kế query route-aware nếu hệ thống phân tán.

7. MVCC, Transaction log, và tính nhất quán

MVCC (Multi-Version Concurrency Control): tạo snapshot cho các transaction đọc mà không chặn ghi; phổ biến trong InnoDB, PostgreSQL.

WAL (Write-Ahead Log): ghi log trước khi apply để đảm bảo recoverability.

ACID (Atomicity, Consistency, Isolation, Durability) — bắt buộc với hệ thống giao dịch.

Một số hệ thống phân tán theo hướng BASE (Basically Available, Soft state, Eventually consistent) — trade-off khi cần availability/partition tolerance.

8. File formats & lưu trữ cho Big Data có cấu trúc

Parquet và ORC: columnar, hỗ trợ predicate pushdown, encoding & compression — phù hợp cho data lakes / analytics.

Avro: row-based, schema evolution tốt, thường dùng cho streaming/message.

Khi tạo pipeline: xuất dữ liệu từ RDBMS -> ghi Parquet partitioned by date -> load vào data warehouse.

9. Compression & encoding

Kỹ thuật: dictionary encoding, run-length encoding, delta encoding, bit-packing.

Column-store hưởng lợi lớn từ compression vì cùng kiểu và phổ biến giá trị lặp.

Trade-off: nén mạnh giảm I/O nhưng tăng CPU để nén/giải nén.

10. Hiệu năng truy vấn & tối ưu hóa

**Avoid SELECT ***; chỉ lấy cột cần thiết.

Sử dụng partition pruning, predicate pushdown (khi dùng columnar files).

Materialized views cho truy vấn phức tạp lặp lại.

Query profiling: execution plan, explain analyze — tìm bottleneck (IO, CPU, network).

Caching: application cache, Redis, materialized caches.

11. Bảo mật, kiểm soát truy cập và quản trị dữ liệu

Authentication & Authorization: RBAC, least privilege.

Encryption at rest (disk/file) và in transit (TLS).

Auditing: ghi log truy vấn, thay đổi schema.

Data masking / masking policies cho dữ liệu nhạy cảm (PII).

Metadata & Data Catalog: quản lý schema, lineage, owners.

12. Sao lưu, phục hồi, High Availability

Logical backups: dump (SQL), phù hợp cho restore cấp độ bảng.

Physical snapshots: block-level snapshot (fast), thường kết hợp với replication.

Point-in-time recovery (PITR): dựa trên WAL/transaction logs.

Replication (master-slave / leader-follower / multi-master): tăng availability và đọc scaling.

Disaster recovery plan: RPO (mất dữ liệu tối đa chấp nhận) và RTO (thời gian phục hồi).

13. Giám sát & vận hành

Metrics quan trọng: latency (p95/p99), throughput (txn/s), lock contention, cache hit ratio, disk IO, replication lag.

Alerts cho: growth disk, long-running queries, failed backups, replication lag.

Thực hiện capacity planning theo growth rate và query patterns.

14. Lựa chọn công nghệ theo bài toán (tóm tắt ngắn)

Hệ thống giao dịch (Ngân hàng, ERP): RDBMS row-store (Postgres, MySQL/InnoDB), ACID, normalized schema.

Kho dữ liệu phân tích (Báo cáo, BI): Columnar DB / Data Warehouse (Snowflake, Redshift, BigQuery) hoặc Parquet trên data lake.

Event sourcing / streaming: store as Avro/Parquet in lake + OLAP downstream.

Lookup rất nhanh / cache: key-value store (Redis) cho các truy vấn đơn giản.

15. Case study ngắn

Bài toán: hệ thống đặt hàng (OLTP) + báo cáo doanh thu theo ngày (OLAP).

Giải pháp thực tế:

OLTP: PostgreSQL row-store, normalized schema, dùng B-tree index trên order_id, customer_id.

Realtime ETL: CDC (Change Data Capture) -> chuyển đổi -> ghi vào data lake dưới dạng Parquet partitioned by date.

Data warehouse cho báo cáo: star schema, columnar storage, materialized views cho báo cáo hàng ngày.

16. Thực hành / Bài tập

Thiết kế schema normalized cho hệ thống quản lý thư viện (sách, tác giả, mượn trả). Sau đó tạo một view denormalized để báo cáo sách mượn nhiều nhất.

So sánh hiệu năng scan một truy vấn aggregate trên cùng dữ liệu lưu ở row-store vs columnar: mô tả cách đo (throughput, CPU, I/O).

Lập kế hoạch sao lưu và phục hồi cho database có 2 TB dữ liệu, yêu cầu RPO = 15 phút, RTO = 1 giờ — mô tả kiến trúc.

17. Tóm tắt & Kết luận

Không có “một kích cỡ phù hợp cho tất cả”: lựa chọn mô hình lưu trữ phải dựa trên workload (OLTP vs OLAP), patterns truy vấn, yêu cầu nhất quán và chi phí.

Thiết kế schema, chỉ mục, partitioning, và lựa chọn giữa row/column quyết định lớn tới hiệu năng.

Vận hành (sao lưu, replication, monitoring, bảo mật, governance) là phần không thể thiếu để hệ thống thực tế bền vững.