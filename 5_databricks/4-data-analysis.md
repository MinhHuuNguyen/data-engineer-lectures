---
time: 11/01/2025
title: Phân tích dữ liệu và BI trên DataBricks
description: DataBricks cung cấp các công cụ phân tích dữ liệu và Business Intelligence (BI) để giúp người dùng trực quan hóa dữ liệu, xây dựng dashboard và báo cáo, và phân tích dữ liệu một cách hiệu quả.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/intro.png
tags: []
is_highlight: false
is_published: true
---

## 1. Vai trò và thách thức của Data Analyst

Vai trò của Data Analyst:
- **Thu thập, làm sạch và xử lý dữ liệu:** Sau khi xác định vấn đề cần giải quyết bằng dữ liệu, sắp xếp và chọn dữ liệu cần thiết để phân tích, làm sạch và xử lý dữ liệu cùng với các Data Engineer.
- **Phân tích khai phá dữ liệu (EDA):** Thực hiện phân tích thăm dò để hiểu các đặc điểm, mô hình, xu hướng và giá trị ngoại lệ của dữ liệu; phát triển các giả thuyết và thống kê tóm tắt.
- **Mô hình hoá, phân tích và trình bày dữ liệu:** Sử dụng hình ảnh trực quan, bảng thông tin và các phương pháp khác để trình bày các phát hiện và kết luận cho các bên liên quan; cập nhật tài liệu trình bày khi có thông tin mới.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/4-data-analysis/unified_architecture.png" style="width: 1200px;"/>

Thách thức của Data Analyst:
- **Dữ liệu cô lập và đa hệ thống:** Các dữ liệu cần thiết nằm rải rác trên nhiều nền tảng. Team dữ liệu hoạt động riêng lẻ, thiếu nhất quán.
- **Chất lượng dữ liệu:** Data Lake và Data Warehouse có những hạn chế, dẫn đến mất thời gian trong việc có dữ liệu sạch và phân tích.
- **Quản trị và tuân thủ:** Mỗi nền tảng trong hệ sinh thái có cấu trúc quản trị khác nhau. Việc quản lý dữ liệu nhạy cảm trở nên phức tạp trong một hệ thống rời rạc.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/4-data-analysis/warehouse_vs_lake.png" style="width: 1200px;"/>

## 2. DataBricks SQL

DataBricks SQL là một bộ công cụ đầy đủ phục vụ cho BI và phân tích dữ liệu.
- Được hỗ trợ bởi Delta Lake, Databricks SQL cung cấp môi trường thống nhất cho batch processing và streaming processing.
- Databricks SQL sẵn sàng cho doanh nghiệp, nghĩa là bạn có thể sử dụng nó cho khối lượng công việc lớn trong thực tế.
- DataBricks SQL dễ quản lý.

Một số đặc điểm của Databricks SQL:
- **Tối ưu hoá với AI:** Tính toán serverless tự động và được tối ưu hóa, có thể mở rộng cho mọi khối lượng dữ liệu và truy vấn phức tạp.
- **Trải nghiệm thông minh:** Giao diện ngôn ngữ tự nhiên do AI cung cấp; với khả năng hiểu dữ liệu và doanh nghiệp của bạn được tích hợp sẵn.
- **Kiến trúc hợp nhất:** Thu thập, chuyển đổi và truy vấn tất cả từ một nền tảng duy nhất; đáp ứng đầy đủ nhu cầu về kho dữ liệu và BI trong khi vẫn cung cấp quyền truy cập đầy đủ vào các khả năng của AI

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/4-data-analysis/unified_sql_editor.png" style="width: 1200px;"/>

Trình soạn thảo SQL thống nhất giúp:
- Duyệt tất cả dữ liệu của bạn với các câu truy vấn.
- Hỗ trợ tự động hoàn thành, tự động định dạng và các phím tắt.
- Soạn thảo và kiểm tra các truy vấn sau đó chia sẻ và thêm chúng vào mục yêu thích.

## 3. AI/BI Dashboard

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/4-data-analysis/bi_dashboard_example.png" style="width: 1000px;"/>

Là công cụ all-in-one, có thể phục vụ cả trực quan hoá và trình bày phân tích dữ liệu.
- Thêm tập dữ liệu, viết truy vấn và thiết kế hình ảnh trực quan trong một môi trường.
- Dễ dàng chia sẻ để trình bày và xem xét.
- Sử dụng ngôn ngữ tự nhiên để hỗ trợ việc tạo hình ảnh trực quan.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/4-data-analysis/bi_dashboard.png" style="width: 800px;"/>

