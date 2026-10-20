WITH genero_desglosado AS (
    SELECT movie_id, movie_title, avg_rating, total_ratings, 'Acción' AS genero FROM marts.dim_movies WHERE is_action UNION ALL
    SELECT movie_id, movie_title, avg_rating, total_ratings, 'Comedia' FROM marts.dim_movies WHERE is_comedy UNION ALL
    SELECT movie_id, movie_title, avg_rating, total_ratings, 'Drama' FROM marts.dim_movies WHERE is_drama UNION ALL
    SELECT movie_id, movie_title, avg_rating, total_ratings, 'Ciencia Ficción' FROM marts.dim_movies WHERE is_sci_fi
),
ranking AS (
    SELECT 
        genero,
        movie_title,
        avg_rating,
        total_ratings,
        DENSE_RANK() OVER (PARTITION BY genero ORDER BY avg_rating DESC, total_ratings DESC) AS puesto
    FROM genero_desglosado
    WHERE total_ratings >= 20
)
SELECT genero, puesto, movie_title, avg_rating, total_ratings
FROM ranking
WHERE puesto <= 3
ORDER BY genero, puesto;