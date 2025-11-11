---
time: 09/09/2021
title: Giới thiệu chung về Big Data
description: Bài viết giới thiệu chung về Big Data và vai trò của Data Engineer nhằm cung cấp cho người học cái nhìn tổng quan về sự bùng nổ dữ liệu trong kỷ nguyên số và nhu cầu xử lý dữ liệu quy mô lớn trong doanh nghiệp hiện đại. Nội dung trình bày các đặc trưng của Big Data như Volume, Velocity, Variety và những thách thức trong việc lưu trữ, quản lý và khai thác dữ liệu. Bài viết cũng làm rõ vị trí của Data Engineer trong hệ thống dữ liệu như xây dựng kiến trúc dữ liệu, thiết kế pipeline thu thập – xử lý – phân phối dữ liệu và đảm bảo dữ liệu sẵn sàng cho phân tích, học máy.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/banner.jpeg
tags: [big-data]
is_highlight: false
is_published: true
---

## 1. So sánh Big data và cơ sở dữ liệu truyền thống

Big Data là thuật ngữ dùng để mô tả tập dữ liệu có quy mô rất lớn, phát sinh với tốc độ cao, và có nhiều dạng cấu trúc khác nhau đến mức mà các hệ thống xử lý dữ liệu truyền thống không thể đáp ứng hiệu quả.

Big Data thường đòi hỏi các công nghệ lưu trữ phân tán, thuật toán xử lý song song, và các mô hình phân tích nâng cao như học máy và trí tuệ nhân tạo.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/big_data_small_data.jpeg" style="width: 900px;"/>

Các hệ thống truyền thống thường chỉ đủ khả năng xử lý các tập dữ liệu có kích thước nhỏ hơn, với tốc độ sinh dữ liệu thấp hơn và chủ yếu là dữ liệu có cấu trúc.

Small Data đề cập đến các tập dữ liệu có quy mô nhỏ và vừa, dễ dàng được xử lý bằng các công cụ truyền thống như Excel, cơ sở dữ liệu quan hệ hay các phần mềm phân tích thống kê cơ bản.

Small Data thường có cấu trúc rõ ràng, yêu cầu chi phí phân tích và lưu trữ thấp hơn.

| Tiêu chí           | Big Data                             | Small Data                                     |
| ------------------ | ------------------------------------ | ---------------------------------------------- |
| Quy mô dữ liệu     | Rất lớn (TB → PB → EB)               | Nhỏ đến trung bình                             |
| Tốc độ phát sinh   | Liên tục theo thời gian thực         | Thường thu thập theo đợt hoặc định kỳ          |
| Đa dạng dữ liệu    | Cấu trúc, bán cấu trúc, phi cấu trúc | Chủ yếu có cấu trúc                            |
| Công cụ xử lý      | Hadoop, Spark, NoSQL, AI/ML          | Excel, SQL truyền thống, các phần mềm thống kê |
| Chi phí & hạ tầng  | Cao, yêu cầu phân tán & song song    | Thấp, dễ triển khai                            |
| Mục tiêu phân tích | Khai phá tri thức mới, dự đoán       | Mô tả, thống kê, ra quyết định nhanh           |
| Độ phức tạp        | Cao                                  | Thấp đến trung bình                            |

Big Data đóng vai trò quan trọng trong:
- Ra quyết định dựa trên dữ liệu (Data-driven decision making)
- Tự động hoá và tối ưu quy trình
- Phát hiện xu hướng và dự đoán tương lai
- Cá nhân hoá dịch vụ khách hàng
- Nâng cao khả năng cạnh tranh cho doanh nghiệp

Một số ứng dụng tiêu biểu của Big Data bao gồm:
- Khuyến nghị sản phẩm tại các nền tảng thương mại điện tử
- Phân tích hành vi người dùng trong quảng cáo số
- Chẩn đoán y tế dựa trên dữ liệu hình ảnh
- Phát hiện gian lận tài chính thời gian thực

## 2. Các đặc trưng của Big Data

### 2.1. Ba đặc trưng chính

Đặc điểm chính của big data bao gồm ba yếu tố chính: 3Vs (Volume, Velocity, Variety)

#### Volume — Dung lượng (khối lượng dữ liệu)

**Định nghĩa:** Khối lượng dữ liệu được tạo và lưu trữ (kích thước tổng cộng, khoảng từ terabytes (TB) đến petabytes (PB) hoặc thậm chí exabytes (EB)).

