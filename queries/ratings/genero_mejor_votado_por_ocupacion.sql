WITH genero_ocupacion AS (
    SELECT u.occupation_name, 'Acción' AS genero, f.rating_value FROM marts.fct_ratings f JOIN marts.dim_users u USING (user_id) JOIN marts.dim_movies m USING (movie_id) WHERE m.is_action UNION ALL
    SELECT u.occupation_name, 'Comedia', f.rating_value FROM marts.fct_ratings f JOIN marts.dim_users u USING (user_id) JOIN marts.dim_movies m USING (movie_id) WHERE m.is_comedy UNION ALL
    SELECT u.occupation_name, 'Drama', f.rating_value FROM marts.fct_ratings f JOIN marts.dim_users u USING (user_id) JOIN marts.dim_movies m USING (movie_id) WHERE m.is_drama UNION ALL
    SELECT u.occupation_name, 'Cine Negro', f.rating_value FROM marts.fct_ratings f JOIN marts.dim_users u USING (user_id) JOIN marts.dim_movies m USING (movie_id) WHERE m.is_film_noir UNION ALL
    SELECT u.occupation_name, 'Ciencia Ficción', f.rating_value FROM marts.fct_ratings f JOIN marts.dim_users u USING (user_id) JOIN marts.dim_movies m USING (movie_id) WHERE m.is_sci_fi
),
promedios AS (
    SELECT 
        occupation_name,
        genero,
        ROUND(AVG(rating_value), 2) AS rating_promedio,
        COUNT(*) AS votos,
        ROW_NUMBER() OVER (PARTITION BY occupation_name ORDER BY AVG(rating_value) DESC) AS rn
    FROM genero_ocupacion
    GROUP BY occupation_name, genero
    HAVING COUNT(*) >= 20
)
SELECT occupation_name, genero AS genero_favorito, rating_promedio, votos
FROM promedios
WHERE rn = 1
ORDER BY occupation_name;