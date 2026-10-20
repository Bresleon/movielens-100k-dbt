WITH ratings_ocupacion AS (
    SELECT 
        u.occupation_name,
        m.movie_title,
        COUNT(*) AS votos_ocupacion,
        ROUND(AVG(f.rating_value), 2) AS rating_promedio_ocupacion,
        ROW_NUMBER() OVER (
            PARTITION BY u.occupation_name 
            ORDER BY AVG(f.rating_value) DESC, COUNT(*) DESC
        ) AS rn
    FROM marts.fct_ratings f
    JOIN marts.dim_users u USING (user_id)
    JOIN marts.dim_movies m USING (movie_id)
    GROUP BY u.occupation_name, m.movie_title
    HAVING COUNT(*) >= 15
)
SELECT occupation_name, movie_title, rating_promedio_ocupacion, votos_ocupacion
FROM ratings_ocupacion
WHERE rn = 1
ORDER BY occupation_name;