**Vai trò:** Là yếu tố cơ bản khiến các hệ thống truyền thống không còn đủ; ảnh hưởng đến kiến trúc lưu trữ, phân tán, chi phí và hiệu năng xử lý.
Thiết kế hệ thống, cơ sở dữ liệu, và chiến lược partitioning/archiving phải tính tới Volume.

**Ví dụ:**
- Một hệ thống log của nền tảng mạng xã hội tích luỹ hàng trăm TB mỗi tháng.
- Dữ liệu cảm biến IoT từ hàng triệu thiết bị tạo ra lượng dữ liệu lớn hàng ngày.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/volume_velocity_variety.jpeg" style="width: 900px;"/>

#### Velocity - Tốc độ (tốc độ sinh và xử lý dữ liệu)

**Định nghĩa:** Tốc độ dữ liệu được tạo, truyền tải và cần được xử lý (streaming, real-time, near-real-time).

**Vai trò:** Xác định yêu cầu về xử lý thời gian thực (stream processing), kiến trúc message queue, Latency SLA (Latency Service Level Agreement) và khả năng mở rộng ngang.
Ứng dụng phụ thuộc vào Velocity sẽ cần công nghệ khác (Kafka, Flink, kinesis…) so với batch processing.

**Ví dụ:**
- Dữ liệu cảm biến IoT gửi mỗi giây — hệ thống cần phát hiện anomaly ngay lập tức
- Dữ liệu giao dịch tài chính phải được phân tích trong vòng vài mili-giây để phòng chống gian lận.

#### Variety - Độ đa dạng (kiểu và nguồn dữ liệu)

**Định nghĩa:** Sự đa dạng về định dạng và nguồn dữ liệu: cấu trúc (RDBMS - Relational Database Management System), bán cấu trúc (JSON - JavaScript Object Notation, XML - eXtensible Markup Language), phi cấu trúc (text, image, video), streams, sensor, logs ...

**Vai trò:** Ảnh hưởng tới pipeline ETL/ELT, schema design (schema-on-read vs schema-on-write), khả năng tích hợp dữ liệu từ nhiều nguồn và lựa chọn công cụ để xử lý từng kiểu dữ liệu.

**Ví dụ:** Kết hợp dữ liệu CRM - Customer Relationship Management (dữ liệu quan hệ khách hàng), file CSV bán hàng, bình luận mạng xã hội (text), và ảnh sản phẩm để xây dựng profile khách hàng toàn diện.

### 2.2. Đặc trưng mở rộng theo nhu cầu quản trị dữ liệu

Ngoài ba đặc trưng cơ bản (Volume, Velocity, Variety) đã đề cập ở trên, ta có thêm 2 đặc trưng mở rộng khác, tạo thành mô hình 5Vs của Big Data theo nhu cầu quản trị dữ liệu: Veracity và Value.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/veracity_value.jpeg" style="width: 900px;"/>

#### Veracity - Độ tin cậy / tính xác thực của dữ liệu

**Định nghĩa:** Mức độ chính xác, nhất quán, đầy đủ và đáng tin cậy của dữ liệu; phản ánh noise, bias, missing values, hay inconsistencies.

**Vai trò:** Quyết định chất lượng phân tích và mô hình. Nếu veracity thấp thì kết luận sai lệch; vì vậy cần cơ chế data quality, cleansing, provenance, và đo lường uncertainty.

**Ví dụ:** Dữ liệu sensor có drift (độ lệch theo thời gian) dẫn tới báo động sai; hoặc dữ liệu nhập tay có nhiều lỗi chính tả, trùng lặp gây sai phân tích.

#### Value - Giá trị của dữ liệu

**Định nghĩa:** Khả năng trích xuất lợi ích kinh doanh hoặc tri thức hữu dụng từ dữ liệu — tức là liệu dữ liệu có tạo ra insight hay ROI thực tế hay không.

**Vai trò:** Nhắc rằng “có nhiều dữ liệu” không có nghĩa là hữu dụng; việc đầu tư xử lý big data phải cân nhắc chi phí — lợi ích, tập trung vào dữ liệu mang lại giá trị.

**Ví dụ:** Phân tích churn để giảm tỷ lệ khách rời giúp tăng doanh thu; so với thu thập một loại dữ liệu tốn kém nhưng không đem lại insight nào.

### 2.3. Đặc trưng mở rộng hướng tới chất lượng vận hành

Ta cũng có thể mở rộng thêm hai đặc trưng nữa, tạo thành mô hình 7Vs của Big Data theo nhu cầu chất lượng vận hành: Validity và Variability.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/variability_visualization.jpeg" style="width: 900px;"/>

#### Variability - Tính biến đổi (biến thể theo thời gian / ngữ cảnh)

