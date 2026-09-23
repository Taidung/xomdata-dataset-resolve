-- Q12: Cohort retention theo năm mua đầu tiên
with cohort as (
	select 
		customer_key,
		year(min(order_date)) as cohort_year
	from retails.sales
	group by customer_key 
),

cohort_size as (
	select 
		cohort_year,
		count(*) as cohort_customers
	from cohort
	group by cohort_year
),

activity as (
	select 
		c.cohort_year,
		s.customer_key,
		year(s.order_date) - c.cohort_year as year_offset
	from retails.sales s
	inner join cohort as c on s.customer_key = c.customer_key
)

select 
	cs.cohort_year,
	cs.cohort_customers,
	a.year_offset,
	count(distinct a.customer_key) as active_customers,
	round(100.0 * count(distinct a.customer_key) / cs.cohort_customers, 2) as retention_pct
from activity a
inner join cohort_size cs on a.cohort_year = cs.cohort_year
where a.year_offset between 0 and 3
group by cs.cohort_year, cs.cohort_customers, a.year_offset
order by cs.cohort_year, a.year_offset