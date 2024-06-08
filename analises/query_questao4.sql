-- Query que retorna a quantidade de ordens canceladas e a quantidade de drivers

select 
    b.status,
    count(distinct(o.Order_ID)) as count_order,
    count(distinct(d.Driver_ID)) as count_drivers,
    1.0* count(distinct(o.Order_ID)) / count(distinct(d.Driver_ID)) as pedidos_cancelados_por_driver

from 
    orders as o
left join 
    drivers as d on o.Driver_ID = d.Driver_ID
left join 
    biometry as b on d.Driver_ID = b.Driver_ID

where 
    o.Order_Status = 'CANCELLED'
group by 
    b.status
order by 
    1.0* count(distinct(o.Order_ID)) / count(distinct(d.Driver_ID)) desc