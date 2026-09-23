-- Q6: Top 5 sản phẩm bán chạy nhất mỗi category
with product_count as (
	select
		p.category,
		p.product_name,
		SUM(s.quantity) as total_quantity
	from retails.sales s 
	inner join retails.products p on s.product_key = p.product_key
	group by p.category, p.product_name 
),

rank_product as (
	select
		category,
		product_name,
		total_quantity,
		row_number() over(
			partition by category order by total_quantity DESC, product_name
		) as rank_in_category
	from product_count
)

select
	category,
	product_name,
	total_quantity,
	rank_in_category
from rank_product
where rank_in_category <= 5
order by category, rank_in_category