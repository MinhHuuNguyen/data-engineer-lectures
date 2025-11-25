---
time: 10/08/2022
title: Giao diện lập trình ứng dụng
description: Giao diện lập trình ứng dụng giúp các chương trình giao tiếp với nhau một cách hiệu quả và chuẩn hoá. Từ đó, ta có thể xây dựng các hệ thống phân tán, microservices, và tích hợp các dịch vụ khác nhau. Giao diện lập trình ứng dụng phổ biến nhất hiện nay là RESTful API, được xây dựng từ các khái niệm như API, HTTP, URI, và REST.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/banner.jpeg
tags: [big-data, tools]
is_highlight: false
is_published: true
---

## 1. API là gì?

API (Application Programming Interface) là “giao diện lập trình ứng dụng” – một cách để các chương trình máy tính giao tiếp với nhau.
Thay vì một ứng dụng phải hiểu nội bộ của ứng dụng khác, nó chỉ cần gọi các hàm / endpoint mà ứng dụng kia cung cấp.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/api_menu.jpeg" style="width: 400px;"/>

Ví dụ: Ứng dụng thời tiết trên điện thoại gọi API của server để lấy dữ liệu nhiệt độ, độ ẩm, dự báo.

Ta có thể xem như API là “Menu” của một nhà hàng: bạn chỉ cần gọi món theo menu, không cần biết bếp hoạt động thế nào.

#### Vậy API khác gì so với việc đóng gói logic thành một thư viện (library)?

- Thư viện (library) là mã nguồn được đóng gói để tái sử dụng trong cùng một ứng dụng hoặc hệ thống.
- API là giao diện để các ứng dụng khác nhau (có thể chạy trên máy khác, nền tảng khác) giao tiếp với nhau qua mạng.

API giúp độc lập hoá các ứng dụng với nhau, trong khi thư viện là tái sử dụng mã nguồn trong cùng một ứng dụng.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/api_vs_library.jpeg" style="width: 400px;"/>

### Phân nhóm các loại API

#### Theo cách triển khai và giao thức

- **RESTful API:** dựa trên HTTP, tuân theo nguyên tắc REST
- **SOAP API (Simple Object Access Protocol):** dựa trên XML, chuẩn formal hơn
- **GraphQL API:** 1 endpoint, client tự chọn dữ liệu cần
- **gRPC:** dựa trên HTTP/2, dùng protobuf để serialize dữ liệu

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/api_type_1.jpeg" style="width: 600px;"/>

Ví dụ về SOAP API lấy dữ liệu thời tiết

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:weat="http://example.com/weather">
   <soapenv:Header/>
   <soapenv:Body>
      <weat:GetWeather>
         <weat:City>Hanoi</weat:City>
      </weat:GetWeather>
   </soapenv:Body>