**Định nghĩa:** Dữ liệu thay đổi theo thời gian hoặc theo ngữ cảnh: seasonal patterns, shifts trong distribution (concept drift), hoặc thay đổi định nghĩa/format giữa các nguồn.

**Vai trò:** Ảnh hưởng tới tính ổn định của model và pipeline; yêu cầu tái huấn luyện, monitoring, versioning của schema và model để xử lý drift và biến động.

**Ví dụ:** Hành vi mua sắm thay đổi theo mùa; thuật toán gợi ý cần cập nhật vì mô hình hành vi người dùng đã drift sau chiến dịch marketing lớn.

#### Visualization - Trực quan hóa dữ liệu

**Định nghĩa:** Khả năng biểu diễn dữ liệu và kết quả phân tích bằng biểu đồ, dashboard, visual analytics; đồng thời là độ khó khi trực quan hoá tập dữ liệu lớn/đa chiều.

**Vai trò:** Trực quan là cầu nối giữa dữ liệu thô và quyết định con người — giúp khám phá, debug, và truyền đạt insight. Với Big Data, visualization yêu cầu aggregation, sampling, hoặc kỹ thuật visual analytics quy mô lớn.

**Ví dụ:** Không thể vẽ trực tiếp 1 tỉ điểm rời trên scatter plot — cần dùng heatmap, binning, hay summaries; dashboard thời gian thực cho vận hành mạng dùng streaming aggregation.

### 2.4. Đặc trưng mở rộng hướng tới bảo mật dữ liệu

Cuối cùng, ta có thể mở rộng thêm hai đặc trưng nữa, tạo thành mô hình 9Vs của Big Data theo nhu cầu bảo mật dữ liệu: Validity và Vulnerability.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/validity_vulnerability.jpeg" style="width: 900px;"/>

#### Vulnerability - Tính dễ tổn thương / rủi ro bảo mật & quyền riêng tư

**Định nghĩa:** Rủi ro liên quan tới bảo mật, quyền riêng tư, tuân thủ — bao gồm leak dữ liệu, unauthorized access, hoặc bị tấn công qua pipeline dữ liệu.

**Vai trò:** Yêu cầu thiết kế an toàn: encryption-at-rest/in-transit, IAM, auditing, anonymization, data governance, và tuân thủ quy định (ví dụ GDPR). Là V quyết định tư cách pháp lý và đạo đức của dự án dữ liệu.

**Ví dụ:** Bộ dữ liệu người dùng bị lộ do cấu hình S3 public; hoặc dữ liệu y tế chưa được pseudonymize trước khi chia sẻ, gây rủi ro pháp lý.

#### Validity - Tính hợp lệ (tính phù hợp & hợp lệ của dữ liệu)

**Định nghĩa:** Mức độ dữ liệu phản ánh đúng ý nghĩa cần đo lường; dữ liệu có phù hợp với mục tiêu phân tích hay mô hình không (semantic correctness, đúng định dạng, đúng phạm vi giá trị).

**Vai trò:** Đảm bảo rằng dữ liệu được sử dụng đúng mục đích — xử lý trước khi phân tích (validation rules, schema checks, data contracts). Hạn chế lỗi logic và kết luận sai do dữ liệu “không hợp lệ”.

**Ví dụ:** Trường ngày tháng có giá trị “30/02/2024” (không tồn tại) hoặc nhiệt độ ghi âm bằng −999 tượng trưng cho missing nhưng chưa được map — những bản ghi như vậy cần validate trước khi dùng.

| Mô hình | Số lượng yếu tố | Trọng tâm                             |
| ------- | --------------- | ------------------------------------- |
| **3Vs** | 3               | Đặc tính cốt lõi của Big Data         |
| **5Vs** | +2              | Chất lượng và giá trị dữ liệu         |
| **7Vs** | +2              | Khai thác và trực quan hóa dữ liệu    |
| **9Vs** | +2              | Quản trị, an toàn và tuân thủ dữ liệu |

## 3. Các vai trò công việc trong lĩnh vực Big Data

### 3.1. Data Engineer – Kỹ sư dữ liệu

**Định nghĩa:** Data Engineer chịu trách nhiệm xây dựng và duy trì hệ thống thu thập, lưu trữ và xử lý dữ liệu ở quy mô lớn. Họ đảm bảo dữ liệu luôn sẵn sàng, sạch và có thể truy cập hiệu quả cho phân tích và mô hình hóa.

