with recursive Cnt as (
select 0 as n
union
select n+1 
from Cnt
where n < (select count(*)
           from Transactions
          group by user_id, transaction_date
          order by 1 desc limit 1)), 
Trans as
(select v.user_id, visit_date, count(amount) as transactions_count
from Visits v
left join Transactions t
on (v.user_id, visit_date) = (t.user_id, transaction_date)
group by user_id, visit_date)

select Cnt.n as transactions_count, 
ifnull(visits_count, 0) as visits_count
from Cnt
left join
(select transactions_count, count(*) as visits_count
from Trans
group by transactions_count) temp
on Cnt.n = temp.transactions_count
order by 1
