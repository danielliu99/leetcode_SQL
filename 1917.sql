with Reco as
(select distinct user1_id, user2_id
from
(select l1.user_id as user1_id, l1.song_id, l2.user_id as user2_id, l1.day
from Listens l1 
join Listens l2 
on l1.user_id != l2.user_id and l1.song_id = l2.song_id 
    and l1.day = l2.day) temp 
group by user1_id, user2_id, day 
having count(distinct song_id) >= 3), 

Friends as
(select user1_id, user2_id
from Friendship
union 
select user2_id as user1_id, user1_id as user2_id
from Friendship)

select t1.user1_id as user_id, t1.user2_id as recommended_id
from
(select user1_id, user2_id
from Reco
union 
select user2_id as user1_id, user1_id as user2_id
from Reco) t1
left join Friends f 
on t1.user1_id = f.user1_id and t1.user2_id = f.user2_id
where f.user1_id is null
