select 
    provider,
    count(status) as contagem_status

from biometry_execution

where status = 'PROVIDER_FAILED'

group by provider

order by count(status) desc