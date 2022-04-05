with Numbers_new as
(select num, frequency, 
sum(frequency) over (order by num) as cumsum, 
(select sum(frequency) from Numbers) as total
from Numbers)

select * from (
select round(
((select min(num)
from Numbers_new
where total % 2 = 0 and cumsum >= total / 2)
+
(select min(num)
from Numbers_new
where total % 2 = 0 and cumsum >= total / 2 +1))
/ 2, 2) as median
union
select min(num) as median
from Numbers_new
where total % 2 != 0 and cumsum >= total div 2 +1
) temp
where median is not null
