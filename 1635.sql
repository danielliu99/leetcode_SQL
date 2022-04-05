with recursive Months as
(select '2020-01-01' as join_date
union
select date_add(join_date, interval 1 month) as join_date
from Months
where month(join_date) < 12), 
Accepted as
(select month(requested_at) as month, 
count(distinct a.ride_id) as accepted_rides
from Rides r
join AcceptedRides a
on r.ride_id = a.ride_id and
    year(requested_at) = 2020
group by month(requested_at))

select temp3.month, active_drivers, 
ifnull(accepted_rides, 0) as accepted_rides
from
(select month(join_date) as month, cnt as active_drivers
from
(select join_date, 
count(driver_id) over (order by date_format(join_date, '%Y-%m')) as cnt
from
(select driver_id, join_date
from Drivers 
union
select null as driver_id, join_date as month
from Months) temp1
 ) temp2
where year(join_date) = 2020
group by month(join_date)) temp3
left join Accepted a
on temp3.month = a.month
