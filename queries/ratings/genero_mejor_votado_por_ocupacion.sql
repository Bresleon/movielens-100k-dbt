WITH genero_ocupacion AS (
    SELECT
        u.occupation_name,
        g.genre_name AS genero,
        ROUND(AVG(f.rating_value), 2) AS rating_promedio,
        COUNT(*) AS votos,
        ROW_NUMBER() OVER (
            PARTITION BY u.occupation_name
            ORDER BY AVG(f.rating_value) DESC, COUNT(*) DESC
        ) AS rn
    FROM marts.fct_ratings f
    JOIN marts.dim_users u USING (user_id)
    JOIN intermediate.int_movie_genres_expanded g USING (movie_id)
    GROUP BY u.occupation_name, g.genre_name
    HAVING COUNT(*) >= 20
)
SELECT
    occupation_name,
    genero AS genero_favorito,
    rating_promedio,
    votos
FROM genero_ocupacion
WHERE rn = 1
ORDER BY occupation_name;
