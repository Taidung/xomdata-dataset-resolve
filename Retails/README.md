# Retail SQL Analytics Project

## Q1: Tổng số đơn hàng năm 2020

- Vì một đơn hàng có nhiều dòng nên dùng distinct để lấy số lượng đơn hàng duy nhất.

```sql
COUNT(DISTINCT order_number)
```

### Demo kết quả

| total_orders |
|--------------|
| 4,635        |

## Q2: Liệt kê category sản phẩm

- Ở trong bảng products sẽ chỉ có 1 dòng mô tả cho mỗi sản phẩm gắn theo category.
- Dùng count(*) để đếm số lượng sản phẩm trong mỗi category.

### Demo kết quả

| category                        | sku |
|----------------------------------|-----|
| Audio                             | 115 |
| Cameras and camcorders            | 372 |
| Cell phones                       | 285 |
| Computers                         | 606 |
| Games and Toys                    | 166 |
| Home Appliances                   | 661 |
| Music, Movies and Audio Books     | 90  |
| TV and Video                      | 222 |

## Q3: Top 10 thành phố có nhiều khách nhất

- Dùng count(*) để đếm số khách hàng nhóm theo từng thành phố, bang, quốc gia và được sắp xếp giảm dần.
- Dùng top(10) để lấy 10 dòng đầu tiên.

### Demo kết quả

| city         | state              | country        | total_customers |
|--------------|--------------------|-----------------|-----------------:|
| Toronto      | Ontario            | Canada          | 203 |
| New York     | New York           | United States   | 130 |
| Los Angeles  | California         | United States   | 119 |
| Montreal     | Quebec             | Canada          | 97  |
| Chicago      | Illinois           | United States   | 90  |
| Houston      | Texas              | United States   | 84  |
| Calgary      | Alberta            | Canada          | 70  |
| Dallas       | Texas              | United States   | 67  |
| Vancouver    | British Columbia   | Canada          | 59  |
| Philadelphia | Pennsylvania       | United States   | 53  |

## Q4: Doanh thu tháng 12/2020

- Sử dụng inner join để lấy thông tin của các product có xuất hiện trong bảng sales.

### Demo kết quả

| revenue     |
|-------------|
| 651,526.44  |

## Q5: Số lượng store theo quốc gia

### Demo kết quả

| country         | total_stores |
|------------------|-------------:|
| United States    | 24 |
| Germany          | 9  |
| France           | 7  |
| United Kingdom   | 7  |
| Australia        | 6  |
| Canada           | 5  |
| Netherlands      | 5  |
| Italy            | 3  |
| Online           | 1  |

## Q6: Top 5 sản phẩm bán chạy nhất mỗi category

- CTE product_count để đếm số lượng bán được với mỗi sản phẩm + inner join bảng product lấy thông tin sản phẩm.
- CTE rank_product để sắp xếp thứ hạng sản phẩm theo mỗi category.
- row_number: trả về các xếp hạng riêng biệt, không bỏ thứ tự nào.
- partition by category: chia theo category.
- order by total_quantity desc: sắp xếp giảm dần số lượng.
- Không dùng luôn cùng where vì where sẽ chạy trước window function.

### Demo kết quả

| category                | product_name                                 | total_quantity | rank_in_category |
|--------------------------|-----------------------------------------------|----------------:|------------------:|
| Audio                     | WWI 1GB Digital Voice Recorder Pen E10         | 431 | 1 |
| Audio                     | WWI 1GB Digital Voice Recorder Pen E10         | 388 | 2 |
| Audio                     | WWI 4GB Video Recording Pen X200 Yellow…       | 370 | 3 |
| Audio                     | WWI 4GB Video Recording Pen X200 Black…        | 366 | 4 |
| Audio                     | WWI Wireless Bluetooth Stereo Headphone…       | 359 | 5 |
| Cameras and camcorders    | Contoso Cyber Shot Digital Cameras Ad…         | 101 | 1 |
| Cameras and camcorders    | Contoso Digital Camera/Camcorder USB…          | 97  | 2 |
| Cameras and camcorders    | Contoso Carrying Case E312 Pink                | 95  | 3 |
| Cameras and camcorders    | Contoso Macro Zoom Lens X300 Black             | 95  | 4 |
| Cameras and camcorders    | Contoso Digital Camera/Camcorder USB…          | 93  | 5 |
| Cell phones               | The Phone Company Touch Screen Phone…          | 256 | 1 |
| Cell phones               | Headphone Adapter for Contoso Phone            | 229 | 2 |
| Cell phones               | The Phone Company Touch Screen Phone…          | 224 | 3 |
| Cell phones               | Contoso Finger Touch Screen Phones M…          | 223 | 4 |
| Cell phones               | The Phone Company Touch Screen Phone…          | 217 | 5 |
| Computers                 | WWI Desktop PC2.33 X2330 Black                 | 550 | 1 |
| Computers                 | WWI Desktop PC1.80 E1800 White                 | 538 | 2 |
| Computers                 | Adventure Works Desktop PC1.60 ED160…          | 521 | 3 |
| Computers                 | Adventure Works Desktop PC2.30 MD230…          | 521 | 4 |
| Computers                 | Adventure Works Desktop PC1.80 ED180…          | 520 | 5 |
| Games and Toys            | MGS Hand Games men M300 Red                    | 376 | 1 |
| Games and Toys            | MGS Hand Games women M400 Silver               | 297 | 2 |
| Games and Toys            | MGS Hand Games for Office worker L29…          | 280 | 3 |
| Games and Toys            | SV Hand Games men M30 Silver                   | 274 | 4 |

