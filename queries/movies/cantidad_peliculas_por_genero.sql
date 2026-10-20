SELECT 'Acción' AS genero, COUNT(*) AS total_peliculas FROM marts.dim_movies WHERE is_action UNION ALL
SELECT 'Aventura', COUNT(*) FROM marts.dim_movies WHERE is_adventure UNION ALL
SELECT 'Animación', COUNT(*) FROM marts.dim_movies WHERE is_animation UNION ALL
SELECT 'Infantil', COUNT(*) FROM marts.dim_movies WHERE is_children UNION ALL
SELECT 'Comedia', COUNT(*) FROM marts.dim_movies WHERE is_comedy UNION ALL
SELECT 'Crimen', COUNT(*) FROM marts.dim_movies WHERE is_crime UNION ALL
SELECT 'Documental', COUNT(*) FROM marts.dim_movies WHERE is_documentary UNION ALL
SELECT 'Drama', COUNT(*) FROM marts.dim_movies WHERE is_drama UNION ALL
SELECT 'Fantasía', COUNT(*) FROM marts.dim_movies WHERE is_fantasy UNION ALL
SELECT 'Cine Negro', COUNT(*) FROM marts.dim_movies WHERE is_film_noir UNION ALL
SELECT 'Terror', COUNT(*) FROM marts.dim_movies WHERE is_horror UNION ALL
SELECT 'Musical', COUNT(*) FROM marts.dim_movies WHERE is_musical UNION ALL
SELECT 'Misterio', COUNT(*) FROM marts.dim_movies WHERE is_mystery UNION ALL
SELECT 'Romance', COUNT(*) FROM marts.dim_movies WHERE is_romance UNION ALL
SELECT 'Ciencia Ficción', COUNT(*) FROM marts.dim_movies WHERE is_sci_fi UNION ALL
SELECT 'Suspenso', COUNT(*) FROM marts.dim_movies WHERE is_thriller UNION ALL
SELECT 'Bélica', COUNT(*) FROM marts.dim_movies WHERE is_war UNION ALL
SELECT 'Western', COUNT(*) FROM marts.dim_movies WHERE is_western
ORDER BY total_peliculas DESC;