-- Query que retorna a quantidade de sessoes com status 'provider_failed' agrupadas por provider

with tb_sessoes_providers as (

    select 
        provider,
        count(distinct session_id) as count_sessoes,
        status

    from
        biometry_execution

    group by 
        provider,
        status

),

tb_total_sessoes as (

    select
        provider,
        sum(count_sessoes) as total_sessoes
    from
        tb_sessoes_providers 
    group by
        provider

)

select 
    tp.provider,
    tp.status,
    tp.count_sessoes,
    ts.total_sessoes,
    ((cast(tp.count_sessoes as float)/ ts.total_sessoes) * 100) as perc_providers 



from
    tb_sessoes_providers tp
inner join 
    tb_total_sessoes ts on tp.provider = ts.provider

