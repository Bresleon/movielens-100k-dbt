SELECT
    genre_name AS genero,
    COUNT(DISTINCT movie_id) AS total_peliculas
FROM intermediate.int_movie_genres_expanded
GROUP BY genre_name
ORDER BY total_peliculas DESC;
