-- Q13: Doanh thu/m^2 store, xếp hạng trong nước
with store_revenue as ( 
	select 
		st.store_key,
		st.country,
		st.square_meters,
		sum(s.quantity * p.unit_price_usd) as revenue
	from retails.sales s 
	inner join retails.stores st on s.store_key = st.store_key 
	inner join retails.products p on s.product_key = p.product_key 
	where s.order_date between '2020-01-01' and '2020-12-31'
		and st.square_meters > 0
	group by st.store_key, st.country, st.square_meters 
)

select 
	store_key,
	country,
	round(revenue/square_meters, 2) as revenue_per_sqm,
	ntile(4) over(
		partition by country order by revenue/square_meters desc
	) as quartile
from store_revenue
order by country, quartile, revenue_per_sqm DESC
	