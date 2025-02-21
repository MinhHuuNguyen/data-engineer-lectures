---
time: 11/01/2025
title: Kiến trúc của DataBricks
description: 
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/intro.png
tags: []
is_highlight: false
is_published: true
---

## 1. Data Intelligence Platform của DataBricks gồm những thành phần nào?

Data Intelligence Platform nói chung là một nền tảng có khả năng hiểu dữ liệu của doanh nghiệp và hỗ trợ người dùng một cách thông minh.

Một số tiêu chí của một Data Intelligence Platform:
- Định dạng mở: Hỗ trợ nhiều định dạng dữ liệu khác nhau
- Không còn “data silo”: Dữ liệu được tổ chức một cách logic, dễ dàng truy cập và chia sẻ
- Quản trị nhất quán: Dữ liệu được quản lý một cách nhất quán trên một màn hình
- Quyền riêng tư dữ liệu: Dữ liệu được bảo mật và phân quyền cụ thể
- Chi phí thấp hơn và tốc độ nhanh hơn: Có các cơ chế hỗ trợ tối ưu chi phí và tăng tốc độ xử lý dữ liệu
- Truy cập vào công nghệ tiên tiến nhất: Liên tục cập nhật công nghệ mới nhất
- Hỗ trợ cho nhân viên không chuyên về kỹ thuật: Dễ sử dụng, không cần kiến thức chuyên sâu về kỹ thuật

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/data_intelligence_platform.png" style="width: 1200px;"/>

Đi sâu hơn vào kiến trúc của DataBricks, ta có thể chia thành 2 phần chính: Control Plane và Data Plane.
- Control Plane: Cung cấp giao diện tương tác với người dùng và tương tác với các ứng dụng (thông qua API calls).
    - Unity Catalog: Cung cấp giao diện quản lý tập trung được phân theo các danh mục rõ ràng (Metastore), hỗ trợ phân quyền và chia sẻ dữ liệu an toàn (Access control) và quản lý tài nguyên và nhân sự (Workspace management).
    - Control Plane cho phép và hỗ trợ người dùng và ứng dụng tương tác với dữ liệu thông qua nhiều cách khác nhau như Web App, MosaicAI, Workflows, Git Folders, Notebooks, DBSQL.
- Data Plane: Cung cấp các dịch vụ lưu trữ (Storage) và tính toán (Elastic Compute).
    - Elastic Compute: Cung cấp các máy ảo, máy chủ ảo để thực thi các công việc tính toán.
    - Storage: Cung cấp các dịch vụ lưu trữ dữ liệu như S3, ADLS, GCS.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/data_intelligence_platform_infrastructure.png" style="width: 1200px;"/>

## 2. Chi tiết về Control Plane - Unity Catalog

Unity Catalog là một dịch vụ quản lý tập trung, giúp người dùng quản lý dữ liệu một cách hiệu quả và linh hoạt.
Đây chính là thành phần tạo nên yếu tố **unified data platform** của DataBricks.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/logo_unity_catalog.png" style="width: 600px;"/>

Bất kể bạn là Data Engineer, Data Scientist hay Data Analyst và bạn có nhu cầu truy cập vào thành phần nào của dữ liệu như Data Lake, Data Warehouse, Metadata hay Machine Learning. Unity Catalog đều cung cấp cho bạn một giao diện quản lý dữ liệu trực quan và dễ sử dụng.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/unity_catalog.png" style="width: 1200px;"/>

Môt số tính năng chính có thể sử dụng từ Unity Catalog:
- Discovery: Tìm kiếm và khám phá dữ liệu một cách dễ dàng.
- Access control: Quản lý quyền truy cập dữ liệu một cách linh hoạt.
- Lineage: Theo dõi nguồn gốc của dữ liệu.
- Data sharing: Chia sẻ dữ liệu một cách an toàn.
- Auditing: Theo dõi và ghi lại các hoạt động trên dữ liệu.
- Monitoring: Giám sát hiệu suất và tình trạng của hệ thống xử lý dữ liệu.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/unity_catalog_functions.png" style="width: 800px;"/>

Từ những tính năng trên, Unity Catalog giúp người dùng:
- Thống nhất quản trị trên các dịch vụ đám mây khác nhau
    - Quản trị chi tiết cho các data lake trên các dịch vụ như AWS, GCP, Azure
    - Dựa trên chuẩn mở ANSI SQL - American National Standards Institute Structured Query Language
- Thống nhất dữ liệu và “tài sản” AI
    - Chia sẻ, kiểm tra, bảo mật và quản lý tập trung tất cả các loại dữ liệu bằng một giao diện đơn giản.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/data_governance_problems.png" style="width: 1200px;"/>

## 3. Chi tiết về Data Plane - Delta Lake

Data Plane của DataBricks được cung cấp dưới dạng dịch vụ được gọi là Delta Lake.
Delta Lake là dịch vụ bao gồm cả lưu trữ và tính toán, giúp người dùng xử lý dữ liệu một cách hiệu quả và linh hoạt.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/logo_delta_lake.png" style="width: 600px;"/>

Tầng dưới cùng của DataBricks Data Intelligence Platform là Open Data Lake, nơi lưu trữ dữ liệu nguyên thô, bao gồm cả dữ liệu có cấu trúc, bán cấu trúc và phi cấu trúc. Và DataBricks hỗ trợ cả 3 nhà cung cấp dịch vụ cloud lớn trên thế giới là AWS, Azure và GCP.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/aws_azure_gcp.png" style="width: 600px;"/>

Đối với dịch vụ tính toán, DataBricks cung cấp các loại hình dịch vụ tính toán phù hợp với các đặc thù công việc khác nhau trong quá trình xử lý dữ liệu:

- **All-purpose compute:** dành cho các công việc xử lý dữ liệu chung, không yêu cầu tài nguyên máy tính cao.
- **Instance Pool:** dành cho các công việc xử lý dữ liệu cần tài nguyên máy tính cao, có thể mở rộng linh hoạt.
- **Photon:** công cụ tính toán hiệu suất cao của DataBricks, tận dụng tối ưu Apache Spark.
- **SQL Warehouse:** dành cho các công việc xử lý dữ liệu dạng bảng, truy vấn dữ liệu bằng SQL và các công cụ BI.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/data_intelligence_platform_serverless.png" style="width: 1200px;"/>

Với mục tiêu tối ưu hoá hiệu suất và chi phí, DataBricks cung cấp mô hình tính toán Serverless, giúp người dùng không cần quan tâm đến việc quản lý tài nguyên máy chủ.
Với kiến trúc Serverless, người dùng chỉ cần tập trung vào việc viết mã, còn việc quản lý tài nguyên máy chủ, tối ưu hiệu suất sẽ được DataBricks thực hiện tự động.

Điều này sẽ giúp hệ thống tiết kiệm chi phí khi nhu cầu tính toán thấp và dễ dàng nâng cao hiệu suất nhu cầu tính toán tăng lên.

## 4. AI mang lại giá trị gì trong hệ thống của DataBricks?

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/without_ai.png" style="width: 1200px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/with_ai.png" style="width: 1200px;"/>
