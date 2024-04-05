-- Você diria que há alguma relação entre volume de pedidos cancelados 
-- (status = CANCELLED) de um entregador e o status final do processo
-- de identificação biométrica dele? Justifique sua resposta.


-- entregas canceladas sobre o total de entregas
-- entregas de entregadores not match sobre o total de entregas canceladas


select
    count(order_id) as pd_canc_drivers_not_mach, 
    (select count(order_id) from orders where order_status = 'CANCELLED') as total_ordens_canceladas,
    count(order_id) * 1.0 /  
    (select count(order_id) from orders where order_status = 'CANCELLED') as indice_cancelados_drivers_not_match
    


from orders AS o
inner join drivers as d on o.Driver_ID = d.Driver_ID  
inner join biometry as b on d.Driver_ID = b.Driver_ID

where
    o.Order_Status = 'CANCELLED'
    
--- VOLTAR AQUI.... AINDA NAO ACABEI
