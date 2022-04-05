with recursive Months as
(select 1 as month
union
select month+1 as month
from months
where month < 12), 

All_driver as
(select distinct month as date1, count(driver_id) over (order by month) as number1
from
(select if(year(join_date) < 2020, 1, month(join_date)) as date1,
driver_id
from Drivers 
where year(join_date) <= 2020
) temp 
right join Months m 
on temp.date1 = m.month 
), 

Active as
(select month(requested_at) as date2, count(distinct driver_id) as number2
from Rides r 
join AcceptedRides a 
on r.ride_id = a.ride_id
where year(requested_at) = 2020
group by 1) 

select m.month, 
if(a.number2 is null, 0, round(a.number2 / d.number1 * 100, 2)) as working_percentage
from Months m 
left join All_driver d 
on m.month = d.date1 
left join Active a 
on m.month = a.date2 
