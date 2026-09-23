-- Q1: Tổng số đơn hàng năm 2020 
select 
	count(distinct order_number ) as total_orders
from retails.sales  
where order_date between '2020-01-01' and '2020-12-31'
