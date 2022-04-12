select name
from Candidate c 
where c.id = 
(select candidateId
from Vote
group by candidateId 
order by count(id) desc
limit 1)
