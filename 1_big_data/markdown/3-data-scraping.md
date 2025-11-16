---
time: 09/09/2021
title: Thu thập dữ liệu từ các website
description: Dữ liệu từ các trang web đóng vai trò quan trọng trong việc phân tích thị trường, nghiên cứu khách hàng và phát triển sản phẩm. Việc thu thập dữ liệu này thường được thực hiện thông qua các kỹ thuật như data scraping và data crawling.
banner_url: https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/1_big_data/images/1-big-data-introduction/banner.jpeg
tags: [big-data]
is_highlight: false
is_published: true
---

## 1. Data scraping và Data crawling là gì?

Data scraping (còn được gọi là web scraping) là kỹ thuật trích xuất thông tin cụ thể từ một trang web đã được truy cập, thường tập trung vào các phần tử dữ liệu có cấu trúc như bảng, văn bản, hoặc thẻ HTML. 

Scraping giúp chuyển dữ liệu từ giao diện web sang dạng có thể phân tích và xử lý.
Đây là một phần quan trọng trong quá trình thu thập dữ liệu từ internet để phân tích, nghiên cứu.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/images/comparison.jpeg" style="width: 1000px;"/>

Data Crawling là quá trình tự động duyệt qua các trang web theo cấu trúc liên kết để thu thập và lưu trữ dữ liệu thô.
Hệ thống crawler hoạt động như một “trình thu thập”, đi theo các đường dẫn URL và quét toàn bộ nội dung cần thiết trên nhiều trang khác nhau.

Crawling đảm nhiệm việc thu thập và khám phá trang, trong khi scraping tập trung vào trích xuất chi tiết dữ liệu từ từng trang thu được.

### Ví dụ so sánh

Giả sử bạn làm việc cho một công ty tìm kiếm và phân tích thị trường, và công việc của bạn là xây dựng một cơ sở dữ liệu về các sản phẩm điện tử trên internet. Trong trường hợp này:
- Data crawling:
    - Là quá trình tự động duyệt qua hàng nghìn trang web thương mại điện tử, chẳng hạn như Amazon, eBay, và Best Buy, để thu thập danh sách các sản phẩm điện tử và URL của chúng.
    - Mục tiêu chính là xây dựng một danh sách các URL và thông tin cơ bản để tạo điều kiện cho việc tìm kiếm và truy xuất thông tin chi tiết sau này.
- Data scraping:
    - Là quá trình trích xuất thông tin cụ thể từ các trang sản phẩm cụ thể, chẳng hạn như thông tin về giá cả, đánh giá của người dùng, và mô tả sản phẩm.
    - Mục tiêu chính là lấy dữ liệu cụ thể từ các trang web đã được thu thập để sử dụng cho mục đích phân tích thị trường hoặc hiển thị thông tin chi tiết cho người dùng.

### Common Crawl

Common Crawl là một tổ chức phi lợi nhuận cung cấp một kho dữ liệu web khổng lồ, được thu thập thông qua việc sử dụng các trình crawler để quét và lưu trữ hàng tỷ trang web từ internet.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/images/common_crawl.jpeg" style="width: 1000px;"/>

Dữ liệu này được cung cấp miễn phí cho cộng đồng nghiên cứu và phát triển, giúp các nhà khoa học dữ liệu, nhà phát triển và các tổ chức khác có thể truy cập và sử dụng để phân tích, nghiên cứu và xây dựng các ứng dụng dựa trên dữ liệu web.

## 2. Các công cụ để thực hiện data scraping và data crawling

Các ngôn ngữ lập trình phổ biến cho data scraping và data crawling bao gồm Python, JavaScript và Ruby.

Data crawling thường được thực hiện bằng cách sử dụng các bot hoặc spider tự động duyệt qua các trang web và thu thập dữ liệu thô.

Một trong số những công nghệ quan trọng để xây dựng các trình crawler là API.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/images/data_scraping.jpeg" style="width: 1000px;"/>

Data scraping thường được thực hiện bằng cách sử dụng các thư viện lập trình để trích xuất ra thông tin có giá trị từ trang web.
Một số công cụ phổ biến bao gồm:
- **Beautiful Soup (Python):** Thư viện mạnh mẽ để phân tích cú pháp HTML và XML, giúp trích xuất dữ liệu từ các trang web một cách dễ dàng.
- **Selenium:** Công cụ tự động hóa trình duyệt web, thường được sử dụng để tương tác với các trang web động và trích xuất dữ liệu từ chúng.
- **Puppeteer (JavaScript):** Thư viện Node.js để điều khiển trình duyệt Chrome hoặc Chromium, hữu ích cho việc scraping các trang web phức tạp.

## 3. Ứng dụng của data scraping và data crawling

- Thu thập thông tin sản phẩm và giá cả từ các trang web thương mại điện tử để phân tích thị trường.
- Lấy thông tin về khách hàng và phản hồi từ các trang web xã hội để nghiên cứu thị trường và phân tích tình hình khách hàng.
- Trích xuất dữ liệu từ trang web tin tức để tự động cập nhật các bản tin hoặc dữ liệu liên quan.
- Thu thập dữ liệu từ trang web về điểm số thể thao để cập nhật thông tin thời gian thực về trận đấu và tỷ lệ cược.

<img src="https://raw.githubusercontent.com/MinhHuuNguyen/data-engineer-lectures/refs/heads/master/images/data_scraping_output.jpeg" style="width: 1000px;"/>

Tuy nhiên, cần lưu ý rằng việc data scraping có thể liên quan đến các vấn đề về bản quyền và luật pháp tùy theo trường hợp cụ thể.

Điều này nên được thực hiện theo quy định của pháp luật và tuân thủ quy tắc etic của mạng để đảm bảo tính hợp pháp và đạo đức trong việc sử dụng dữ liệu từ internet.
