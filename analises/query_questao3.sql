-- Query que retona a comparacao dos indices de match com similaridade acima de 0.8 e 0.9

-- Tabela que calcula a similaridade maxima, agrupando por session_id

WITH tb_similaridade_max AS (
    SELECT
        session_id,
        MAX(similarity) AS max_similaridade
    FROM
        biometry_execution
    GROUP BY
        session_id
),

-- Tabela que calcula a similaridade acima de 0.8

tb_similaridade_real AS (
    SELECT 
        COUNT(session_id) AS count_session_id,
        CASE 
            WHEN max_similaridade > 0.8 THEN 'match'
            WHEN max_similaridade IS NULL THEN 'provider_failed'
            ELSE 'not_match' 
        END AS similaridade,
        'similaridade_real' AS similaridade_real
    FROM 
        tb_similaridade_max
    GROUP BY 
        CASE 
            WHEN max_similaridade > 0.8 THEN 'match'
            ELSE 'not_match' 
        END

),

-- Tabela que calcula o indice de match para sessoes com similaridade superior a 0.8

tb_indice_similaridade_real as (
    SELECT
        similaridade,
        count_session_id,
        (select count(distinct Session_ID) from biometry_execution) as total_sessoes,
        1.0 * count_session_id /  (select count(distinct Session_ID) from biometry_execution) as indice_similaridade,
        'similaridade_real' as classificacao
        

    FROM 
        tb_similaridade_real
    GROUP BY
        similaridade
),

-- Tabela que calcula a similaridade acima de 0.9

tb_similaridade_projetada AS (
    SELECT 
        COUNT(session_id) AS count_session_id,
        CASE 
            WHEN max_similaridade > 0.9 THEN 'match'
            WHEN max_similaridade IS NULL THEN 'provider_failed'
            ELSE 'not_match' 
        END AS similaridade,
        'projetada' AS tipo
    FROM 
        tb_similaridade_max
    GROUP BY 
        CASE 
            WHEN max_similaridade > 0.9 THEN 'match'
            ELSE 'not_match' 
        END
),

-- Tabela que calcula o indice de match para sessoes com similaridade superior a 0.9

tb_indice_similaridade_projetada as (
    SELECT
        similaridade,
        count_session_id,
        (select count(distinct Session_ID) from biometry_execution) as total_sessoes,
        1.0 * count_session_id /  (select count(distinct Session_ID) from biometry_execution) as indice_similaridade,
        'similaridade_projetada' as classificacao
        

    FROM 
        tb_similaridade_projetada
    GROUP BY
        similaridade
)

-- Tabela que faz a juncao da tabela de indice de match superior a 0.8 com a tabela de indice de match superior a 0.9

select * from tb_indice_similaridade_real

union

select * from tb_indice_similaridade_projetada 

