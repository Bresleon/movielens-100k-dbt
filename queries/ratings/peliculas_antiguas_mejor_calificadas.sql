SELECT 
    movie_title,
    release_year,
    total_ratings,
    avg_rating
FROM marts.dim_movies
WHERE release_year < 1970 
  AND total_ratings >= 20
ORDER BY avg_rating DESC
LIMIT 10;