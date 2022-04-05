select p.spend_date, p.platform, 
ifnull(sum(amount), 0) as total_amount, 
ifnull(count(amount), 0) as total_users
from (
    select distinct spend_date, 'desktop' as platform from Spending union
    select distinct spend_date, 'mobile' as platform from Spending union 
    select distinct spend_date, 'both' as platform from Spending 
) p 
left join
(select spend_date, user_id, sum(amount) as amount,
if(count(*) = 1, platform, 'both') as platform
from Spending
group by spend_date, user_id) t
on (p.spend_date, p.platform) = (t.spend_date, t.platform)
group by p.spend_date, p.platform 
