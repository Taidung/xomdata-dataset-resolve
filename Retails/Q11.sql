-- Q11: Doanh thu tháng + doanh thu tích luỹ 24 tháng
with monthly_revenue as (
	select top(24)
		datefromparts(year(s.order_date), month(s.order_date), 1) as year_month,
		sum(s.quantity * p.unit_price_usd) as revenue
	from retails.sales s 
	inner join retails.products p on s.product_key = p.product_key 
	group by datefromparts(year(s.order_date), month(s.order_date), 1)
	order by datefromparts(year(s.order_date), month(s.order_date), 1) desc
)

select
	format(year_month, 'yyyy-MM') as year_month,
	revenue,
	sum(revenue) over (order by year_month rows unbounded preceding) as cumulative_revenue
from monthly_revenue
order by year_month 
