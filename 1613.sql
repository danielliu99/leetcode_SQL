with recursive t as
(select 1 as num
union all 
select num+1 
from t
where num+1 <= (select max(customer_id) from Customers))

select t.num as ids
from t
left join Customers c
on t.num = c.customer_id
where c.customer_id is null
