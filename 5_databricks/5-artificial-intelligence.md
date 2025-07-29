---
time: 03/14/2025
title: Trí tuệ nhân tạo trên DataBricks
description: DataBricks cung cấp các dịch vụ như MLFlow, AutoML và Model Serving để hỗ trợ việc triển khai các mô hình trí tuệ nhân tạo trở nên đơn giản hơn.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/intro.png
tags: []
is_highlight: false
is_published: true
---

## 1. MLFlow trong DataBricks

DataBricks cung cấp các dịch vụ để thực thi MLOps một cách hiệu quả bao gồm cả DataOps và ModelOps kết hợp với các công cụ DevOps để tạo ra một quy trình MLOps đầy đủ, làm việc mạnh mẽ và linh hoạt.

<p style="float: left;">
  <img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/mlops_1.png" style="width: 500px;"/>
</p>
<p style="float: right;">
  <img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/mlops_2.png" style="width: 500px;"/>
</p>
<br style="clear: both;"/>

MLFlow là một nền tảng quản lý mô hình mã nguồn mở, giúp quản lý các mô hình máy học, từ việc huấn luyện, đánh giá, triển khai và theo dõi mô hình.
Với MLFlow, Data Scientist và AI Engineer có thể dễ dàng xây dựng các mô hình Machine Learning, triển khai các thử nghiệm một cách nhanh chóng, đưa ra các phân tích và so sánh giữa các mô hình chính xác.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/mlflow.png" style="width: 500px;"/>

MLFlow cung cấp các thành phần chính:
- Tracking: Ghi lại các tham số, mô hình, kết quả và thời gian chạy của mô hình
- Projects: Quản lý các dự án Machine Learning, giúp tái sử dụng các mô hình và thử nghiệm
- Models: Quản lý các mô hình Machine Learning, giúp triển khai mô hình một cách dễ dàng
- Registry: Quản lý các mô hình Machine Learning, giúp theo dõi và quản lý các phiên bản mô hình

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/mlflow_components.png" style="width: 1200px;"/>

Trong đó, Model Registry giúp quản lý các mô hình Machine Learning hiệu quả.
- Lưu trữ tập trung các mô hình Machine Learning
- Cho phép phiên bản hoá các tài sản Machine Learning
- Dễ dành triển khai và so sánh đánh giá các thử nghiệm
- Tích hợp quy trình phê duyệt và quản trị
- Tự động hoá quá trình triển khai với CI/CD

## 2. AutoML trong DataBricks

AutoML là một công cụ tự động hóa việc xây dựng mô hình Machine Learning, giúp giảm thời gian và chi phí cho việc xây dựng mô hình Machine Learning.
AutoML giúp tìm ra mô hình tốt nhất cho dữ liệu mà không cần phải có kiến thức chuyên sâu về Machine Learning.

<p style="float: left;">
  <img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/automl_use_case_1.png" style="width: 500px;"/>
</p>
<p style="float: right;">
  <img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/automl_use_case_2.png" style="width: 500px;"/>
</p>
<br style="clear: both;"/>

AutoML trong DataBricks cung cấp các tính năng như:
- Tự động hoá quá trình chuẩn bị dữ liệu
- Tự động hoá feature engineering
- Tự động hoá quá trình huấn luyện và chọn mô hình
- Tự động hoá việc tinh chỉnh tham số mô hình
- Khai phá các tài sản AI với Notebook
- Triển khai mô hình

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/automl_project_map.png" style="width: 1200px;"/>

## 3. Model Serving trong DataBricks

Các thách thức của Model Serving
- Cơ sở hạ tầng Machine Learning: Hệ thống ML thời gian thực yêu cầu cơ sở hạ tầng phục vụ nhanh và có thể mở rộng, tốn kém để xây dựng và duy trì.
- Triển khai các mô hình thời gian thực cần các công cụ khác nhau: Nhiều công cụ khác nhau trong quá trình data, training và serving gây ra sự phức tạp và chi phí cao.
- Vận hành ML đòi hỏi các nguồn lực chuyên gia: Việc triển khai mô hình bị tắc nghẽn do các nguồn lực kỹ thuật hạn chế, hạn chế khả năng mở rộng

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/mlflow_model_serving.png" style="width: 600px;"/>

Model Serving cung cấp:
- Kết nối với MLflow Model Registry
- REST Endpoint cho phép tích hợp liền mạch với bảng điều khiển và các ứng dụng bên ngoài
- Độ trễ cực thấp để thực hiện dự đoán theo thời gian thực

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/model_serving_types.png" style="width: 600px;"/>
