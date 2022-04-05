select item_category as Category, 
sum(if(dayofweek(order_date) = 2, quantity, 0)) as Monday, 
sum(if(dayofweek(order_date) = 3, quantity, 0)) as Tuesday, 
sum(if(dayofweek(order_date) = 4, quantity, 0)) as Wednesday, 
sum(if(dayofweek(order_date) = 5, quantity, 0)) as Thursday, 
sum(if(dayofweek(order_date) = 6, quantity, 0)) as Friday, 
sum(if(dayofweek(order_date) = 7, quantity, 0)) as Saturday, 
sum(if(dayofweek(order_date) = 1, quantity, 0)) as Sunday
from Items i
left join Orders o
on o.item_id = i.item_id
group by item_category
order by 1
