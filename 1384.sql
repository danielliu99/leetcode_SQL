select temp.product_id, product_name, report_year, sum(total_amount) as total_amount
from
(select product_id, '2020' as report_year, 
(datediff(
if(datediff('2021-01-01', period_end) > 0, period_end, '2020-12-31'), 
if(datediff('2020-01-01', period_start) < 0, period_start, '2020-01-01')
) + 1) * average_daily_sales as total_amount
from Sales 
having total_amount >= 0
union all
select product_id, '2019' as report_year, 
(datediff(
if(datediff('2020-01-01', period_end) > 0, period_end, '2019-12-31'), 
if(datediff('2019-01-01', period_start) < 0, period_start, '2019-01-01')
) + 1) * average_daily_sales as total_amount
from Sales
having total_amount >= 0
union all
select product_id, '2018' as report_year,
(datediff(
if(datediff('2019-01-01', period_end) > 0, period_end, '2018-12-31'), 
if(datediff('2018-01-01', period_start) < 0, period_start, '2018-01-01')
) + 1) * average_daily_sales as total_amount
from Sales
having total_amount >= 0) temp
join Product p
on temp.product_id = p.product_id
group by 1, 3
order by product_id, report_year
