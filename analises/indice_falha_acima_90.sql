-- calcule quanto o índice geral de MATCH seria 
-- (na tabela biometry) se aumentássemos a similaridade mínima
--do MATCH para 0.90. 

with t1 as(
    select 
        b.Session_ID,
        case 
            when be.Similarity >= 0.9 then 'MATCH' 
            when be.status = 'PROVIDER FAILED' then 'PROVIDER FAILED'
            else 'NOT_MATCH' 
            end as updated_status
        
    from biometry as b
    left join biometry_execution as be on b.Session_ID = be.Session_ID
)

select 
    (select count(session_id) from t1 where updated_status = 'NOT_MATCH') * 1.0 /
    count(session_id) as index_session

from t1