BI Genie Spaces mang lại khả năng:
- Hỗ trợ người dùng non-tech với giải pháp không code để có được thông tin chi tiết về dữ liệu bằng ngôn ngữ tự nhiên.
- Cung cấp điểm truy cập vào dữ liệu để theo dõi các câu hỏi mà không cần phải nhờ đến chuyên gia phân tích dữ liệu.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/4-data-analysis/sql_genie_spaces.png" style="width: 1200px;"/>

Sử dụng AI để tăng trải nghiệm người dùng:
- Tài liệu do Al tạo ra để tìm kiếm và khám phá dữ liệu dễ dàng hơn.
- Trợ lý Al để sửa code nhanh, truy vấn và mô tả.
- Trợ lý Al để tạo hình ảnh trực quan nhanh chóng.
- Genie Spaces do Al cung cấp để nhanh chóng hiểu dữ liệu của bạn bằng ngôn ngữ tự nhiên.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/4-data-analysis/sql_dashboard_genie_menu.png" style="width: 300px;"/>

## 4. Tích hợp sâu với Power BI và Tableau

Tích hợp liền mạch các danh mục và mô hình dữ liệu với Power BI và Tableau.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/4-data-analysis/power_bi_tableau.png" style="width: 1200px;"/>

---

## Luyện tập

<details>
<summary>Câu hỏi trắc nghiệm</summary>

**1. Hai công cụ nào hiện có trong các giải pháp AI/BI của Databricks?**

**A.** AI/BI Dashboards

**B.** AI/BI Genie

**C.** AI/BI Features

**D.** AI/BI Workflows

**2. Là một nhà phân tích dữ liệu, hai nhiệm vụ chính của bạn khi làm việc với Databricks Data Intelligence Platform là gì?**

**A.** Trình bày các thông tin chi tiết cho các bên liên quan

**B.** Phát triển các pipeline nhập dữ liệu

**C.** Quản lý quản trị dữ liệu

**D.** Khám phá dữ liệu và chi tiết của nó

**3. Khi làm việc trong Databricks, bạn có một bảng tên là `customers` nằm trong schema `apj_region`. Schema này thuộc catalog `fin_serv`. Truy vấn nào dưới đây sẽ chọn đúng tất cả các dòng từ bảng đó bằng Databricks SQL trên một dòng lệnh?**

**A.** `SELECT * FROM customers.apj_region.fin_serv;`

**B.** `SELECT * FROM customers;`

**C.** `SELECT * FROM apj_region.customers;`

**D.** `SELECT * FROM fin_serv.apj_region.customers;`

**4. Khi tạo một AI/BI Dashboard, bước đầu tiên là gì?**

**A.** Thêm một widget vào canvas

**B.** Thêm tập dữ liệu vào bảng điều khiển

**C.** Chỉnh sửa cài đặt trong bảng cấu hình của dashboard

**D.** Công khai bảng điều khiển để các bên liên quan có thể xem

**5. Databricks SQL Warehouse là gì?**

**A.** Một môi trường giao diện người dùng cho kho dữ liệu trong Databricks

**B.** Một framework khai báo để xây dựng các pipeline xử lý và phân tích dữ liệu

**C.** Một tập hợp các công cụ phân tích dữ liệu trong Databricks (ví dụ: SQL Editor, Alerts, Dashboards)

**D.** Một tùy chọn tính toán được thiết kế và tối ưu hóa đặc biệt cho các khối công việc SQL

**6. Hai cách nào bạn có thể thêm tập dữ liệu vào bảng điều khiển?**

**A.** Kết nối với DLT Pipeline

**B.** Tạo từ SQL

**C.** Nhập tệp nhỏ

**D.** Chọn bảng từ một schema và catalog

**7. Tài sản dữ liệu nào được sử dụng trong Genie Spaces?**

**A.** Functions

**B.** Volumes

**C.** Models

**D.** Tables

**8. Tính năng nào của Databricks được sử dụng để chạy truy vấn trong Databricks SQL? Chọn một đáp án.**

**A.** Bảng điều khiển (Dashboards)

**B.** Trình chỉnh sửa SQL (SQL Editor)

**C.** Bộ lập lịch công việc (Job scheduler)

**D.** Kho dữ liệu SQL (SQL warehouses)

**9. Mục đích chính của Databricks SQL là gì?**

**A.** Cung cấp hiệu suất/giá thành tốt hơn và đơn giản hóa việc khám phá cho các công cụ BI.

**B.** Quản lý quản trị và giám sát kho dữ liệu.

