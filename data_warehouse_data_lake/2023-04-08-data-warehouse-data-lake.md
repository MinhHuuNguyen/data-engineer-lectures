---
layout: post
title:  "Spark"
summary: "Spark"
author: minhhuunguyen
date: '2023-04-08 15:04:00 +1997'
category: math
thumbnail: /assets/img/posts/hello.jpg
keywords: vector
permalink: /blog/gioi-thieu-chung-ve-rest-api/
usemathjax: true
---

# Data lake và data warehouse

## 1. Data lake vs Data warehouse vs Data mart

Data lake, Data warehouse và Data mart là các giải pháp lưu trữ dữ liệu khác nhau.

Data warehouse lưu trữ dữ liệu dưới dạng có cấu trúc, là kho lưu trữ trung tâm của các dữ liệu đã được xử lý phục vụ cho quá trình phân tích dữ liệu hoặc business intelligence.

Data mart là data warehouse nhưng phục vụ cho một khía cạnh cụ thể của doanh nghiệp như tài chính, marketing hay nhân sự.



Ngược lại với data warehouse, data lake là kho lưu trữ trung tâm cho dữ liệu thô chưa được xử lý.
Các dữ liệu được thu thập từ nhiều nguồn, được lưu trữ ở đây và sẵn sàng để xử lý sau này.

||Data warehouse|Data lake|
|---|---|---|
|Loại dữ liệu|Dữ liệu có cấu trúc rõ ràng|Tất cả các loại dữ liệu từ các nguồn|
|Hình thức Schema|Cần thời gian phân tích thấu hiểu để xây dựng cấu trúc rõ ràng (Schema on Write)|Lựa chọn dữ liệu theo nhu cầu sử dụng (Schema on Read)|
|Tính linh hoạt|Tính linh hoạt thấp|Tính linh hoạt cao|

<img src="https://www.qubole.com/wp-content/uploads/2020/12/Dl-vs-DW-infograph-1000x563.png" style="width: 1200px;"/>

<img src="https://media.geeksforgeeks.org/wp-content/uploads/Capture-163.png" style="width: 800px;"/>

## 2. ETL vs ELT

ETL và ELT là hai cách truyền tải và tích hợp dữ liệu (data integration) vào trong data warehouse.

ETL, viết tắt của Extract, Transform và Load, là quá trình trích rút, biến đổi và chuyển vào trong data warehouse.

<img src="https://rivery.io/wp-content/uploads/2020/05/ETL-Process-for-linkedin3-1024x535.png" style="width: 800px;"/>

Khác với ETL, ELT, viết tắt của Extract, Load và Transform, thực hiện quá trình biến đổi ngay trong data warehouse, từ đó, trực tiếp đưa dữ liệu raw vào trong data warehouse xử lý và loại bỏ giai đoạn staging.

<img src="https://rivery.io/wp-content/uploads/2020/05/ETL-Process-for-linkedin.png" style="width: 800px;"/>

Từ đó, điểm khác nhau lớn nhất giữa ETL và ELT nằm ở việc ta transform dữ liệu ở đâu và đó cũng tạo ra những ưu nhược điểm của hai phương pháp.

||ETL|ELT|
|---|---|---|
|Đường đi dữ liệu|Dữ liệu được trích từ nguồn, qua server staging rồi mới vào data warehouse|Dữ liệu đi trực tiếp từ nguồn vào data warehouse và data lake|
|Kích thước dữ liệu|Dữ liệu kích thước nhỏ hơn|Dữ liệu kích thước lớn hơn|
|Phép biến đổi dữ liệu|Phép biến đổi phức tạp và đòi hỏi tính toán nhiều|Phép biến đổi đơn giản|
|Bảo mật dữ liệu|Dữ liệu được bảo mật cao hơn|Dữ liệu được bảo mật thấp hơn|
|Thời gian truyền tải dữ liệu|Khi kích thước dữ liệu tăng lên, thời gian chuyển đổi cũng tăng theo|Tốc độ không phụ thuộc vào kích thước của dữ liệu|
|Data lake|Không hỗ trợ data lake|Hỗ trợ data lake|
|Chi phí|Chi phí cao hơn|Chi phí thấp hơn|

<img src="https://panoply.io/uploads/versions/diagram8-1---x----750-376x---.jpg" style="width: 800px;"/>
