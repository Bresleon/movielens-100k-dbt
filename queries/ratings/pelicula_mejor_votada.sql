SELECT
    movie_id,
    movie_title,
    genres_list,
    total_ratings,
    avg_rating
FROM marts.dim_movies
WHERE total_ratings >= 100
ORDER BY avg_rating DESC, total_ratings DESC
LIMIT 1;