> Ghi chú: một số tên sản phẩm bị cắt bởi độ rộng cột trong ảnh gốc (đánh dấu bằng `…`). Bảng cũng chỉ hiển thị đến rank 4 của "Games and Toys" và chưa có 3 category còn lại (Home Appliances, Music/Movies/Audio Books, TV and Video) vì phần đó nằm ngoài khung ảnh bạn gửi — gửi thêm ảnh nếu cần bổ sung đầy đủ.

## Q7: Margin gross theo subcategory

- Dùng round(): làm tròn lấy 2 số phía sau dấu phẩy.
- nullif(): trả về null nếu giá trị price = 0 => tránh việc chia cho 0.

### Demo kết quả

| subcategory              | total_products | avg_margin |
|----------------------------|----------------:|------------:|
| Digital SLR Cameras          | 100 | 60.44 |
| Digital Cameras              | 100 | 57.39 |
| Projectors & Screens         | 103 | 57.33 |
| Movie DVD                    | 90  | 57.24 |
| Monitors                     | 78  | 56.71 |
| Printers, Scanners & Fax     | 101 | 56.38 |
| Camcorders                   | 103 | 56.26 |
| Smart phones & PDAs          | 101 | 55.93 |
| Bluetooth Headphones         | 50  | 55.69 |
| Touch Screen Phones          | 62  | 55.26 |
| Televisions                  | 50  | 55.2  |
| MP4&MP3                      | 45  | 55.03 |
| Home & Office Phones         | 92  | 54.91 |
| Recording Pen                | 20  | 54.84 |
| Washers & Dryers             | 70  | 54.59 |
| Water Heaters                | 31  | 54.57 |
| VCD & DVD                    | 26  | 54.45 |
| Laptops                      | 78  | 54.07 |
| Air Conditioners             | 62  | 53.78 |
| Refrigerators                | 86  | 53.67 |
| Microwaves                   | 102 | 53.66 |
| Coffee Machines               | 74  | 53.6  |
| Desktops                      | 45  | 53.52 |
| Boxed Games                   | 46  | 53.5  |

## Q8: Thời gian giao hàng trung bình theo quốc gia

- Sử dụng distinct vì một đơn hàng có nhiều dòng.
- delivery_date is not null: lọc ra những đơn hàng mua trực tiếp tránh avg() gây sai lệch dữ liệu.
- datediff(): trả về khoảng cách giữa 2 ngày.
- cast(): chuyển về decimal vì datediff trả về số nguyên gây mất dữ liệu.

### Demo kết quả

| country         | delivered_orders | avg_delivery_days |
|------------------|-------------------:|--------------------:|
| Italy            | 211   | 4.68 |
| Canada           | 512   | 4.67 |
| United Kingdom   | 637   | 4.64 |
| France           | 133   | 4.53 |
| United States    | 3,068 | 4.52 |
| Australia        | 281   | 4.44 |
| Netherlands      | 200   | 4.35 |
| Germany          | 538   | 4.35 |

## Q9: Khách VIP mỗi quốc gia

- Group by theo customer_key tránh khách hàng cùng tên.
- partition by country: chia theo country.

### Demo kết quả