**Vai trò chính:**
- Thiết kế, phát triển kiến trúc dữ liệu (Data Warehouse, Data Lake)
- Xây dựng pipeline dữ liệu: thu thập → làm sạch → chuẩn hóa → lưu trữ
- Tối ưu hiệu năng xử lý dữ liệu lớn (Big Data Processing)
- Làm việc với hệ thống xử lý phân tán (Spark, Hadoop)
- Hỗ trợ Data Scientist và Data Analyst truy cập dữ liệu đúng chuẩn

**Yêu cầu công việc:**
- Thành thạo ngôn ngữ lập trình: Python, Java, Scala
- Kinh nghiệm với hệ quản trị cơ sở dữ liệu: SQL, NoSQL
- Hiểu biết công nghệ Big Data: Hadoop, Hive, Spark, Kafka
- Nắm vững ETL/ELT, Cloud Data Platform (AWS, GCP, Azure)
- Kiến thức tốt về kiến trúc hệ thống và DevOps

<p style="float: left;">
    <img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/de_role.jpeg" style="width: 500px;"/>
</p>
<p style="float: right;">
    <img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/da_role.jpeg" style="width: 500px;"/>
</p>
<br style="clear: both;"/>

### 3.3. Data Analyst – Chuyên viên phân tích dữ liệu

**Định nghĩa:** Data Analyst thu thập, phân tích và trực quan hóa dữ liệu để cung cấp insight hỗ trợ ra quyết định kinh doanh. Họ tập trung trả lời câu hỏi kinh doanh dựa trên dữ liệu hiện có.

**Vai trò chính:**
- Phân tích dữ liệu mô tả và chẩn đoán xu hướng
- Trực quan hóa dữ liệu bằng Dashboard và Báo cáo
- Hỗ trợ các phòng ban tìm KPI và giải thích kết quả kinh doanh
- Làm việc trực tiếp với dữ liệu có cấu trúc từ hệ thống doanh nghiệp
- Đề xuất chiến lược dựa trên bằng chứng dữ liệu

**Yêu cầu công việc:**
- Kỹ năng phân tích thống kê và xử lý dữ liệu: Excel, SQL, Python/R
- Thành thạo các công cụ BI: Power BI, Tableau, Looker
- Hiểu biết về nghiệp vụ kinh doanh và tư duy sản phẩm
- Kỹ năng truyền đạt thông tin hiệu quả (Data Storytelling)
- Khả năng đặt câu hỏi và giải thích dữ liệu cho nhà quản lý

| Tiêu chí      | Data Engineer                             | Data Analyst                  | Data Scientist                     |
| ------------- | ----------------------------------------- | ----------------------------- | ---------------------------------- |
| Trọng tâm     | Dữ liệu có sẵn & hạ tầng                  | Phân tích & trực quan         | Mô hình dự đoán & tối ưu           |
| Câu hỏi chính | Dữ liệu đến từ đâu? Trong trạng thái nào? | Điều gì đang xảy ra? Tại sao? | Điều gì sẽ xảy ra? Làm sao tối ưu? |
| Công cụ       | Spark, Kafka, SQL, Airflow                | Excel, SQL, Power BI, Tableau | Python, ML frameworks, Jupyter     |
| Gần với       | Hệ thống & Kỹ thuật                       | Kinh doanh                    | Toán – AI                          |
| Đầu ra        | Data pipeline                             | Insight, KPI, Dashboard       | Mô hình AI/ML                      |

### 3.3. Data Scientist – Nhà khoa học dữ liệu

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/ds_role.jpeg" style="width: 500px;"/>

**Định nghĩa:** Data Scientist xây dựng mô hình thống kê và Machine Learning để dự đoán, phân loại, tối ưu hoá và khai phá tri thức sâu hơn từ Big Data. Họ kết hợp toán học, lập trình và tư duy kinh doanh.

**Vai trò chính:**
- Nghiên cứu và xây dựng mô hình ML/AI
- Khai phá dữ liệu phức tạp, dữ liệu phi cấu trúc (text, ảnh…)
- Đánh giá, tối ưu mô hình và triển khai vào sản xuất (MLOps)
- Phối hợp với Data Engineer để đảm bảo dữ liệu chất lượng
- Biến dữ liệu thành giá trị gia tăng, sản phẩm AI

**Yêu cầu công việc:**
- Thành thạo Python và các thư viện ML (Scikit-learn, TensorFlow, PyTorch)
- Kiến thức sâu về xác suất – thống kê, tối ưu hóa
- Kỹ thuật xử lý dữ liệu lớn và NLP, CV (tuỳ lĩnh vực)
- Khả năng diễn giải mô hình và trình bày kết quả cho doanh nghiệp
- Hiểu biết MLOps, Cloud Deployment là lợi thế mạnh
