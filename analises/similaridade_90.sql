select 
    select(count(b.status from biometry WHERE
    be.*

from 
    biometry b
left join
    biometry_execution be on b.session_id = be.session_id
group by
    b.status