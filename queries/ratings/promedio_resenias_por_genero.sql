SELECT 'Cine Negro' AS genero, ROUND(AVG(f.rating_value), 2) AS promedio, COUNT(*) AS votos FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_film_noir UNION ALL
SELECT 'Bélica', ROUND(AVG(f.rating_value), 2), COUNT(*) FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_war UNION ALL
SELECT 'Drama', ROUND(AVG(f.rating_value), 2), COUNT(*) FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_drama UNION ALL
SELECT 'Misterio', ROUND(AVG(f.rating_value), 2), COUNT(*) FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_mystery UNION ALL
SELECT 'Animación', ROUND(AVG(f.rating_value), 2), COUNT(*) FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_animation UNION ALL
SELECT 'Ciencia Ficción', ROUND(AVG(f.rating_value), 2), COUNT(*) FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_sci_fi UNION ALL
SELECT 'Acción', ROUND(AVG(f.rating_value), 2), COUNT(*) FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_action UNION ALL
SELECT 'Comedia', ROUND(AVG(f.rating_value), 2), COUNT(*) FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_comedy UNION ALL
SELECT 'Terror', ROUND(AVG(f.rating_value), 2), COUNT(*) FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_horror
ORDER BY promedio DESC;