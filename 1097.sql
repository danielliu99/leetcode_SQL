with Install as
(select player_id, min(event_date) as install_dt
from Activity
group by player_id)

select install_dt, 
count(distinct i.player_id) as installs, 
round(count(a.event_date) / count(distinct i.player_id), 2) as Day1_retention
from Install i
left join Activity a
on i.player_id = a.player_id and
    datediff(a.event_date, i.install_dt) = 1
group by install_dt
