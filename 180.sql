select distinct num as ConsecutiveNums
from
(select id, num, 
id - row_number() over(partition by num order by id) as diff
from Logs) temp
group by num, diff
having count(*) >= 3