| country         | name               | total_amount |
|------------------|--------------------|---------------:|
| United States    | Mie Huus            | 33,275.47 |
| Canada           | Zane Belgrave       | 20,644.89 |
| United Kingdom   | Dominic Banks       | 19,371.06 |
| France           | Alice Lafond        | 18,659.88 |
| Germany          | Daniel Kaestner     | 17,931.00 |
| Australia        | Makayla Hassall     | 16,778.46 |
| Italy            | Gaspare Trevisan    | 13,831.89 |
| Netherlands      | Polat Klarenbeek    | 13,369.52 |

## Q10: Sản phẩm zombie (chưa từng bán)

- Dùng left join nối product với bảng sales.
- Những product_key chưa xuất hiện trong sales sẽ trả về null.
- Có thể dùng exist.
- Không dùng not in vì với product_key bị null sẽ không so sánh được.

### Demo kết quả

| product_key | product_name                             | brand               | category         |
|-------------:|---------------------------------------------|----------------------|-------------------|
| 2,193 | Adventure Works Chandelier M6150 Black   | Adventure Works       | Home Appliances |
| 2,229 | Adventure Works Desk Lamp E1200 Blue     | Adventure Works       | Home Appliances |
| 2,220 | Adventure Works Desk Lamp E1300 Grey     | Adventure Works       | Home Appliances |
| 2,212 | Adventure Works Desk Lamp E1300 Silver   | Adventure Works       | Home Appliances |
| 2,191 | Adventure Works Floor Lamp M2150 Black   | Adventure Works       | Home Appliances |
| 2,190 | Adventure Works Floor Lamp X1150 Black   | Adventure Works       | Home Appliances |
| 2,214 | Adventure Works Floor Lamp X1150 Grey    | Adventure Works       | Home Appliances |
| 2,219 | Adventure Works Wall Lamp E3150 Grey     | Adventure Works       | Home Appliances |
| 2,211 | Adventure Works Wall Lamp E3150 Silver   | Adventure Works       | Home Appliances |
| 1,885 | Contoso Washer & Dryer 21in E210 Green   | Contoso                | Home Appliances |
| 2,328 | Litware Chandelier M8015 Silver          | Litware                | Home Appliances |
| 2,320 | Litware Chandelier M8015 White           | Litware                | Home Appliances |
| 2,333 | Litware Desk Lamp E1020 Silver           | Litware                | Home Appliances |
| 2,332 | Litware Desk Lamp E1030 Silver           | Litware                | Home Appliances |
| 2,343 | Litware Floor Lamp M2015 Blue            | Litware                | Home Appliances |
| 2,330 | Litware Wall Lamp E2015 Silver           | Litware                | Home Appliances |
| 2,280 | Proseware Chandelier M0815 White         | Proseware               | Home Appliances |
| 2,277 | Proseware Desk Lamp E0120 Black          | Proseware               | Home Appliances |
| 2,295 | Proseware Floor Lamp M0215 Grey          | Proseware               | Home Appliances |
| 2,274 | Proseware Wall Lamp E0215 Black          | Proseware               | Home Appliances |
| 2,282 | Proseware Wall Lamp E0215 White          | Proseware               | Home Appliances |
| 2,230 | WWI Floor Lamp X115 Black                | Wide World Impor…       | Home Appliances |
| 2,234 | WWI Wall Lamp E215 Black                 | Wide World Impor…       | Home Appliances |
| 2,251 | WWI Wall Lamp E315 Silver                | Wide World Impor…       | Home Appliances |

> Ghi chú: cột "brand" của các dòng WWI bị cắt trong ảnh gốc ("Wide World Impor…"), khả năng cao đầy đủ là "Wide World Importers".

## Q11: Doanh thu tháng + doanh thu tích luỹ 24 tháng

- Dùng datefromparts() để trả về ngày đầu tiên của mỗi tháng.
- year() và month() để lấy năm và tháng của order_date.
- rows unbounded preceding: cộng dồn giá trị của các dòng phía trước.

### Demo kết quả

