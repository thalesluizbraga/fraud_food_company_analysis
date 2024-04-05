-- Calcule quanto o índice geral de MATCH seria (na tabela biometry) se 
-- aumentássemos a similaridade mínima do MATCH para 0.90.


select 
    count(bio.session_id) * 1.0 / 
        (select count(Session_ID) from biometry_execution) as indice 



from biometry as bio
inner join biometry_execution as bio_exec on bio.Session_ID = bio_exec.Session_ID

where 
    bio_exec.Similarity >= 0.9
    and bio.status = 'MATCH' 