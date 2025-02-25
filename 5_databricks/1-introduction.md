---
time: 11/01/2025
title: Giới thiệu chung về DataBricks
description: DataBricks là một nền tảng dữ liệu hợp nhất (unified data platform) dựa trên đám mây, được thiết kế để hỗ trợ các nhu cầu về xử lý dữ liệu lớn, khoa học dữ liệu và máy học.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/intro.png
tags: []
is_highlight: false
is_published: true
---

## 1. Vấn đề mà DataBricks mong muốn giải quyết là gì?

Đội ngũ của DataBricks cho rằng "Dữ liệu có mặt ở khắp mọi nơi và mọi người cần tận dụng dữ liệu để phục vụ cho các mục đích khác nhau."
Họ cũng nhấn mạnh "Người chiến thắng ở trong bất kỳ một ngành công nghiệp nào là công ty tận dụng và kết hợp được giữa dữ liệu và trí tuệ nhân tạo."

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/statement.png" style="width: 600px;"/>

Tuy nhiên, chưa kể việc các công ty không nhận ra được tầm nhìn này, mà việc tận dụng dữ liệu là không dễ dàng do có quá nhiều khâu, quá nhiều công đoạn cần phải thực hiện để khai khác các khía cạnh khác nhau của dữ liệu.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/vision.png" style="width: 1200px;"/>

Các vấn đề mà DataBricks mong muốn giải quyết bao gồm:

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/problems.png" style="width: 1200px;"/>

Ngoài dữ liệu thô được thu thập về, trong quá trình xử lý và sử dụng dữ liệu, có nhiều dẫn xuất của dữ liệu được sinh ra.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/data_type_problem.png" style="width: 400px;"/>

Đồng thời, theo thời gian, doanh nghiệp có thể mở rộng các vị trí liên quan đến dữ liệu, do đó, số lượng các vài trò liên quan đến dữ liệu cũng tăng lên, dẫn đến việc quản trị dữ liệu trở nên phức tạp hơn.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/consumer_problem.png" style="width: 1200px;"/>

## 2. DataBricks là gì?

Databricks là một **nền tảng dữ liệu hợp nhất (unified data platform)** dựa trên đám mây, được thiết kế để hỗ trợ các nhu cầu về **xử lý dữ liệu lớn (big data), khoa học dữ liệu (data science) và máy học (machine learning)**.

Lợi ích của Databricks:
- **Hiệu suất cao:** Tối ưu hóa các quy trình xử lý dữ liệu lớn.
- **Dễ sử dụng:** Cung cấp giao diện trực quan và các công cụ mạnh mẽ cho cả người mới bắt đầu lẫn chuyên gia.
- **Linh hoạt:** Hỗ trợ nhiều ngôn ngữ lập trình và công cụ, thích hợp cho nhiều vai trò khác nhau như kỹ sư dữ liệu, nhà khoa học dữ liệu và nhà phân tích.
- **Tiết kiệm chi phí:** Tích hợp và quản lý trên đám mây giúp giảm chi phí so với các hệ thống truyền thống.

DataBrick giúp người dùng **thay vì phải quản lý nhiều tài nguyên đến từ nhiều nhà cung cấp khác nhau một cách độc lập**, DataBricks cung cấp một **nền tảng quản lý tập trung**, thân thiện, dễ sử dụng hơn dành cho người dùng.

## 3. DataBricks giải quyết các vấn đề trên bằng cách nào?

### 3.1. Data Lakehouse

DataBricks giải quyết các vấn đề trên bằng cách xây dựng một mô hình quản trị dữ liệu mới, gọi là **Data Lakehouse**.
Kết hợp các ưu điểm của Data Lake và Data Warehouse, Data Lakehouse giúp giảm thiểu các hạn chế của cả hai mô hình truyền thống.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/lakehouse_combination.png" style="width: 1200px;"/>

Một số ưu điểm của Data Lakehouse:
- Kiến trúc đồng nhất: Dữ liệu được lưu trữ trong một hệ thống duy nhất, giúp giảm thiểu sự phân mảnh.
- Môi trường mở: Hỗ trợ nhiều ngôn ngữ lập trình và công cụ, giúp tăng cường sự linh hoạt và tính tương tác.
- Tối ưu chi phí và khả năng mở rộng: Tích hợp và quản lý trên đám mây giúp giảm chi phí so với các hệ thống truyền thống.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/lakehouse_paper.png" style="width: 800px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/lakehouse_timeline.png" style="width: 300px;"/>

Kiến trúc của Data Lakehouse được công bố bởi DataBricks gồm:
- Data Science & AI: Các dịch vụ liên quan đến Khoa học dữ liệu và Trí tuệ nhân tạo.
- ETL & Real-time Analytics: Các dịch vụ liên quan đến xử lý dữ liệu và phân tích dữ liệu thời gian thực.
- Orchestration: Các dịch vụ liên quan đến quản lý tập trung và tự động hóa quy trình xử lý dữ liệu.
- Data Warehousing: Các dịch vụ liên quan đến lưu trữ dữ liệu và truy vấn dữ liệu.
- Unity Catalog: Các dịch vụ liên quan đến bảo mật và phân quyền dữ liệu,
- Delta Lake Uniform: Các dịch vụ lưu trữ với hiệu năng và độ tin cậy cao.
- Open Data Lake: Các dịch vụ liên quan đến lưu trữ dữ liệu phi cấu trúc như logs, văn bản, âm thanh, hình ảnh, video.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/lakehouse.png" style="width: 1200px;"/>

### 3.2. Data Intelligence Platform

Đến những năm gần đây, với sự bùng nổ của Trí tuệ nhân tạo trong việc hỗ trợ các công việc của con người, DataBricks tích hợp Trí tuệ nhân tạo vào rất sâu trong hệ thống, từ đó cung cấp một nền tảng dữ liệu tốt hơn - Data Intelligence Platform.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/data_intelligence_platform_idea.png" style="width: 800px;"/>

Ý tưởng chính mà DataBricks nêu ra ở đây là việc kết hợp các hệ thống ChatBot (được xây dựng từ các mô hình Generative AI - Trí tuệ nhân tạo tạo sinh) vào trong hệ thống quản trị dữ liệu.
Để xây dựng được sự kết hợp này, DataBricks đã mua lại MosaicML để có đội ngũ nhân sự tốt nhất, phục vụ mục tiêu tích hợp Trí tuệ nhân tạo vào trong hệ thống quản trị dữ liệu.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/data_intelligence_platform_mosaic_ai.png" style="width: 600px;"/>

Từ đó, người dùng có "một người trợ lý ảo" sẵn sàng hỗ trợ để giúp thực thi các tác vụ một cách nhanh chóng và dễ dàng hơn.
Điểm nâng cấp lớn này được gọi là DataBricks IQ.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/data_intelligence_platform.png" style="width: 1200px;"/>

## 4. Ai sẽ là người sử dụng DataBricks?

Với việc cung cấp một hệ thống quản trị dữ liệu thông minh, DataBricks sẵn sàng phục vụ cho nhiều đối tượng người dùng khác nhau và nhiều công việc khác nhau trong quá trình xử lý dữ liệu.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/users.PNG" style="width: 1200px;"/>
