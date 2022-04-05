with recursive Months as
(select 1 as mon 
union 
select mon+1 as mon
from Months
where mon < 12)

select *
from
(select mon as month, 
round(avg(ride_distance) over (order by mon range between current row and 2 following),
      2) as average_ride_distance, 
round(avg(ride_duration) over (order by mon range between current row and 2 following), 
      2) as average_ride_duration
from
(select mon, 
ifnull(sum(ride_distance), 0) as ride_distance, 
ifnull(sum(ride_duration), 0) as ride_duration
from Months m
left join Rides r 
on m.mon = month(r.requested_at) and year(r.requested_at) = 2020
left join AcceptedRides a 
on r.ride_id = a.ride_id
group by 1) temp) t2
where month <= 10
