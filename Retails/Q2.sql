-- Q2: Liệt kê category sản phẩm
select 
	category,
	count(*) as sku
from retails.products 
group by category 
order by category 