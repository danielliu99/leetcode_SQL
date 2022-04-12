select followee as follower, 
count(*) as num
from Follow
where followee in 
(select follower
from Follow 
group by follower)
group by followee 
order by follower
