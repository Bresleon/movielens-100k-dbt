SELECT
    rank_calidad,
    movie_title,
    release_year,
    genres_list,
    total_ratings,
    avg_rating
FROM marts.mart_top_movies_performance
WHERE performance_category = 'Bajo Rendimiento'
   OR avg_rating < 2.8
ORDER BY total_ratings DESC, avg_rating ASC;
