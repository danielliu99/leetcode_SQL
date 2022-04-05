with Ranked as
(select employee_id, experience, salary, 
sum(salary) over (partition by experience order by salary) cumsum
from Candidates),
Cum_jun as 
(select *
from Ranked
where experience = 'Senior' and cumsum <= 70000) 

select employee_id
from Ranked 
where experience = 'Junior' and cumsum <= (select 70000 - ifnull(max(cumsum), 0) from Cum_jun)
union
select employee_id 
from Cum_jun
