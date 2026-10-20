SELECT 
    'staging.stg_movies' AS tabla,
    COUNT(*) FILTER (WHERE movie_id IS NULL) AS nulos_id,
    COUNT(*) FILTER (WHERE movie_title IS NULL) AS nulos_titulo,
    COUNT(*) FILTER (WHERE release_date IS NULL) AS nulos_fecha_estreno
FROM staging.stg_movies
UNION ALL
SELECT 
    'staging.stg_users',
    COUNT(*) FILTER (WHERE user_id IS NULL),
    COUNT(*) FILTER (WHERE occupation_name IS NULL),
    COUNT(*) FILTER (WHERE user_age IS NULL)
FROM staging.stg_users
UNION ALL
SELECT 
    'staging.stg_ratings',
    COUNT(*) FILTER (WHERE rating_id IS NULL),
    COUNT(*) FILTER (WHERE user_id IS NULL),
    COUNT(*) FILTER (WHERE movie_id IS NULL)
FROM marts.fct_ratings;