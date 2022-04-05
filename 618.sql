with Ranked as
(select name, continent, 
row_number() over (partition by continent order by name) as ranked
from Student)

select America, Asia, Europe
from
(select name as America, ranked
from Ranked 
where continent = 'America') r1
left join (
select name as Asia, ranked
from Ranked 
where continent = 'Asia') r2
on r1.ranked = r2.ranked
left join (
select name as Europe, ranked 
from Ranked
where continent = 'Europe') r3
on r1.ranked = r3.ranked
