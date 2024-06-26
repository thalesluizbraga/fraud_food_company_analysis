select 
    provider,
    count(Session_ID) as count_session,
    sum(case when status='PROVIDER_FAILED' then 1 else 0 end) as sum_failed_sessions,
    1.0* sum(case when status='PROVIDER_FAILED' then 1 else 0 end) / count(Session_ID) as indice_falha

from
    biometry_execution
group by 
    provider