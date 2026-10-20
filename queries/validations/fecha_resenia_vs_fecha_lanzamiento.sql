SELECT 
    f.rating_id,
    f.user_id,
    m.movie_id,
    m.movie_title,
    m.release_date AS fecha_estreno,
    f.rated_at AS fecha_calificacion,
    (m.release_date - f.rated_at::date) AS dias_antes_del_estreno
FROM marts.fct_ratings f
JOIN marts.dim_movies m USING (movie_id)
WHERE f.rated_at::date < m.release_date
ORDER BY dias_antes_del_estreno DESC;