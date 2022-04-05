select username, activity, startDate, endDate
from
(select username, activity, startDate, endDate, 
row_number() over (partition by username order by startDate desc, endDate desc) as ranked, 
count(*) over (partition by username) as cnt
from UserActivity) temp
where ranked = 2 or cnt = 1
