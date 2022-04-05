select d.name as Department, 
temp.employee as Employee, 
temp.salary as Salary
from
(select name as employee, salary, departmentId, 
dense_rank() over (partition by departmentId order by salary desc) as ranked
from Employee) temp
join Department d
on temp.departmentId = d.id
where ranked <= 3
