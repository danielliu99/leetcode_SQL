with tiv as
(select tiv_2015
from Insurance
group by tiv_2015
having count(pid) > 1
),
loc as 
(select pid
from Insurance 
group by lat, lon
having count(*) = 1
)

select round(sum(tiv_2016), 2) as tiv_2016
from Insurance i
where tiv_2015 in (select * from tiv) and
    pid in (select * from loc)
