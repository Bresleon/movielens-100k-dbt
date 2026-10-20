SELECT 
    m.movie_id,
    m.movie_title,
    m.release_date
FROM marts.dim_movies m
LEFT JOIN marts.fct_ratings f USING (movie_id)
WHERE f.movie_id IS NULL;