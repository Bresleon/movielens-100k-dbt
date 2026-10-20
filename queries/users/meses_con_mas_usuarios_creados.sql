SELECT 
    DATE_TRUNC('month', first_rating_at)::date AS mes_inicio,
    COUNT(*) AS cantidad_usuarios
FROM marts.dim_users
WHERE first_rating_at IS NOT NULL
GROUP BY DATE_TRUNC('month', first_rating_at)
ORDER BY cantidad_usuarios DESC;