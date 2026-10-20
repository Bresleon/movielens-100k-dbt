WITH ratings_estacion AS (
    SELECT 
        f.movie_id,
        m.movie_title,
        CASE 
            WHEN EXTRACT(MONTH FROM f.rated_at) IN (12, 1, 2) THEN 'Invierno'
            WHEN EXTRACT(MONTH FROM f.rated_at) IN (3, 4, 5) THEN 'Primavera'
            WHEN EXTRACT(MONTH FROM f.rated_at) IN (6, 7, 8) THEN 'Verano'
            ELSE 'Otoño'
        END AS estacion,
        f.rating_value
    FROM marts.fct_ratings f
    JOIN marts.dim_movies m USING (movie_id)
),
agrupado AS (
    SELECT 
        estacion,
        movie_title,
        ROUND(AVG(rating_value), 2) AS rating_promedio,
        COUNT(*) AS total_votos,
        ROW_NUMBER() OVER (
            PARTITION BY estacion 
            ORDER BY AVG(rating_value) DESC, COUNT(*) DESC
        ) AS rn
    FROM ratings_estacion
    GROUP BY estacion, movie_title
    HAVING COUNT(*) >= 25
)
SELECT estacion, movie_title, rating_promedio, total_votos
FROM agrupado
WHERE rn = 1;