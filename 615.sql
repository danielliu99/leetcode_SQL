with Company as
(select date_format(pay_date, '%Y-%m') as pay_month, 
avg(amount) as avg_cmp
from Salary
group by month(pay_date))

select temp.pay_month, temp.department_id, 
case
when avg_dpt > avg_cmp then 'higher'
when avg_dpt = avg_cmp then 'same'
when avg_dpt < avg_cmp then 'lower'
end as comparison
from
(select department_id, 
date_format(pay_date, '%Y-%m') as pay_month, 
avg(amount) as avg_dpt
from Salary s
join Employee e
on s.employee_id = e.employee_id
group by department_id, month(pay_date)) temp
join Company c
on c.pay_month = temp.pay_month
