-- Q7: Margin gross theo subcategory
select 
	subcategory,
	count(*) as total_products,
	round(avg((unit_price_usd - unit_cost_usd) / nullif(unit_price_usd, 0)) * 100, 2) as avg_margin
from retails.products
group by subcategory 
having count(*) >= 10
order by avg_margin desc