-- Query que retorna a contagem de drivers com status 'not_match' para sessoes, agrupados por categoria

select 
    d.Category,
    count(d.Driver_ID) as count_drivers

from 
    biometry as b
left join 
    drivers as d on b.Driver_ID = d.Driver_ID
where 
    b.status = 'NOT_MATCH'
group by 
    category
order by 
    count(d.Driver_ID) desc
