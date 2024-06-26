-- Query que traz os acessos negados acima da media por categoria de entregador


select 
    b.Session_ID,
    b.Event_Dt,
    count(d.Driver_ID) as count_driver,
    d.register_dt,
    d.Category,
    d.Modal,
    avg(JULIANDAY(Event_Dt) - JULIANDAY(Register_Dt)) as dias_ativos
    

from 
    biometry b
left join 
    drivers d on b.Driver_ID = d.Driver_ID
where 
    1=1
    and Event_Dt in ('2021-08-15', '2021-08-16', '2021-08-17', '2021-08-30')
    and Status = 'NOT_MATCH'
group by 
    d.Category
order by
    count(d.Driver_ID) desc
