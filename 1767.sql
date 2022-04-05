with recursive Sequence as
(select 1 as n
union 
select n+1 as n
from Sequence
where n < (select max(subtasks_count) from Tasks))

select task_id, subtask_id
from 
(select t.task_id, subtask_id, subtasks_count
from Tasks t 
join Executed e 
on t.task_id = e.task_id
union all
select task_id, n as subtask_id, subtasks_count
from Sequence s 
left join Tasks t
on s.n <= t.subtasks_count) temp
group by task_id, subtask_id
having count(*) < 2
