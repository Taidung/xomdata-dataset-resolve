-- Q9: Khách VIP mỗi quốc gia
with customer_spend as (
	select 
		c.country,
		s.customer_key,
		c.name,
		sum(s.quantity * p.unit_price_usd) as total_amount
	from retails.sales s 
	inner join retails.customers c on s.customer_key = c.customer_key 
	inner join retails.products p on s.product_key = p.product_key 
	where s.order_date between '2020-01-01' and '2020-12-31'
	group by c.country, s.customer_key, c.name 
),

rank_customer as (
	select
		country, 
		name,
		total_amount,
		row_number() over (
			partition by country 
			order by total_amount desc, name
		) as customer_rank
	from customer_spend
)

select 
	country,
	name,
	total_amount
from rank_customer
where customer_rank = 1
order by total_amount desc