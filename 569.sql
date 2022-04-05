with Total as
(select id, e.company, salary,
row_number() over (partition by company order by salary) as ranked,
cnt
from Employee e
join (
select company, count(*) as cnt
from Employee
group by company) temp 
on e.company = temp.company)

select id, company, salary
from Total
where cnt % 2 = 0 and 
    (ranked = (cnt div 2) or ranked = (cnt div 2 + 1))
union 
select id, company, salary
from Total
where cnt % 2 != 0 and ranked = cnt div 2 + 1
