SELECT 
    occupation_name,
    COUNT(*) AS cantidad_usuarios,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS porcentaje
FROM marts.dim_users
GROUP BY occupation_name
ORDER BY cantidad_usuarios DESC;