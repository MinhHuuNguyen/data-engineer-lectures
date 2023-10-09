---
layout: "post"
title:  "Data scraping"
author: "Nguyễn Hữu Minh"
permalink: "/data-lake-data-warehouse/data-scraping"
parent: "Data lake data warehouse"
nav_order: 1
---

# Data scraping

## 1. Data scraping là gì?

Data scraping (còn được gọi là web scraping) là quá trình tự động hoá việc trích xuất thông tin từ các trang web và chuyển đổi nó thành dữ liệu có thể sử dụng trong các ứng dụng khác nhau.
Đây là một phần quan trọng trong quá trình thu thập dữ liệu từ internet để phân tích, nghiên cứu.

## 2. Các công cụ để thực hiện data scraping

Data scraping thường được thực hiện bằng cách sử dụng các kỹ thuật lập trình để tự động truy cập và trích xuất dữ liệu từ trang web.
- Các ngôn ngữ lập trình phổ biến cho việc này bao gồm Python, JavaScript và Ruby.
- Các thư viện và công cụ như BeautifulSoup, Scrapy, Puppeteer và Selenium thường được sử dụng để giúp trích xuất dữ liệu.

## 3. Ứng dụng của data scraping

- Thu thập thông tin sản phẩm và giá cả từ các trang web thương mại điện tử để phân tích thị trường.
- Lấy thông tin về khách hàng và phản hồi từ các trang web xã hội để nghiên cứu thị trường và phân tích tình hình khách hàng.
- Trích xuất dữ liệu từ trang web tin tức để tự động cập nhật các bản tin hoặc dữ liệu liên quan.
- Thu thập dữ liệu từ trang web về điểm số thể thao để cập nhật thông tin thời gian thực về trận đấu và tỷ lệ cược.

Tuy nhiên, cần lưu ý rằng việc data scraping có thể liên quan đến các vấn đề về bản quyền và luật pháp tùy theo trường hợp cụ thể.
Điều này nên được thực hiện theo quy định của pháp luật và tuân thủ quy tắc etic của mạng để đảm bảo tính hợp pháp và đạo đức trong việc sử dụng dữ liệu từ internet.

## 4. So sánh data scraping và data crawling

Data scraping và data crawling là hai khái niệm thường được nhắc đến trong lĩnh vực thu thập dữ liệu từ internet, nhưng chúng có mục tiêu và phương pháp thực hiện khác nhau.

### 4.1. Data scraping

Data scraping là quá trình trích xuất thông tin cụ thể từ các trang web đã được thu thập bởi web crawling hoặc trực tiếp từ trang web nguồn.

Mục tiêu chính của web scraping là lấy dữ liệu cụ thể từ trang web và chuyển nó thành dạng có thể sử dụng (ví dụ: dữ liệu trong tệp CSV hoặc cơ sở dữ liệu).

### 4.2. Data crawling

Data crawling là quá trình tự động duyệt qua các trang web trên internet để thu thập thông tin và tạo ra một danh sách các URL hoặc trang web liên quan đến một chủ đề cụ thể.

Mục tiêu chính của web crawling là xây dựng một cơ sở dữ liệu (còn gọi là index) để tạo điều kiện cho việc tìm kiếm và truy xuất thông tin dễ dàng hơn.


### 4.3. Ví dụ so sánh

Giả sử bạn làm việc cho một công ty tìm kiếm và phân tích thị trường, và công việc của bạn là xây dựng một cơ sở dữ liệu về các sản phẩm điện tử trên internet. Trong trường hợp này:
- Data crawling:
    - Là quá trình tự động duyệt qua hàng nghìn trang web thương mại điện tử, chẳng hạn như Amazon, eBay, và Best Buy, để thu thập danh sách các sản phẩm điện tử và URL của chúng.
    - Mục tiêu chính là xây dựng một danh sách các URL và thông tin cơ bản để tạo điều kiện cho việc tìm kiếm và truy xuất thông tin chi tiết sau này.
- Data scraping:
    - Là quá trình trích xuất thông tin cụ thể từ các trang sản phẩm cụ thể, chẳng hạn như thông tin về giá cả, đánh giá của người dùng, và mô tả sản phẩm.
    - Mục tiêu chính là lấy dữ liệu cụ thể từ các trang web đã được thu thập để sử dụng cho mục đích phân tích thị trường hoặc hiển thị thông tin chi tiết cho người dùng.

