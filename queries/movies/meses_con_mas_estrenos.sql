SELECT
    TO_CHAR(release_date, 'TMMonth') AS mes_nombre,
    EXTRACT(MONTH FROM release_date)::integer AS numero_mes,
    COUNT(*) AS cantidad_estrenos
FROM marts.dim_movies
WHERE release_date IS NOT NULL
GROUP BY TO_CHAR(release_date, 'TMMonth'), EXTRACT(MONTH FROM release_date)
ORDER BY cantidad_estrenos DESC;
