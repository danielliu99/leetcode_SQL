select request_at as Day, 
round(sum(if(status = 'completed', 0, 1)) 
      / count(*), 2) as 'Cancellation Rate'
from Trips t
left join Users c
on t.client_id = c.users_id 
left join Users d
on t.driver_id = d.users_id
where c.banned = 'No' and d.banned = 'No' and 
    t.request_at between "2013-10-01" and "2013-10-03"
group by request_at
