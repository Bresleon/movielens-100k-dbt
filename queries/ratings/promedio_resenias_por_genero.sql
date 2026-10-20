SELECT
    g.genre_name AS genero,
    ROUND(AVG(f.rating_value), 2) AS promedio,
    COUNT(*) AS votos
FROM marts.fct_ratings f
JOIN intermediate.int_movie_genres_expanded g USING (movie_id)
GROUP BY g.genre_name
ORDER BY promedio DESC;
