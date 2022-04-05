select user_id as seller_id, 
if(u.favorite_brand = temp.item_brand, 'yes', 'no') as 2nd_item_fav_brand
from Users u
left join 
(
select seller_id, item_brand, ranked
from
(select seller_id, item_id, 
rank() over (partition by seller_id order by order_date) as ranked
from Orders) Ranked
join Items i 
on Ranked.item_id = i.item_id
where ranked = 2) temp
on u.user_id = temp.seller_id
