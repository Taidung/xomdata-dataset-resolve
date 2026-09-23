-- Q15: Sản phẩm hay mua cùng nhau
with order_products as (
	select distinct 
		order_number,
		product_key
	from retails.sales
),

order_count as (
	select
		count(distinct order_number) as total_orders
	from retails.sales
),

pairs as (
	select 
		a.product_key as product_a_key,
		b.product_key as product_b_key,
		count(*) as times_together
	from order_products a
	inner join order_products b
		on a.order_number = b.order_number and a.product_key < b.product_key
	group by a.product_key, b.product_key
)

select top(20)
	pa.product_name as product_a,
	pb.product_name as product_b,
	pr.times_together,
	round(100.0 * pr.times_together/ c.total_orders, 4) as pct
from pairs as pr 
inner join retails.products pa on pr.product_a_key = pa.product_key 
inner join retails.products pb on pr.product_b_key = pb.product_key
cross join order_count as c
order by pr.times_together desc, product_a, product_b