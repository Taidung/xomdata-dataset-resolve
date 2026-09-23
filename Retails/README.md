# Retail SQL Analytics Project

## Q1: Tổng số đơn hàng năm 2020

-   Vì một đơn hàng có nhiều dòng nên dùng distinct để lấy số lượng đơn
    hàng duy nhất.

``` sql
COUNT(DISTINCT order_number)
```

### Demo kết quả

    total_orders
  --------------
            4635

------------------------------------------------------------------------

## Q2: Liệt kê category sản phẩm

-   Ở trong bảng products sẽ chỉ có 1 dòng mô tả cho mỗi sản phẩm gắn
    theo category.
-   Dùng count(\*) để đếm số lượng sản phẩm trong mỗi category.

### Demo kết quả

  category                          sku
  ------------------------------- -----
  Audio                             115
  Cameras and camcorders            372
  Cell phones                       285
  Computers                         606
  Games and Toys                    166
  Home Appliances                   661
  Music, Movies and Audio Books      90
  TV and Video                      222

------------------------------------------------------------------------

## Q3: Top 10 thành phố có nhiều khách nhất

-   Dùng count(\*) để đếm số khách hàng nhóm theo từng thành phố, bang,
    quốc gia và được sắp xếp giảm dần.
-   Dùng top(10) để lấy 10 dòng đầu tiên.

### Demo kết quả

  city           state              country           total_customers
  -------------- ------------------ --------------- -----------------
  Toronto        Ontario            Canada                        203
  New York       New York           United States                 130
  Los Angeles    California         United States                 119
  Montreal       Quebec             Canada                         97
  Chicago        Illinois           United States                  90
  Houston        Texas              United States                  84
  Calgary        Alberta            Canada                         70
  Dallas         Texas              United States                  67
  Vancouver      British Columbia   Canada                         59
  Philadelphia   Pennsylvania       United States                  53

------------------------------------------------------------------------

## Q4: Doanh thu tháng 12/2020

-   Sử dụng inner join để lấy thông tin của các product có xuất hiện
    trong bảng sales.

### Demo kết quả

       revenue
  ------------
    651,526.44

------------------------------------------------------------------------

## Q5: Số lượng store theo quốc gia

### Demo kết quả

  country            total_stores
  ---------------- --------------
  United States                24
  Germany                       9
  France                        7
  United Kingdom                7
  Australia                     6
  Canada                        5
  Netherlands                   5
  Italy                         3
  Online                        1

------------------------------------------------------------------------

## Q6: Top 5 sản phẩm bán chạy nhất mỗi category

-   CTE product_count để đếm số lượng bán được với mỗi sản phẩm + inner
    join bảng product lấy thông tin sản phẩm.
-   CTE rank_product để sắp xếp thứ hạng sản phẩm theo mỗi category.
-   row_number: trả về các xếp hạng riêng biệt, không bỏ thứ tự nào.
-   partition by category: chia theo category.
-   order by total_quantity desc: sắp xếp giảm dần số lượng.
-   Không dùng luôn cùng where vì where sẽ chạy trước window function.

### Demo kết quả (một phần)

  -------------------------------------------------------------------------
  category        product_name          total_quantity     rank_in_category
  --------------- --------------- -------------------- --------------------
  Audio           WWI 1GB Digital                  431                    1
                  Voice Recorder                       
                  Pen E10                              

  Audio           WWI 1GB Digital                  388                    2
                  Voice Recorder                       
                  Pen E10                              

  Cameras and     Contoso Cyber                    101                    1
  camcorders      Shot Digital                         
                  Cameras                              

  Cell phones     The Phone                        256                    1
                  Company Touch                        
                  Screen Phone                         

  Computers       WWI Desktop                      550                    1
                  PC2.33 X2330                         
                  Black                                
  -------------------------------------------------------------------------

------------------------------------------------------------------------

## Q7: Margin gross theo subcategory

-   Dùng round(): làm tròn lấy 2 số phía sau dấu phẩy.
-   nullif(): trả về null nếu giá trị price = 0 =\> tránh việc chia cho
    0.

### Demo kết quả

  subcategory              total_products   avg_margin
  ---------------------- ---------------- ------------
  Digital SLR Cameras                 100        60.44
  Digital Cameras                     100        57.39
  Projectors & Screens                103        57.33
  Movie DVD                            90        57.24
  Monitors                             78        56.71

------------------------------------------------------------------------

## Q8: Thời gian giao hàng trung bình theo quốc gia

-   Sử dụng distinct vì một đơn hàng có nhiều dòng.
-   delivery_date is not null: lọc ra những đơn hàng mua trực tiếp tránh
    avg() gây sai lệch dữ liệu.
-   datediff(): trả về khoảng cách giữa 2 ngày.
-   cast(): chuyển về decimal vì datediff trả về số nguyên gây mất dữ
    liệu.

### Demo kết quả

  country            delivered_orders   avg_delivery_days
  ---------------- ------------------ -------------------
  Italy                           211                4.68
  Canada                          512                4.67
  United Kingdom                  637                4.64
  France                          133                4.53
  United States                  3068                4.52

------------------------------------------------------------------------

## Q9: Khách VIP mỗi quốc gia

