SELECT
    performance_category,
    movie_title,
    release_year,
    genres_list,
    total_ratings,
    avg_rating,
    stddev_rating
FROM marts.mart_top_movies_performance
WHERE performance_category IN ('Blockbuster Aclamado', 'Película de Culto')
ORDER BY performance_category ASC, avg_rating DESC, total_ratings DESC;
