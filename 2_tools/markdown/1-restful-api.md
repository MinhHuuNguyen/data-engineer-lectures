---
time: 09/09/2021
title: Giao tiếp lập trình ứng dụng RESTful API
description:
banner_url: 
tags: [big-data, tools]
is_highlight: false
is_published: true
---

## 1. Hypertext transfer protocol (HTTP)

HTTP là một giao thức ứng dụng được sử dụng thường xuyên nhất trong bộ các giao thức TCP/IP (gồm một nhóm các giao thức nền tảng cho internet).

HTTP hoạt động dựa trên mô hình Client – Server.

<img src="https://drive.google.com/uc?id=1dgcHW1bViX-yQ0StSV2gf1gy5dOSQwRa" style="width: 1200px;"/>

### Hypertext transfer protocol (HTTPS)

Chữ S trong HTTPS là là "Secure".

HTTPS sử dụng TLS hoặc SSL để mã hoá request và response của HTTP.
Cơ chế mã hoá ở đây là Mã khoá công khai (gồm cặp public key và private key).

<img src="https://www.cloudflare.com/img/learning/security/glossary/what-is-ssl/http-vs-https.svg" style="width: 1200px;"/>

Mã hoá

```
GET /hello.txt HTTP/1.1
User-Agent: curl/7.63.0 libcurl/7.63.0 OpenSSL/1.1.l zlib/1.2.11
Host: www.example.com
Accept-Language: en
```

thành

```
t8Fw6T8UV81pQfyhDkhebbz7+oiwldr1j2gHBB3L3RFTRsQCpaSnSBZ78Vme+DpDVJPvZdZUZHpzbbcqmSW1+3xXGsERHg9YDmpYk0VVDiRvw1H5miNieJeJ/FNUjgH0BmVRWII6+T4MnDwmCMZUI/orxP3HGwYCSIvyzS3MpmmSe4iaWKCOHQ==
```

## 2. Uniform Resource Locator (URL)

URL là một tham chiếu đến tài nguyên web chỉ định vị trí của nó trên một mạng máy tính và cơ chế để truy xuất nó. 

<img src="https://drive.google.com/uc?id=1-PxIc3fXX6QcMxpxJjeRcgDOzBgMg5zy" style="width: 1200px;"/>

## 3. REpresentational State Transfer (REST)

REST một kiểu kiến trúc để viết API sử dụng phương thức HTTP đơn giản để tạo cho giao tiếp giữa các máy.

REST gửi một yêu cầu HTTP như GET, POST, PUT, DELETE cùng với một URL để xử lý dữ liệu.

<img src="https://drive.google.com/uc?id=1kof9GYDUM1iXDB78gGM0UF-Z79d6F2YB" style="width: 1200px;"/>

## 4. Application Programming Interface (API)

API (Application Programming Interface) là một tập các quy tắc và cơ chế mà theo đó, một ứng dụng hay một thành phần sẽ tương tác với một ứng dụng hay thành phần khác.

API có thể trả về dữ liệu mà bạn cần cho ứng dụng của mình ở những kiểu dữ liệu phổ biến như JSON hay XML.

<img src="https://anonyviet.com/wp-content/uploads/2022/06/1_VtzBqZ-yYr_c6DpJsQkiyA.jpg" style="width: 1200px;"/>

## 5. REpresentational State Transfer Application Programming Interface (REST API)

RESTful API là một tiêu chuẩn dùng trong việc thiết kế các API cho các ứng dụng web để quản lý các resource.

RESTful là một trong những kiểu thiết kế API được sử dụng phổ biến ngày nay để cho các ứng dụng khác nhau giao tiếp với nhau.

<img src="https://drive.google.com/uc?id=1mQZSZcWhToT14a7pj2Myj4Y3GK1pUUbY" style="width: 1200px;"/>

### 5.1. Các phương thức trong REST

- GET – Để truy xuất tài nguyên.
- POST – Để tạo một tài nguyên mới.
- PUT – Để chỉnh sửa hoặc cập nhật tài nguyên hiện có.
- DELETE – Để xóa tài nguyên.

### 5.2. Status code

Khi chúng ta request một API nào đó thường thì sẽ có các status code để nhận biết trạng thái của request như sau:
- 200 OK – Trả về thành công cho những phương thức GET, PUT, PATCH hoặc DELETE.
- 201 Created – Trả về khi một Resouce vừa được tạo thành công.
- 204 No Content – Trả về khi Resource xoá thành công.
- 304 Not Modified – Client có thể sử dụng dữ liệu cache.
- 400 Bad Request – Request không hợp lệ
- 401 Unauthorized – Request cần có auth.
- 403 Forbidden – bị từ chối không cho phép.
- 404 Not Found – Không tìm thấy resource từ URI
- 405 Method Not Allowed – Phương thức không cho phép với user hiện tại.
- 410 Gone – Resource không còn tồn tại, Version cũ đã không còn hỗ trợ.
- 415 Unsupported Media Type – Không hỗ trợ kiểu Resource này.
- 422 Unprocessable Entity – Dữ liệu không được xác thực
- 429 Too Many Requests – Request bị từ chối do bị giới hạn
- 500 Internal Server Error – Lỗi phía server
- 503 Service Unavailable – Service không sẵn sàng để xử lý request
