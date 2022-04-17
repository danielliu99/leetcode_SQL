with New_matches as(
select *, 
if(result = 'Win', 1, 0) as win
from Matches) 

select distinct Players.player_id, 
    ifnull(cnt, 0) as longest_streak
from
(select player_id, count(*) as cnt, 
rank() over(partition by player_id order by count(*) desc) as ranks
from
(select *, 
row_number() over(partition by player_id order by match_day) - sum(win) over(partition by player_id order by match_day) as ranks
from New_matches) tmp 
where result = 'Win'
group by player_id, ranks) tmp_2 
right join (select distinct player_id from Matches) Players
on tmp_2.player_id = Players.player_id 
where ranks = 1 or ranks is Null
