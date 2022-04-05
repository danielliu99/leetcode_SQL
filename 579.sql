select id, month, cumsum as salary
from
(select id, month, 
sum(salary) over (partition by id order by month range between 2 preceding and current row) as cumsum, 
rank() over (partition by id order by month desc) as ranked
from Employee) temp
where ranked != 1
order by id, month desc
