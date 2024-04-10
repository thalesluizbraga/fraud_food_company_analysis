select 
    provider,
    count(session_id) as count_session


from biometry_execution
where status = 'PROVIDER_FAILED'
group by provider 
order by count(session_id) desc