**C.** Hỗ trợ nhiều công cụ BI, bao gồm Tableau và Power BI.

**D.** Tất cả các đáp án trên.

**10. Phát biểu nào sau đây về kiến trúc huy chương (medallion architecture) của Lakehouse là đúng?**

**A.** Lớp bạc (Silver) dành cho báo cáo và sử dụng các mô hình dữ liệu phi chuẩn hóa, tối ưu hóa để đọc với ít phép nối hơn.

**B.** Chỉ áp dụng các quy tắc chuyển đổi và làm sạch dữ liệu tối thiểu hoặc "vừa đủ" cho mỗi lớp trong kiến trúc huy chương.

**C.** Dữ liệu trong một bảng đầu vào duy nhất có thể được sử dụng để tạo nhiều bảng đầu ra khác nhau.

**D.** Lớp vàng (Gold) cung cấp cái nhìn tổng quan về tất cả các thực thể, khái niệm và giao dịch kinh doanh chính.

**11. Mô tả nào sau đây về chất lượng dữ liệu của lớp vàng trong kiến trúc huy chương của Lakehouse là đúng?**

**A.** Lớp vàng bao gồm dữ liệu tổng hợp sạch, sẵn sàng sử dụng trong sản xuất cho một trường hợp cụ thể.

**B.** Cấu trúc bảng trong lớp vàng phản ánh nguyên trạng cấu trúc bảng của hệ thống nguồn.

**C.** Trọng tâm của lớp vàng là khả năng nhanh chóng thực hiện Change Data Capture và cung cấp kho lưu trữ lịch sử nếu cần mà không cần đọc lại dữ liệu từ hệ thống nguồn.

**D.** Lớp vàng kết hợp dữ liệu từ nhiều nguồn khác nhau thành một cái nhìn tổng thể của doanh nghiệp.

**12. Mục đích chính của lớp đồng (Bronze) trong mô hình "đồng-bạc-vàng" của Delta Lake là gì?**

**A.** Lưu trữ dữ liệu ở định dạng phù hợp cho các dự án hoặc báo cáo kinh doanh riêng lẻ.

**B.** Thực hiện làm sạch dữ liệu, kết nối và làm giàu dữ liệu thô.

**C.** Cung cấp một "nguồn chân lý duy nhất" cho doanh nghiệp trên các dự án khác nhau.

**D.** Nhanh chóng nhập dữ liệu thô, giữ nguyên định dạng ban đầu của nó cho cả dự án hiện tại và tương lai.


**13. Phát biểu nào sau đây mô tả mối quan hệ giữa lớp bạc và lớp vàng của dữ liệu? Chọn một đáp án.**

**A.** Lớp vàng là nơi chứa tất cả dữ liệu từ các hệ thống nguồn bên ngoài, được đại diện bởi lớp bạc.

**B.** Lớp vàng chứa dữ liệu ít sạch hơn lớp bạc.

**C.** Phân tích tự phục vụ được kích hoạt cho lớp vàng để báo cáo tự do trong lớp bạc.

**D.** Các quy tắc kinh doanh theo dự án được áp dụng từ lớp bạc sang lớp vàng.

**14. Một nhà phân tích dữ liệu cần tạo trực quan hóa từ truy vấn sau, loại trực quan hóa nào phù hợp nhất để hiển thị kết quả của truy vấn này?**

```sql
SELECT order_date  
FROM sales  
WHERE order_date >= to_date('2020-01-01')  
AND order_date <= to_date('2021-01-01');
```

**A.** Biểu đồ cột (Bar chart)

**B.** Biểu đồ phễu (Funnel)

**C.** Biểu đồ cột xếp chồng (Stacked bar chart)

**D.** Biểu đồ hộp (Boxplot)

**15. Loại trực quan hóa nào sau đây hiển thị một số duy nhất theo mặc định?**

**A.** Biểu đồ cột (Bar chart)

**B.** Bản đồ - điểm đánh dấu (Map - markers)

**C.** Bộ đếm (Counter)

**D.** Biểu đồ phễu (Funnel)

</details>

<details>
<summary>Đáp án</summary>

**1. A, B** vì AI/BI Dashboards giúp tạo các bảng điều khiển trực quan hóa dữ liệu, còn AI/BI Genie là công cụ hỗ trợ AI và tự động hóa để tạo báo cáo và truy vấn thông minh hơn.

