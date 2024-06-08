-- Query que calcula a media de acessos negados (sttus 'NOT MATCH') dos ultimos 30 dias e compara com o numero de acessos com acessos negados por dia.

-- Tabela que calcula a quantidade de acessos negados 

WITH tb_acesso_negados_por_dia AS (
    SELECT 
        Event_Dt,
        COUNT(Session_ID) AS acessos_negados
    FROM
        biometry_execution
    WHERE 
        status = 'NOT_MATCH'
    GROUP BY
        Event_Dt
),

-- Tabela que calcula a media de acessos negados 


tb_media_acessos_negados_por_dia AS (
    SELECT
        Event_Dt,
        acessos_negados,
        round(AVG(acessos_negados) OVER (),0) AS media_acessos
    FROM 
        tb_acesso_negados_por_dia
)

SELECT 
    Event_Dt,
    acessos_negados,
    media_acessos
FROM 
    tb_media_acessos_negados_por_dia
ORDER BY 
    Event_Dt ASC;
