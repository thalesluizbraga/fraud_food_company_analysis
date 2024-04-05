SELECT 
    d.category,
    COUNT(d.Driver_ID) AS count_driver,
    (SELECT COUNT(driver_id) FROM drivers) AS total_driver_count,
    (COUNT(d.Driver_ID) * 1.0) / (SELECT COUNT(driver_id) FROM drivers) AS indice_falha
FROM 
    drivers AS d
INNER JOIN 
    biometry AS b ON d.driver_id = b.driver_id
WHERE 
    b.status = 'NOT_MATCH'
GROUP BY 
    d.category
ORDER BY 
    indice_falha DESC;
