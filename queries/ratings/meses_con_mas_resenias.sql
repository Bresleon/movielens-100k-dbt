SELECT
    rating_month AS anio_mes,
    COUNT(*) AS cantidad_votos,
    ROUND(AVG(rating_value), 2) AS rating_promedio
FROM marts.fct_ratings
GROUP BY rating_month
ORDER BY cantidad_votos DESC;
