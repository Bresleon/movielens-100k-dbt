SELECT 
    movie_id,
    movie_title,
    total_ratings,
    avg_rating
FROM marts.dim_movies
WHERE total_ratings >= 100
ORDER BY avg_rating ASC, total_ratings DESC
LIMIT 1;