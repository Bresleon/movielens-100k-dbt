WITH ratings_estacion AS (
    SELECT
        f.rating_season AS estacion,
        m.movie_title,
        ROUND(AVG(f.rating_value), 2) AS rating_promedio,
        COUNT(*) AS total_votos,
        ROW_NUMBER() OVER (
            PARTITION BY f.rating_season
            ORDER BY AVG(f.rating_value) DESC, COUNT(*) DESC
        ) AS rn
    FROM marts.fct_ratings f
    JOIN marts.dim_movies m USING (movie_id)
    GROUP BY f.rating_season, m.movie_title
    HAVING COUNT(*) >= 25
)
SELECT
    estacion,
    movie_title,
    rating_promedio,
    total_votos
FROM ratings_estacion
WHERE rn = 1;
