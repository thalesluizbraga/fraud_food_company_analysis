-- Query traz dados sobre motoristas que tiveram acessos negados nos dias 15, 16, 17 e 30 de agosto



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
    b.Session_ID,
    d.Register_Dt,
    b.Event_Dt,
    d.Category,
    d.Modal
order by 
    avg(JULIANDAY(Event_Dt) - JULIANDAY(Register_Dt)) desc