| year_month | revenue       | cumulative_revenue |
|-------------|---------------:|---------------------:|
| 2019-03     | 845,925.09     | 845,925.09     |
| 2019-04     | 149,892.71     | 995,817.80     |
| 2019-05     | 1,594,446.47   | 2,590,264.27   |
| 2019-06     | 1,404,861.40   | 3,995,125.67   |
| 2019-07     | 1,408,714.62   | 5,403,840.29   |
| 2019-08     | 1,500,784.77   | 6,904,625.06   |
| 2019-09     | 1,547,870.73   | 8,452,495.79   |
| 2019-10     | 1,575,168.82   | 10,027,664.61  |
| 2019-11     | 1,715,659.88   | 11,743,324.49  |
| 2019-12     | 2,477,295.85   | 14,220,620.34  |
| 2020-01     | 2,068,951.12   | 16,289,571.46  |
| 2020-02     | 2,227,379.57   | 18,516,951.03  |
| 2020-03     | 674,990.66     | 19,191,941.69  |
| 2020-04     | 217,642.10     | 19,409,583.79  |
| 2020-05     | 878,026.63     | 20,287,610.42  |
| 2020-06     | 763,883.23     | 21,051,493.65  |
| 2020-07     | 512,805.18     | 21,564,298.83  |
| 2020-08     | 416,647.08     | 21,980,945.91  |
| 2020-09     | 380,431.52     | 22,361,377.43  |
| 2020-10     | 245,647.59     | 22,607,025.02  |
| 2020-11     | 256,701.02     | 22,863,726.04  |
| 2020-12     | 651,526.44     | 23,515,252.48  |
| 2021-01     | 513,021.58     | 24,028,274.06  |
| 2021-02     | 526,266.90     | 24,554,540.96  |

## Q12: Cohort retention theo năm mua đầu tiên

- CTE cohort: lấy năm đầu tiên mua hàng của khách hàng.
- CTE cohort_size: đếm số lượng customer trong mỗi năm.
- CTE activity: để xem khách nào còn hoạt động.

### Demo kết quả

| cohort_year | cohort_customers | year_offset | active_customers | retention_pct |
|-------------:|-------------------:|-------------:|-------------------:|-----------------:|
| 2016 | 2,561 | 0 | 2,561 | 100    |
| 2016 | 2,561 | 1 | 531   | 20.73  |
| 2016 | 2,561 | 2 | 839   | 32.76  |
| 2016 | 2,561 | 3 | 1,169 | 45.65  |
| 2017 | 2,376 | 0 | 2,376 | 100    |
| 2017 | 2,376 | 1 | 822   | 34.6   |
| 2017 | 2,376 | 2 | 1,105 | 46.51  |
| 2017 | 2,376 | 3 | 643   | 27.06  |
| 2018 | 3,104 | 0 | 3,104 | 100    |
| 2018 | 3,104 | 1 | 1,391 | 44.81  |
| 2018 | 3,104 | 2 | 847   | 27.29  |
| 2018 | 3,104 | 3 | 113   | 3.64   |
| 2019 | 2,832 | 0 | 2,832 | 100    |
| 2019 | 2,832 | 1 | 720   | 25.42  |
| 2019 | 2,832 | 2 | 81    | 2.86   |
| 2020 | 947   | 0 | 947   | 100    |
| 2020 | 947   | 1 | 34    | 3.59   |
| 2021 | 67    | 0 | 67    | 100    |

## Q13: Doanh thu/m² store, xếp hạng trong nước

- square_meters > 0 để lọc kênh bán online.
- Sử dụng ntile(4) để chia mỗi cụm thành 4 phần theo số lượng cửa hàng (tứ phân vị).

### Demo kết quả

| store_key | country    | revenue_per_sqm | quartile |
|-----------:|-------------|------------------:|-----------:|
| 1  | Australia | 100.08 | 1 |
| 5  | Australia | 57.77  | 2 |
| 6  | Australia | 55.57  | 3 |
| 4  | Australia | 17.47  | 4 |
| 10 | Canada    | 162.17 | 1 |
| 9  | Canada    | 129.76 | 2 |
| 8  | Canada    | 76.38  | 3 |
| 13 | France    | 155.06 | 1 |
| 12 | France    | 154.65 | 1 |
| 16 | France    | 141.82 | 2 |
| 15 | France    | 104.93 | 2 |
| 17 | France    | 97.83  | 3 |
| 18 | France    | 69.92  | 3 |
| 14 | France    | 56.44  | 4 |

## Q14: Store cannibalization

- Dùng self join bảng store để lấy được cặp cửa hàng theo quốc gia và open_date.
- sum(case when) để tính tổng revenue theo từng trường hợp 6 tháng trước và 6 tháng sau.
- isnull biến những trường hợp null thành 0 => cửa hàng không có doanh thu trong 6 tháng sau.

### Demo kết quả