**2. A, D** vì nhà phân tích dữ liệu chủ yếu tập trung vào khám phá dữ liệu, truy vấn dữ liệu và trực quan hóa dữ liệu để cung cấp insight cho các bên liên quan. Các nhiệm vụ như phát triển pipeline nhập dữ liệu hoặc quản lý quản trị dữ liệu thường là trách nhiệm của Data Engineer hoặc Data Governance Team.

**3. D** vì trong Databricks SQL, cú pháp để truy vấn bảng theo hierarchy là `CATALOG.SCHEMA.TABLE`. `fin_serv` là catalog, `apj_region` là schema, `customers` là bảng. Câu lệnh đúng là `SELECT * FROM fin_serv.apj_region.customers;`.

**4. B** vì bước đầu tiên khi tạo AI/BI Dashboard là thêm tập dữ liệu vào bảng điều khiển. Sau đó, người dùng mới có thể thêm widget, chỉnh sửa cấu hình hoặc xuất bản.

**5. D** vì Databricks SQL Warehouse là một tùy chọn tính toán được thiết kế và tối ưu hóa đặc biệt cho các khối công việc SQL. Nó giúp cải thiện hiệu suất xử lý truy vấn dữ liệu lớn trong Databricks.

**6. B, D** vì người dùng có thể thêm dữ liệu vào dashboard bằng cách tạo truy vấn SQL hoặc chọn trực tiếp bảng từ schema và catalog có sẵn. Các tùy chọn khác như Kết nối với DLT Pipeline hay Nhập tệp nhỏ không phổ biến cho việc tạo dashboard.

**7. D** vì Tables là loại tài sản dữ liệu chính được sử dụng để lưu trữ và truy vấn dữ liệu trong Genie Spaces. Các tài sản khác như Functions, Volumes, Models không phải là phần chính của Genie Spaces.

**8. B** vì SQL Editor là công cụ chính để chạy các truy vấn SQL trong Databricks SQL, cho phép người dùng viết, kiểm tra và thực thi truy vấn trên dữ liệu trong kho dữ liệu Databricks.

**9. D** vì Databricks SQL cung cấp hiệu suất tối ưu với chi phí hợp lý, hỗ trợ các công cụ BI phổ biến như Tableau và Power BI, đồng thời giúp đơn giản hóa việc tìm kiếm và khám phá dữ liệu.

**10. C** vì trong kiến trúc huy chương (Medallion Architecture), dữ liệu từ một bảng ở lớp bạc (Silver) có thể được chuyển hóa thành nhiều bảng khác nhau ở lớp vàng (Gold) để phục vụ các mục đích kinh doanh khác nhau.

**11. D** vì lớp vàng (Gold) trong kiến trúc Medallion được tối ưu hóa để cung cấp góc nhìn tổng thể về doanh nghiệp bằng cách tổng hợp dữ liệu từ nhiều nguồn khác nhau, giúp phục vụ báo cáo chiến lược và phân tích nâng cao.

**12. D** vì lớp đồng (Bronze) trong kiến trúc Delta Lake lưu trữ dữ liệu thô mà không cần xử lý, giúp đảm bảo dữ liệu luôn sẵn sàng để sử dụng khi cần và giữ nguyên tính toàn vẹn của dữ liệu gốc.

**13. D** vì lớp bạc (Silver) chứa dữ liệu đã được làm sạch và xử lý cơ bản. Khi dữ liệu chuyển từ lớp bạc sang lớp vàng (Gold), các quy tắc kinh doanh cụ thể sẽ được áp dụng để phục vụ nhu cầu phân tích riêng của từng dự án.

**14. A** vì truy vấn này trả về danh sách các ngày đặt hàng, do đó biểu đồ cột là lựa chọn tốt nhất để hiển thị số lượng đơn hàng theo ngày. Boxplot được dùng để hiển thị phân bố dữ liệu, không phù hợp cho tập dữ liệu ngày tháng đơn giản. Stacked bar chart được sử dụng để so sánh nhiều danh mục trong cùng một trục thời gian. Funnel dùng để phân tích kênh chuyển đổi, không phù hợp với dữ liệu ngày tháng.

**15. C** vì Counter hiển thị một số duy nhất, chẳng hạn như tổng số đơn hàng hoặc doanh thu tổng. Bar chart và Funnel hiển thị nhiều giá trị, không phải một số duy nhất. Map - markers hiển thị vị trí trên bản đồ, không phải số đơn lẻ.

</details>

<details>
<summary>Demo</summary>

**1. Thao tác với Delta Table**

**2. Ingest dữ liệu vào Delta Lake**

**3. Biến đổi dữ liệu sử dụng kiến trúc Medallion**

**4. Xây một workflow cơ bản trên DataBricks**

</details>