-   Group by theo customer_key tránh khách hàng cùng tên.
-   partition by country: chia theo country.

### Demo kết quả

  country          name                total_amount
  ---------------- ----------------- --------------
  United States    Mie Huus               33,275.47
  Canada           Tienge Belgrave        20,644.89
  United Kingdom   Dominic Banks          19,371.06
  France           Alice Lafond           18,659.88
  Germany          Daniel Kaestner           17,931

------------------------------------------------------------------------

## Q10: Sản phẩm zombie (chưa từng bán)

-   Dùng left join nối product với bảng sales.
-   Những product_key chưa xuất hiện trong sales sẽ trả về null.
-   Có thể dùng exist.
-   Không dùng not in vì với product_key bị null sẽ không so sánh được.

### Demo kết quả

  ------------------------------------------------------------------------
            product_key product_name     brand            category
  --------------------- ---------------- ---------------- ----------------
                   2193 Adventure Works  Adventure Works  Home Appliances
                        Chandelier M6150                  
                        Black                             

                   2229 Adventure Works  Adventure Works  Home Appliances
                        Desk Lamp E1200                   
                        Blue                              

                   2220 Adventure Works  Adventure Works  Home Appliances
                        Desk Lamp E1300                   
                        Grey                              
  ------------------------------------------------------------------------

------------------------------------------------------------------------

## Q11: Doanh thu tháng + doanh thu tích luỹ 24 tháng

-   Dùng datefromparts() để trả về ngày đầu tiên của mỗi tháng.
-   year() và month() để lấy năm và tháng của order_date.
-   rows unbounded preceding: cộng dồn giá trị của các dòng phía trước.

### Demo kết quả

  year_month          revenue   cumulative_revenue
  ------------ -------------- --------------------
  2019-03          845,925.09           845,925.09
  2019-04          149,892.71           995,817.80
  2019-05        1,594,446.47         2,590,264.27
  2020-12          651,526.44        23,515,252.48

------------------------------------------------------------------------

## Q12: Cohort retention theo năm mua đầu tiên

-   CTE cohort: lấy năm đầu tiên mua hàng của khách hàng.
-   CTE cohort_size: đếm số lượng customer trong mỗi năm.
-   CTE activity: để xem khách nào còn hoạt động.

### Demo kết quả

  -----------------------------------------------------------------------------------
     cohort_year   cohort_customers    year_offset   active_customers   retention_pct
  -------------- ------------------ -------------- ------------------ ---------------
            2016               2561              0               2561             100

            2016               2561              1                531           20.73

            2017               2376              1                822            34.6

            2018               3104              1               1391           44.81
  -----------------------------------------------------------------------------------

------------------------------------------------------------------------

## Q13: Doanh thu/m² store, xếp hạng trong nước

-   square_meters \> 0 để lọc kênh bán online.
-   Sử dụng ntile(4) để chia mỗi cụm thành 4 phần theo số lượng cửa hàng
    (tứ phân vị).

### Demo kết quả

    store_key country       revenue_per_sqm   quartile
  ----------- ----------- ----------------- ----------
            1 Australia              100.08          1
            5 Australia               57.77          2
            6 Australia               55.57          3
           10 Canada                 162.17          1
            9 Canada                 129.76          2

------------------------------------------------------------------------

## Q14: Store cannibalization

-   Dùng self join bảng store để lấy được cặp cửa hàng theo quốc gia và
    open_date.
-   sum(case when) để tính tổng revenue theo từng trường hợp 6 tháng
    trước và 6 tháng sau.
-   isnull biến những trường hợp null thành 0 =\> cửa hàng không có
    doanh thu trong 6 tháng sau.

### Demo kết quả

  --------------------------------------------------------------------------------------------
    old_store   new_store country   open_date      revenue_before   revenue_after   change_pct
  ----------- ----------- --------- ------------ ---------------- --------------- ------------
           20          26 Germany   2019-03-05         119,660.25       40,570.15       -66.10

           19          26 Germany   2019-03-05          96,124.35       33,267.46       -65.39

           21          26 Germany   2019-03-05         139,314.75       70,006.10       -49.75
  --------------------------------------------------------------------------------------------

------------------------------------------------------------------------

## Q15: Sản phẩm hay mua cùng nhau

-   CTE order_products dùng distinct vì một product_key có thể xuất hiện
    nhiều lần trong một đơn hàng.
-   a.product_key \< b.product_key:
    -   tránh ghép 2 product_key giống nhau.
    -   tránh ghép một cặp 2 lần.
    -   tránh những đơn nhỏ hơn 2 sản phẩm.

### Demo kết quả

  -------------------------------------------------------------------------
  product_a       product_b             times_together                  pct
  --------------- --------------- -------------------- --------------------
  Contoso DVD     SV Hand Games                      5                0.019
  7-Inch Player   men M30 Red                          
  Portable E200                                        
  Black                                                

  Adventure Works Adventure Works                    4               0.0152
  Desktop PC1.60  Desktop PC1.60                       
  ED160 Black     ED160 White                          

  Contoso DVD     Adventure Works                    4               0.0152
  Recorder L240   Desktop PC1.60                       
  Gold            ED160 Silver                         
  -------------------------------------------------------------------------
