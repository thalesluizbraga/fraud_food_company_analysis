-- Você diria que há alguma relação entre volume de pedidos cancelados 
-- (status = CANCELLED) de um entregador e o status final do processo
-- de identificação biométrica dele? Justifique sua resposta.


-- entregas canceladas sobre o total de entregas
-- entregas de entregadores not match sobre o total de entregas canceladas

 with drivers_not_match as (
    select
        count(order_id) as ord_canc_drivers_not_match


    from orders AS o
    inner join drivers as d on o.Driver_ID = d.Driver_ID  
    inner join biometry as b on d.Driver_ID = b.Driver_ID

    where
        o.Order_Status = 'CANCELLED'
)

select 
    ord_canc_drivers_not_match,
    (select count(order_id) from orders where order_status = 'CANCELLED') as ordens_canceladas,
    ord_canc_drivers_not_match  * 1.0 /
    (select count(order_id) from orders where order_status = 'CANCELLED') as indice

from drivers_not_match as dnm

