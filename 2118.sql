select concat(group_concat(concat(factor, power) order by power_rank desc 
                           separator ''), '=0') as equation
from
(select 
1 as group_id, 
power as power_rank, 
case 
when power = 0 then ''
when power = 1 then 'X'
when power > 1 then concat('X^', power)
end as power, 
if(factor > 0, concat('+', factor), concat(factor, '')) as factor
from Terms) temp 
group by group_id