</soapenv:Envelope>
```

trong đó:
- `soapenv:Envelope`: là phần bao bọc toàn bộ thông điệp SOAP.
    - `xmlns:soapenv=`: khai báo namespace cho SOAP envelope.
    - `xmlns:weat=`: khai báo namespace cho dịch vụ thời tiết.
- `soapenv:Header`: là phần chứa metadata (bảo mật, transaction…). Có thể rỗng.
- `soapenv:Body`: là phần chứa nội dung chính của yêu cầu hoặc phản hồi.
    - `weat:GetWeather`: là hành động yêu cầu lấy dữ liệu thời tiết.
        - `weat:City`: tham số truyền vào, ở đây là tên thành phố "Hanoi".

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:weat="http://example.com/weather">
   <soapenv:Header/>
   <soapenv:Body>
      <weat:GetWeatherResponse>
         <weat:Temperature>30</weat:Temperature>
         <weat:Humidity>70</weat:Humidity>
         <weat:Forecast>
            <weat:Day>Monday</weat:Day>
            <weat:Condition>Sunny</weat:Condition>
         </weat:Forecast>
      </weat:GetWeatherResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

Ví dụ về GraphQL API lấy dữ liệu thời tiết

```graphql
query {
  weather(city: "Hanoi") {
    temperature
    humidity
    forecast {
      day
      condition
    }
  }
}
```

trong đó:
- `query`: từ khoá để bắt đầu một truy vấn GraphQL.
- `weather(city: "Hanoi")`: gọi hàm `weather` với tham số `city` là "Hanoi".
- `{ temperature humidity forecast { day condition } }`: định nghĩa các trường dữ liệu cần lấy:
    - `temperature`: nhiệt độ hiện tại.
    - `humidity`: độ ẩm hiện tại.
    - `forecast`: dự báo thời tiết, bao gồm các trường con:
        - `day`: ngày trong tuần.
        - `condition`: điều kiện thời tiết (nắng, mưa, v.v.).

```graphql
{
  "data": {
    "weather": {
      "temperature": 30,
      "humidity": 70,
      "forecast": [
        { "day": "Monday", "condition": "Sunny" },
        { "day": "Tuesday", "condition": "Cloudy" }
      ]
    }
  }
}
```

Ví dụ về gRPC API lấy dữ liệu thời tiết

```protobuf
syntax = "proto3";
package weather;
service WeatherService {
  rpc GetWeather (WeatherRequest) returns (WeatherResponse);
}
message WeatherRequest {
  string city = 1;
}
message WeatherResponse {
  int32 temperature = 1;
  int32 humidity = 2;
  repeated Forecast forecast = 3;
}
message Forecast {
  string day = 1;
  string condition = 2;
}
```
trong đó:
- `syntax = "proto3";`: chỉ định phiên bản của ngôn ngữ protobuf.
- `package weather;`: định nghĩa package để tổ chức các message và service.
- `service WeatherService`: định nghĩa một dịch vụ gRPC tên là `WeatherService`.
    - `rpc GetWeather (WeatherRequest) returns (WeatherResponse);`: định nghĩa một phương thức RPC tên là `GetWeather`, nhận vào một `WeatherRequest` và trả về một `WeatherResponse`.
- `message WeatherRequest`: định nghĩa cấu trúc dữ liệu cho yêu cầu thời tiết.
    - `string city = 1;`: trường `city` kiểu chuỗi, đánh số 1.
- `message WeatherResponse`: định nghĩa cấu trúc dữ liệu cho phản hồi thời tiết.
    - `int32 temperature = 1;`: trường `temperature` kiểu số nguyên 32-bit, đánh số 1.
    - `int32 humidity = 2;`: trường `humidity` kiểu số nguyên 32-bit, đánh số 2.
    - `repeated Forecast forecast = 3;`: trường `forecast` là một danh sách các đối tượng `Forecast`, đánh số 3.
- `message Forecast`: định nghĩa cấu trúc dữ liệu cho dự báo thời tiết.
    - `string day = 1;`: trường `day` kiểu chuỗi, đánh số 1.
    - `string condition = 2;`: trường `condition` kiểu chuỗi, đánh số 2.

#### Theo chức năng

- **Data API:** Dùng để truy xuất hoặc thao tác dữ liệu. Ví dụ: API lấy dữ liệu thời tiết, API cơ sở dữ liệu.
- **Service API:** Cung cấp các chức năng hoặc dịch vụ cụ thể. Ví dụ: thanh toán trực tuyến (PayPal API), dịch vụ gửi email (SendGrid API).
- **Hardware API:** Tương tác với phần cứng hoặc thiết bị. Ví dụ: API camera, API cảm biến IoT.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/api_type_2.jpeg" style="width: 400px;"/>

#### Theo phạm vi sử dụng

- **Open/Public API:** mở cho tất cả các developer bên ngoài sử dụng (ví dụ: API của Twitter, Google Maps).
- **Internal/Private API:** chỉ sử dụng trong nội bộ công ty hoặc tổ chức. Giúp các module hoặc microservice trong cùng hệ thống giao tiếp với nhau.
- **Partner API:** chia sẻ với các đối tác hoặc tổ chức được cấp quyền. Thường có cơ chế authentication và giới hạn truy cập.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/api_type_3.jpeg" style="width: 600px;"/>

## 2. URI, URL và URN là gì?

Trong các hệ thống phân tán và ứng dụng web, việc định danh và truy cập tài nguyên là yêu cầu nền tảng.
URI (Uniform Resource Identifier), URL (Uniform Resource Locator), và URN (Uniform Resource Name) là các khái niệm quan trọng giúp định danh và truy cập tài nguyên trên mạng.
Mặc dù chúng liên quan mật thiết, mỗi khái niệm có phạm vi và vai trò riêng trong kiến trúc web hiện đại.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/uri_url_urn.jpeg" style="width: 500px;"/>

### 2.1. Uniform Resource Identifier (URI)

URI là một chuỗi ký tự được chuẩn hóa nhằm định danh duy nhất một tài nguyên.
Tài nguyên có thể là bất kỳ thực thể nào: trang web, hình ảnh, tài liệu, API, hoặc một đối tượng trừu tượng trong hệ thống.

URI gồm hai nhóm chính:
- **URL (Uniform Resource Locator):** cung cấp cách truy cập tài nguyên.
- **URN (Uniform Resource Name):** cung cấp tên định danh nhưng không mô tả cách truy cập.

### 2.2. Uniform Resource Locator (URL)

URL (Uniform Resource Locator) là một loại URI có nhiệm vụ chỉ ra vị trí và cách truy cập tài nguyên, bao gồm:
- **Scheme (giao thức):** http, https, ftp, mailto…
- **Host:** tên miền hoặc địa chỉ IP.
- **Path:** vị trí tài nguyên trên máy chủ.
- **Query parameters và Fragment** (nếu có)

Ví dụ: URL của một hình ảnh trên trang báo `vnexpress.net`
```
https://vnexpress.net/images/logo.png
```
trong đó:
- `https`: giao thức bảo mật HTTP.
- `vnexpress.net`: tên miền của trang web.
- `/images/logo.png`: đường dẫn đến hình ảnh logo trên máy chủ.

### 2.3. Uniform Resource Name (URN)

URN (Uniform Resource Name) là một dạng URI dùng để định danh tài nguyên bằng tên, nhưng không cung cấp thông tin về vị trí hay cách truy cập tài nguyên.
Mục tiêu chính của URN là đảm bảo một định danh ổn định, lâu dài và không phụ thuộc vào vị trí lưu trữ.

Ví dụ: URN cho một cuốn sách theo chuẩn ISBN
```urn:isbn:978-3-16-148410-0
```
trong đó:
- `urn`: chỉ định đây là một URN.
- `isbn`: namespace cho định danh sách theo chuẩn ISBN.
- `978-3-16-148410-0`: mã số ISBN duy nhất của cuốn sách.

Một số namespace URN phổ biến
- **isbn**: sách theo mã ISBN
- **issn**: ấn phẩm định kỳ
- **uuid**: định danh duy nhất toàn cầu
- **ietf**: tài liệu tiêu chuẩn của Internet Engineering Task Force
- **oid**: Object Identifier trong LDAP hoặc hệ thống tiêu chuẩn hóa

## 3. HTTP và HTTPS là gì?

### 3.1. Hypertext transfer protocol (HTTP)

HTTP (HyperText Transfer Protocol) là giao thức truyền tải dữ liệu nền tảng của World Wide Web.
HTTP định nghĩa cách thức client (thường là trình duyệt) và server trao đổi thông tin.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/request_response.jpeg" style="width: 500px;"/>

Đặc điểm chính:
- Mô hình request–response: Client gửi yêu cầu (request), server phản hồi (response).
- Stateless: Mỗi request là độc lập; server không tự nhớ trạng thái các request trước đó.
- Dữ liệu truyền dưới dạng plain text: Nội dung có thể bị chặn, đọc hoặc chỉnh sửa nếu không có biện pháp bảo vệ bổ sung.

### 3.2. Hypertext transfer protocol secure (HTTPS)

HTTPS (HyperText Transfer Protocol Secure) là phiên bản bảo mật của HTTP, hoạt động thông qua cơ chế mã hoá bổ sung.
Chữ S trong HTTPS là là "Secure".

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/https.jpeg" style="width: 300px;"/>

Đặc điểm chính:
- Xác thực danh tính máy chủ qua chứng chỉ số (SSL/TLS certificate): Đảm bảo người dùng đang kết nối đúng server.
- Mã hóa dữ liệu trong quá trình truyền: Ngăn chặn nghe lén hoặc đọc trộm.
- Toàn vẹn dữ liệu: Dữ liệu không bị thay đổi trong quá trình truyền.

Cơ chế hoạt động tóm tắt
- Khi client kết nối qua HTTPS, hai bên thực hiện TLS handshake để:
    - Thống nhất thuật toán mã hóa.
    - Kiểm tra chứng chỉ (certificate) của server.
    - Sinh khóa phiên để mã hóa dữ liệu.
- Sau handshake, mọi dữ liệu đều được mã hóa trước khi truyền đi.
    - HTTPS sử dụng TLS hoặc SSL để mã hoá request và response của HTTP.
    - Cơ chế mã hoá ở đây là Mã khoá công khai (gồm cặp public key và private key).

Ví dụ về việc chuyển đổi một request và response HTTP thành dạng đã được mã hoá

- Request HTTP:
```
GET /api/data HTTP/1.1
Host: example.com
```

thành

```
\x16\x03\x01\x00\xdc\x01\x00\x00\xd8\x03\x03... (dữ liệu đã mã hoá)
```

- Response HTTP:
```
HTTP/1.1 200 OK
Content-Type: application/json
{ "data": "value" }
```

thành

```
\x17\x03\x03\x00\x8c\x02\x00\x00\x88\x03... (dữ liệu đã mã hoá)
```

HTTPs đã trở thành tiêu chuẩn mặc định cho mọi website và được trình duyệt đánh giá độ tin cậy; các site HTTP thường bị cảnh báo “Not secure”.
HTTPs bảo vệ người dùng trước các tấn công phổ biến như Man-in-the-Middle.

### 3.3. Phương thức trong HTTP/HTTPS

Các phương thức HTTP xác định hành động mà client muốn thực hiện trên tài nguyên của server.
Các phương thức phổ biến bao gồm:
- **GET:** Lấy dữ liệu từ server. Không làm thay đổi trạng thái tài nguyên.
- **POST:** Gửi dữ liệu đến server để tạo mới tài nguyên hoặc thực hiện hành động.
- **PUT:** Cập nhật toàn bộ tài nguyên trên server với dữ liệu mới.
- **PATCH:** Cập nhật một phần tài nguyên trên server.
- **DELETE:** Xóa tài nguyên trên server.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/http_methods.jpeg" style="width: 500px;"/>

Đối chiếu với CRUD (Create, Read, Update, Delete) mà ta thường sử dụng trong quản lý dữ liệu:
- `Create` → `POST /resources`: Tạo mới tài nguyên.
- `Read (list)` → `GET /resources`: Lấy danh sách tài nguyên.
- `Read (one)` → `GET /resources/{id}`: Lấy chi tiết một tài nguyên.
- `Update` → `PUT/PATCH /resources/{id}`: Cập nhật tài nguyên.
- `Delete` → `DELETE /resources/{id}`: Xóa tài nguyên.

### 3.4. Status code trong HTTP/HTTPS

Khi client gửi request đến server, server sẽ phản hồi lại với một mã trạng thái (status code) để cho biết kết quả của yêu cầu.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/http_status_code.jpeg" style="width: 500px;"/>

Các mã trạng thái phổ biến được chia thành các nhóm chính:
- **1xx (Informational):** Thông tin
    - 100 Continue: Yêu cầu đã được nhận, client có thể tiếp tục gửi phần còn lại của request.
    - 101 Switching Protocols: Server đồng ý chuyển đổi giao thức theo yêu cầu của client.
- **2xx (Successful):** Thành công
    - 200 OK: Yêu cầu đã thành công và server trả về dữ liệu.
    - 201 Created: Tài nguyên mới đã được tạo thành công.
    - 204 No Content: Yêu cầu đã thành công nhưng không có nội dung để trả về.
- **3xx (Redirection):** Chuyển hướng
    - 301 Moved Permanently: Tài nguyên đã được chuyển đến URL mới vĩnh viễn.
    - 302 Found: Tài nguyên tạm thời được chuyển đến URL khác.
    - 304 Not Modified: Tài nguyên không bị thay đổi, client có thể sử dụng bản cache.
- **4xx (Client Error):** Lỗi phía client
    - 400 Bad Request: Yêu cầu không hợp lệ hoặc sai cú pháp.
    - 401 Unauthorized: Yêu cầu xác thực.
    - 403 Forbidden: Client không có quyền truy cập tài nguyên.
    - 404 Not Found: Tài nguyên không tồn tại.
- **5xx (Server Error):** Lỗi phía server
    - 500 Internal Server Error: Lỗi chung của server.
    - 502 Bad Gateway: Server nhận được phản hồi không hợp lệ từ server khác.
    - 503 Service Unavailable: Server tạm thời không thể xử lý yêu cầu (quá tải hoặc bảo trì).

## 4. REST và RESTful API là gì?

### 4.1. Representational State Transfer (REST)

REST (Representational State Transfer) là một phong cách kiến trúc (architectural style) để thiết kế dịch vụ web.
REST không phải là một protocol hay framework, mà là tập hợp nguyên tắc, ràng buộc (constraints).

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/rest_requirements.jpeg" style="width: 500px;"/>

Các ràng buộc chính của REST bao gồm:
- **Client – Server:**
    - **Nguyên tắc:** Tách biệt các thành phần của ứng dụng thành client và server.
    Trong đó, thành phần đóng vai trò là client sẽ gửi yêu cầu (request) đến server để lấy hoặc thao tác với tài nguyên (resource), thành phần đóng vai trò là server sẽ xử lý các yêu cầu này và trả về phản hồi (response) tương ứng.
    - **Ý nghĩa:** Client chỉ biết cách tương tác với tài nguyên, server xử lý logic và dữ liệu.
    - **Lợi ích:** Giảm phụ thuộc giữa client và server, từ đó, dễ nâng cấp độc lập. Tăng tính mở rộng (scalability).
- **Stateless:**
    - **Nguyên tắc:** Mỗi request từ client đến server phải chứa tất cả thông tin cần thiết để server hiểu và xử lý.
    - **Ý nghĩa:** Server không lưu trữ bất kỳ thông tin trạng thái nào về client giữa các request.
    - **Lợi ích:** Tăng tính mở rộng (scalability) và đơn giản hoá server.
- **Cacheable:**
    - **Nguyên tắc:** Các response (phản hồi từ server) có thể được đánh dấu là có thể lưu trữ (cacheable) hoặc không.
    - **Ý nghĩa:** Client có thể lưu trữ các phản hồi để tái sử dụng trong các request sau, giảm tải cho server.
    - **Lợi ích:** Cải thiện hiệu suất và giảm độ trễ.
- **Uniform Interface:**
    - **Nguyên tắc:** Giao diện giữa client và server phải đồng nhất và nhất quán.
    - **Ý nghĩa:** Giao diện phải tuân theo các quy tắc chung như sử dụng URI để định danh tài nguyên, sử dụng các phương thức HTTP đúng cách (GET, POST, PUT, DELETE), và sử dụng định dạng dữ liệu thống nhất (thường là JSON hoặc XML).
    - **Lợi ích:** Giảm sự phức tạp và tăng tính tương tác giữa các hệ thống khác nhau.
- **Layered System:**
    - **Nguyên tắc:** Hệ thống có thể được cấu trúc thành các lớp (layers) khác nhau như proxy, load balancer, gateway.
    - **Ý nghĩa:** Client không cần biết về cấu trúc bên trong của hệ thống.
    - **Lợi ích:** Tăng tính bảo mật, mở rộng và quản lý hệ thống.
- **Code on Demand (tùy chọn):**
    - **Nguyên tắc:** Server có thể gửi mã (code) cho client để thực thi trên client.
    - **Ý nghĩa:** Giúp mở rộng chức năng của client mà không cần cập nhật ứng dụng.
    - **Lợi ích:** Tăng tính linh hoạt và khả năng mở rộng của ứng dụng.

### 4.2. REpresentational State Transfer Application Programming Interface (REST API / RESTful API)

RESTful API là API tuân theo các nguyên tắc REST, trong đó:
- Sử dụng HTTP làm giao thức truyền thông.
- Resource được biểu diễn qua URI.
- Sử dụng HTTP methods (GET, POST, PUT, DELETE, …) đúng ý nghĩa.
- Stateless (không lưu trạng thái session trên server).
- Hỗ trợ cache, phân lớp…

Nói cách khác ngắn gọn hơn, **RESTful API = Web API được thiết kế “đúng chuẩn REST”**.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/2_tools/images/1-restful-api/rest_api.jpeg" style="width: 500px;"/>

#### Một số quy tắc cơ bản trong thiết kế RESTful API

- Quy tắc đặt URI:
    - Dùng danh từ (nouns) để đại diện resource.
    - Không dùng động từ: `/getUsers`, `/createUser`.
    - Dùng danh từ số nhiều: `/users`, `/products`.
    - Dùng dấu gạch ngang - nếu cần: `/user-profiles`.
    - Dùng path để thể hiện quan hệ: `/users/1/orders`.
- Sử dụng query parameters: Dùng query params cho lọc, sắp xếp, phân trang, ví dụ: `/users?role=admin`, `/products?category=phone&sort=price_desc&page=2&limit=20`
- Versioning API:
    - Để tránh “vỡ” client khi thay đổi API, ta version hóa: `/api/v1/users`, `/api/v2/users`
    - Khi thay đổi lớn, tạo version mới, version cũ vẫn sống song song một thời gian.
- Định dạng dữ liệu: phổ biến nhất hiện nay là JSON
- Xử lý lỗi: Trả về mã trạng thái HTTP phù hợp (4xx, 5xx) và thông tin lỗi chi tiết trong body.
