with Fail_ranked as
(select fail_date, 
365 + datediff(fail_date, '2019-01-01') - row_number() over (order by fail_date) as ranked
from Failed
where fail_date between '2019-01-01' and '2019-12-31'),
Success_ranked as
(select success_date, 
365 + datediff(success_date, '2019-01-01') - row_number() over (order by success_date) as ranked
from Succeeded
where success_date between '2019-01-01' and '2019-12-31') 

select *
from
(select 'failed' as period_state, 
min(fail_date) as start_date, 
max(fail_date) as end_date
from Fail_ranked
group by ranked
union 
select 'succeeded' as period_state, 
min(success_date) as start_date, 
max(success_date) as end_date
from Success_ranked
group by ranked) temp
order by start_date
