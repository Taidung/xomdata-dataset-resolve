-- Q4: Doanh thu tháng 12/2020
select
	sum(s.quantity * p.unit_price_usd) as revenue
from retails.sales s
inner join retails.products p on s.product_key = p.product_key
where s.order_date BETWEEN '2020-12-01' and '2020-12-31'