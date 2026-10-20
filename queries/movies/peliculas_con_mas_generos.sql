SELECT
    movie_id,
    movie_title,
    genres_list,
    total_genres_count AS total_generos
FROM marts.dim_movies
ORDER BY total_generos DESC, movie_title ASC
LIMIT 10;
