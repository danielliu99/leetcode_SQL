select dept_name, 
    count(student_id) as student_number 
from Department d
left join Student s
on d.dept_id = s.dept_id
group by d.dept_id 
order by student_number desc, dept_name 
