WITH ranking_generos AS (
    SELECT
        g.genre_name AS genero,
        ROUND(AVG(f.rating_value), 2) AS rating_promedio,
        COUNT(*) AS total_votos
    FROM marts.fct_ratings f
    JOIN intermediate.int_movie_genres_expanded g USING (movie_id)
    GROUP BY g.genre_name
    HAVING COUNT(*) >= 100
)
(
    SELECT 'Mejor Votado' AS tipo, genero, rating_promedio, total_votos
    FROM ranking_generos
    ORDER BY rating_promedio DESC
    LIMIT 1
)
UNION ALL
(
    SELECT 'Peor Votado' AS tipo, genero, rating_promedio, total_votos
    FROM ranking_generos
    ORDER BY rating_promedio ASC
    LIMIT 1
);
