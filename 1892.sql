with All_friendship as
(select user1_id, user2_id
from Friendship
union
select user2_id, user1_id 
from Friendship)

select user1_id as user_id, page_id, 
count(distinct user_id ) as friends_likes
from
(select user1_id, l1.page_id as page_id, l1.user_id, l2.page_id as self_page 
from All_friendship f
join Likes l1
on f.user2_id = l1.user_id
left join Likes l2
on f.user1_id = l2.user_id and l1.page_id = l2.page_id) temp 
where self_page is null
group by user1_id, page_id 
