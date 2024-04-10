-- Você diria que há alguma relação entre volume de pedidos cancelados 
-- (status = CANCELLED) de um entregador e o status final do processo
-- de identificação biométrica dele? Justifique sua resposta.


-- entregas canceladas sobre o total de entregas
-- entregas de entregadores not match sobre o total de entregas canceladas

select 
    b.status,
    count(distinct(o.Order_ID)) as count_order,
    count(distinct(d.Driver_ID)) as count_drivers

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
    count(order_id) desc 