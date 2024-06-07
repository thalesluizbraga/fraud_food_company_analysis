-- query que agrupa por dia a quantidade de sessoes abertaas por driver. Entao, os dias com maior contagem, tiveram mais solicitaçoes abertas pelo mesmo driver

select 
    b.Driver_ID,
    count(b.Driver_ID) as count_driver,
    be.Event_Dt,
    be.Session_ID,
    count(be.Session_ID) as count_session,
    d.Device_ID,
    count(d.driver_id) as count_driver

    
from
    biometry_execution be
left join
    biometry b on be.Session_ID = b.Session_ID
left join 
    drivers d on b.Driver_ID = d.Driver_ID
where 
    be.status = 'NOT_MATCH'
group by 
    be.Event_Dt
order by 
    be.event_dt asc