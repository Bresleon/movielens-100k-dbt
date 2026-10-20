SELECT 
    user_id,
    movie_id,
    COUNT(*) AS total_ratings_registrados,
    MIN(rated_at) AS primer_rating,
    MAX(rated_at) AS ultimo_rating
FROM marts.fct_ratings
GROUP BY user_id, movie_id
HAVING COUNT(*) > 1;