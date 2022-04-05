with Cum as
(select *, 
sum(salary) over (partition by experience order by salary, employee_id) as cumsum
from Candidates),
Cum_sen as
(select ifnull(count(*), 0) as cnt_sen, ifnull(max(cumsum), 0) as cum_sen, 'Senior' as experience
from Cum 
where experience = 'Senior' and cumsum <= 70000),
Cum_jun as
(select ifnull(count(*), 0) as cnt_jun, 'Junior' as experience
from Cum 
where experience = 'Junior' and cumsum <= (select 70000 - cum_sen from Cum_sen))

select experience, cnt_sen as accepted_candidates
from Cum_sen
union
select experience, cnt_jun as accepted_candidates
from Cum_jun 
