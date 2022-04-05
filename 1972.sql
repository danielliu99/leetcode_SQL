with Ranked as 
(select caller_id, recipient_id, date_format(call_time, '%Y-%m-%d') as call_time, 
dense_rank() over (partition by caller_id, date_format(call_time, '%Y-%m-%d') order by call_time) as ranked_first, 
dense_rank() over (partition by caller_id, date_format(call_time, '%Y-%m-%d') order by call_time desc) as ranked_last
from
(select caller_id, recipient_id, call_time
from Calls 
union
select recipient_id as caller_id, caller_id as recipient_id, call_time
from Calls) temp) 

select distinct r1.caller_id as user_id
from Ranked r1 
join Ranked r2
on r1.caller_id = r2.caller_id and r1.ranked_first = 1 
    and r2.ranked_last = 1
where r1.recipient_id = r2.recipient_id 
