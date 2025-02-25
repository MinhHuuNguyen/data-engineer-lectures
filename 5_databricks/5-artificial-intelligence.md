---
time: 11/01/2025
title: Trí tuệ nhân tạo trên DataBricks
description: DataBricks cung cấp các dịch vụ như MLFlow, AutoML và Model Serving để hỗ trợ việc triển khai các mô hình trí tuệ nhân tạo trở nên đơn giản hơn.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/1-introduction/intro.png
tags: []
is_highlight: false
is_published: true
---

## 1. MLFlow trong DataBricks

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/mlflow.png" style="width: 1200px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/mlflow.png" style="width: 1200px;"/>

## 2. AutoML trong DataBricks

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/automl_use_case_1.png" style="width: 400px;"/>

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/5_databricks/images/5-artificial-intelligence/automl_use_case_2.png" style="width: 400px;"/>

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
