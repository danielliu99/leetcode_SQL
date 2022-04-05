with Ranked as
(select *, 
id - row_number() over (order by id) as ranked
from Stadium
where people >= 100)

select id, visit_date, people
from Ranked
where ranked in
(select ranked
from Ranked 
group by ranked
having count(*) >= 3) 
order by visit_date
