-- Q10: Sản phâm zombie (chưa từng bán)
select
	p.product_key,
	p.product_name,
	p.brand,
	p.category 
from retails.products p 
left join retails.sales s on p.product_key = s.product_key  
where s.product_key is null
order by p.category, p.product_name 