WITH peliculas_por_genero AS (
    SELECT
        g.genre_name AS genero,
        m.movie_id,
        m.movie_title,
        m.avg_rating,
        m.total_ratings,
        DENSE_RANK() OVER (
            PARTITION BY g.genre_name
            ORDER BY m.avg_rating DESC, m.total_ratings DESC
        ) AS puesto
    FROM intermediate.int_movie_genres_expanded g
    JOIN marts.dim_movies m USING (movie_id)
    WHERE m.total_ratings >= 20
)
SELECT
    genero,
    puesto,
    movie_title,
    avg_rating,
    total_ratings
FROM peliculas_por_genero
WHERE puesto <= 3
ORDER BY genero, puesto;
