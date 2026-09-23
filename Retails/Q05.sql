-- Q5: Số lượng store theo quốc gia
select 
	country,
	count(*) as total_stores
from retails.stores
group by country 
order by total_stores DESC, country
