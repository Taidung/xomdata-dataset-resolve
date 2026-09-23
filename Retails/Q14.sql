-- Q14: Store cannibalization
with store_pairs as ( 
	select 
		os.store_key as old_store,
		ns.store_key as new_store,
		os.country,
		ns.open_date as ns_open_date
	from retails.stores os
	inner join retails.stores ns 
		on os.country = ns.country and os.open_date < ns.open_date 
),

windowed as ( 
	select 
		sp.old_store,
		sp.new_store,
		sp.country,
		sp.ns_open_date,
		sum(case
			when s.order_date >= dateadd(month, -6, sp.ns_open_date)
			and s.order_date < sp.ns_open_date
			then s.quantity * p.unit_price_usd 
		end) as  revenue_before,
		sum(case
			when s.order_date < dateadd(month, 6, sp.ns_open_date)
			and s.order_date >= sp.ns_open_date
			then s.quantity * p.unit_price_usd 
		end) as revenue_after
	from store_pairs sp  
	inner join retails.sales s on sp.old_store = s.store_key 
	inner join retails.products p on s.product_key = p.product_key 
	group by sp.old_store, sp.new_store, sp.country, sp.ns_open_date
)

select 
	old_store,
	new_store,
	country,
	ns_open_date,
	revenue_before,
	isnull(revenue_after, 0) as revenue_after,
	round(100.0 * (isnull(revenue_after, 0) - revenue_before) / revenue_before, 2) as change_pct
from windowed
where revenue_before > 0
	and isnull(revenue_after, 0) < revenue_before * 0.85
order by change_pct, old_store, new_store;