| old_store | new_store | country        | open_date  | revenue_before | revenue_after | change_pct |
|-----------:|-----------:|-----------------|-------------|-----------------:|-----------------:|-------------:|
| 20 | 26 | Germany       | 2019-03-05 | 119,660.25 | 40,570.15  | -66.10 |
| 19 | 26 | Germany       | 2019-03-05 | 96,124.35  | 33,267.46  | -65.39 |
| 21 | 26 | Germany       | 2019-03-05 | 139,314.75 | 70,006.10  | -49.75 |
| 56 | 49 | United States | 2018-06-03 | 186,585.24 | 125,598.06 | -32.69 |
| 56 | 62 | United States | 2018-06-03 | 186,585.24 | 125,598.06 | -32.69 |
| 20 | 21 | Germany       | 2018-06-03 | 81,828.18  | 55,456.81  | -32.23 |
| 23 | 26 | Germany       | 2019-03-05 | 132,438.08 | 89,891.15  | -32.13 |
| 27 | 26 | Germany       | 2019-03-05 | 132,722.79 | 96,420.01  | -27.35 |
| 64 | 49 | United States | 2018-06-03 | 98,977.13  | 72,904.04  | -26.34 |
| 64 | 62 | United States | 2018-06-03 | 145,073.34 | 120,544.77 | -16.91 |
| 24 | 26 | Germany       | 2019-03-05 | 91,735.60  | 77,840.73  | -15.15 |

## Q15: Sản phẩm hay mua cùng nhau

- CTE order_products dùng distinct vì một product_key có thể xuất hiện nhiều lần trong một đơn hàng.
- a.product_key < b.product_key:
  - tránh ghép 2 product_key giống nhau.
  - tránh ghép một cặp 2 lần.
  - tránh những đơn nhỏ hơn 2 sản phẩm.

### Demo kết quả

| product_a                                       | product_b                                        | times_together | pct    |
|---------------------------------------------------|----------------------------------------------------|-----------------:|--------:|
| Contoso DVD 7-Inch Player Portable E200 Black       | SV Hand Games men M30 Red                            | 5 | 0.019  |
| Adventure Works Desktop PC1.60 ED160 Brown          | Adventure Works Desktop PC1.60 ED160 White           | 4 | 0.0152 |
| Adventure Works Desktop PC1.60 ED160 Silver         | Contoso DVD Recorder L240 Gold                       | 4 | 0.0152 |
| Adventure Works Desktop PC1.80 ED180 White          | Contoso Water Heater 4.3GPM M1250 Blue               | 4 | 0.0152 |
| Adventure Works Desktop PC1.60 ED182 Brown          | WWI Desktop PC1.60 E1600 Silver                      | 4 | 0.0152 |
| Adventure Works Desktop PC2.30 MD230 Silver         | Adventure Works Desktop PC1.60 ED160 Black           | 4 | 0.0152 |
| Adventure Works Desktop PC2.30 MD230 White          | SV DVD Recorder L240 Gold                            | 4 | 0.0152 |
| Adventure Works Desktop PC3.0 MS300 Silver          | Adventure Works Desktop PC2.30 MD230 Silver          | 4 | 0.0152 |
| Adventure Works Desktop PC3.0 MS300 White           | SV DVD External DVD Burner M200 Black                | 4 | 0.0152 |
| Contoso DVD 55DVD Storage Binder M56 Silver         | SV Hand Games for students E40 Black                 | 4 | 0.0152 |
| Contoso DVD 60 DVD Storage Binder L20 Black         | Contoso Touch Stylus Pen E150 Silver                 | 4 | 0.0152 |
| Contoso DVD Player M110 Silver                      | Contoso DVD 12-Inch Player Portable M400 Silver      | 4 | 0.0152 |
| Contoso DVD Recorder L230 Grey                      | SV DVD 58 DVD Storage Binder M55 Black               | 4 | 0.0152 |
| MGS Hand Games for 12-16 boys E600 Yellow           | SV Hand Games for kids E30 Red                       | 4 | 0.0152 |
| NT Bluetooth Active Headphones E202 White           | WWI Desktop PC1.80 E1801 Black                       | 4 | 0.0152 |
| NT Wireless Transmitter and Bluetooth Headphone…    | WWI Desktop PC1.80 E1801 White                       | 4 | 0.0152 |
| NT Wireless Transmitter and Bluetooth Headphone…    | Headphone Adapter for Contoso Phone E130 Black       | 4 | 0.0152 |
| SV DVD 38 DVD Storage Binder E25 Silver             | Contoso DVD 55DVD Storage Binder M56 Black           | 4 | 0.0152 |
| SV DVD 58 DVD Storage Binder M55 Black              | SV DVD 14-Inch Player Portable L100 White            | 4 | 0.0152 |
