select distinct round(sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2)), 
                      2) as shortest
from Point2D p1
join Point2D p2
on p1.x != p2.x or p1.y != p2.y
order by 1 
limit 1
