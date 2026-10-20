SELECT
    movie_id,
    movie_title,
    release_year,
    genres_list,
    total_ratings,
    avg_rating
FROM marts.dim_movies
ORDER BY total_ratings DESC
LIMIT 10;
