-- Contenido de consenso seguro (Avg >= 4.0 con menor varianza)
(
    SELECT
        'Consenso Positivo' AS tipo_audiencia,
        movie_title,
        avg_rating,
        stddev_rating,
        total_ratings
    FROM marts.mart_top_movies_performance
    WHERE avg_rating >= 4.0
    ORDER BY stddev_rating ASC
    LIMIT 5
)
UNION ALL
-- Contenido altamente polarizante (Mayor desvío dentro de películas populares)
(
    SELECT
        'Polarizante / Controversial' AS tipo_audiencia,
        movie_title,
        avg_rating,
        stddev_rating,
        total_ratings
    FROM marts.mart_top_movies_performance
    WHERE total_ratings >= 100
    ORDER BY stddev_rating DESC
    LIMIT 5
);
