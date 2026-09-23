-- Q3: Top 10 thành phố có nhiều khách nhất
select top(10)
	city,
	state,
	country,
	count(*) as total_customers
from retails.customers
group by city, state, country  
order by total_customers desc, city
