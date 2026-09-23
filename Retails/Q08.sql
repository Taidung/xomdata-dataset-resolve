-- Q8: thời gian giao hàng trung bình theo quốc gia
with delivered as (
	select distinct
		order_number,
		customer_key,
		order_date,
		delivery_date 
	from retails.sales
	where delivery_date is not null
)

select
	c.country,
	count(*) as delivered_orders,
	round(
		avg(cast(datediff(day, d.order_date, d.delivery_date) as decimal(10, 2)))
		, 2) as avg_delivery_days
from delivered d
inner join retails.customers c on d.customer_key = c.customer_key 
group by c.country 
order by avg_delivery_days desc;