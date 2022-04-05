select group_id, player_id
from
(select group_id, 
p.player_id, 
rank() over (partition by group_id order by ifnull(sum(score), 0) desc, player_id) as ranked
from
(select match_id, first_player as player_id, first_score as score
from Matches
union all 
select match_id, second_player as player_id, second_score as score
from Matches) temp 
right join Players p
on temp.player_id = p.player_id
group by player_id) Ranked
where ranked = 1
