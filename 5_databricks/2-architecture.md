---
time: 11/01/2025
title: Kiến trúc của DataBricks
description: Data Intelligence Platform của DataBricks gồm những thành phần nào? Chi tiết về Control Plane - Unity Catalog và Data Plane - Delta Lake. AI mang lại giá trị gì trong hệ thống của DataBricks?
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

Nếu không có AI, người dùng dữ liệu có thể gặp phải một số vấn đề như:

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/without_ai.png" style="width: 1200px;"/>

Nhưng với AI, người dùng dữ liệu sẽ được hỗ trợ một cách thông minh, giúp họ thực thi các tác vụ một cách nhanh chóng và dễ dàng hơn.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/2-architecture/with_ai.png" style="width: 1200px;"/>

---

## Luyện tập

<details>
<summary>Câu hỏi trắc nghiệm</summary>

**1. Vai trò của các bình luận được tạo bằng AI trong Databricks là gì?**

**A.** Cho phép các nhà phát triển nhập bình luận vào mã của họ một cách hiệu quả để dễ đọc và tài liệu hóa.

**B.** Tự động tạo các bình luận cho bảng và cột, cải thiện khả năng tìm kiếm và giao diện ngôn ngữ tự nhiên.

**C.** Tạo trực quan hóa dữ liệu và cung cấp phản hồi ngay lập tức về độ chính xác của những trực quan hóa đó.

**2. Phát biểu nào mô tả vai trò của Unity Catalog trong nền tảng Databricks Data Intelligence?**

**A.** Unity Catalog kết hợp dữ liệu của bạn với công cụ DatabricksIQ để hỗ trợ trực quan hóa dữ liệu bằng AI.

**B.** Unity Catalog cung cấp một giao diện duy nhất để quản lý quyền trên toàn nền tảng, kiểm toán và chia sẻ dữ liệu cho tất cả các nhu cầu quản trị dữ liệu và AI của bạn.

**C.** Unity Catalog là một giải pháp lưu trữ dữ liệu để quản lý tất cả tài sản dữ liệu và AI của bạn, bao gồm dữ liệu có cấu trúc, bán cấu trúc và phi cấu trúc.

**3. Ba tài nguyên nào tồn tại trong control plane của Databricks?**

**A.** Lưu trữ đối tượng dữ liệu

**B.** Unity Catalog

**C.** Workflows

**D.** Tài nguyên tính toán

**E.** Notebooks

**4. Ba lợi ích nào được cung cấp trực tiếp bởi Databricks?**

**A.** Hiệu suất tối ưu trên phần cứng on-premise

**B.** Có sẵn trên và giữa nhiều nền tảng đám mây

**C.** Cung cấp phương pháp bảo mật và quản trị thống nhất cho tất cả tài sản dữ liệu

**D.** Được xây dựng trên mã nguồn mở và tiêu chuẩn mở

**E.** Cung cấp lưu trữ dữ liệu đám mây có thể mở rộng và dự phòng

**5. Ý nghĩa của việc Databricks mua lại MosaicML là gì?**

**A.** Nâng cao hỗ trợ trực quan hóa dữ liệu của Databricks để hỗ trợ BI rộng hơn.

**B.** Mở rộng khả năng lưu trữ đám mây của kiến trúc lakehouse của Databricks.

**C.** Mở rộng hỗ trợ và khả năng của Databricks vào thị trường cơ sở hạ tầng phần cứng.

**D.** Hỗ trợ nhu cầu về các mô hình và công cụ AI tạo sinh mạnh mẽ trong Databricks.

**6. Databricks hỗ trợ bảo mật và quản trị dữ liệu trên các nền tảng đám mây khác nhau như thế nào?**

**A.** Sử dụng nhiều công cụ bảo mật và quản trị dữ liệu trong nền tảng để hỗ trợ các trường hợp sử dụng khác nhau.

