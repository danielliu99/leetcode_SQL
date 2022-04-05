with Ranked as
(select exam_id, student_id
from
(select exam_id, student_id, score, 
max(score) over (partition by exam_id) as high,
min(score) over (partition by exam_id) as low
from Exam
exam_id) temp
where score = high or score = low)

select t.student_id, student_name
from (select distinct student_id from Exam
     where student_id not in 
      (select distinct student_id from Ranked)) t
join Student s
on t.student_id = s.student_id