**B.** Phụ thuộc vào công cụ quản trị dữ liệu mà khách hàng ưa thích hoặc đã có sẵn trong cơ sở hạ tầng đám mây của họ.

**C.** Tận dụng cơ sở hạ tầng bảo mật hiện có của nhà cung cấp đám mây để kế thừa quyền và cài đặt quản trị.

**D.** Sử dụng Unity Catalog để cung cấp một lớp quản trị thống nhất cho tất cả tài sản dữ liệu và AI trong hệ sinh thái dữ liệu.

**7. Hai phát biểu nào mô tả kiến trúc data lakehouse và lợi ích của nó?**

**A.** Kiến trúc data lakehouse bổ sung một lớp quản trị để quản lý tài sản dữ liệu AI, kết nối nhiều nền tảng trong hệ sinh thái dữ liệu.

**B.** Kiến trúc data lakehouse kết hợp lợi ích của data warehouse và data lake bằng cách xây dựng một lớp quản lý và định dạng dữ liệu trên một data lake mở.

**C.** Kiến trúc data lakehouse cung cấp một công nghệ data warehouse mới, lưu trữ dữ liệu trên đám mây theo định dạng độc quyền.

**D.** Kiến trúc data lakehouse cung cấp một nền tảng hợp nhất cho tất cả các loại dữ liệu, hỗ trợ cả khối lượng công việc BI và AI.

**8. Ba lợi ích của serverless compute trong Databricks là gì?**

**A.** Minh bạch về chi phí sử dụng

**B.** Độ tin cậy được cải thiện

**C.** Cấu hình chi tiết và phức tạp

**D.** Trải nghiệm người dùng đơn giản hóa

**E.** Khả năng mở rộng nhanh hơn

</details>

<details>
<summary>Đáp án</summary>

**1. B** vì Databricks sử dụng AI để tự động tạo ra các bình luận cho bảng và cột dữ liệu, giúp người dùng dễ dàng tìm kiếm và hiểu dữ liệu hơn thông qua các truy vấn ngôn ngữ tự nhiên.

**2. B** vì Unity Catalog là một hệ thống quản trị dữ liệu tập trung, giúp kiểm soát quyền truy cập, quản lý dữ liệu và chia sẻ dữ liệu trong toàn bộ nền tảng Databricks.

**3. B, C, E** vì Control plane của Databricks chịu trách nhiệm quản lý metadata, điều phối công việc, và các tác vụ điều hành nền tảng. Unity Catalog giúp quản trị dữ liệu, Workflows quản lý pipeline dữ liệu, và Notebooks cung cấp môi trường phát triển. Data object storage và Compute resources thuộc Data plane, không phải Control plane.

**4. B, C, D** vì Databricks hỗ trợ nhiều nền tảng đám mây (AWS, Azure, Google Cloud). Nó cung cấp một cách tiếp cận bảo mật và quản trị thống nhất với Unity Catalog. Databricks dựa trên mã nguồn mở như Apache Spark, Delta Lake, MLflow.

**5. D** vì việc mua lại MosaicML giúp Databricks mở rộng khả năng xử lý AI tạo sinh, cho phép khách hàng huấn luyện và triển khai mô hình AI dễ dàng hơn.

**6. D** vì Unity Catalog giúp quản lý quyền truy cập, audit, và chia sẻ dữ liệu trên nhiều nền tảng đám mây.

**7. B, D** vì Data lakehouse kết hợp khả năng lưu trữ linh hoạt của Data Lake và hiệu suất cao của Data Warehouse. Hỗ trợ cả BI (Business Intelligence) và AI (Artificial Intelligence).

**8. A, B, E** vì Serverless compute giúp minh bạch hóa chi phí bằng cách tính phí theo mức sử dụng thực tế. Cải thiện độ tin cậy do không cần quản lý cụm tính toán. Tự động mở rộng để đáp ứng nhu cầu tính toán cao.
</details>
