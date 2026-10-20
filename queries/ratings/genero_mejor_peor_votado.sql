WITH genero_ratings AS (
    SELECT 'Acción' AS genero, f.rating_value FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_action UNION ALL
    SELECT 'Comedia', f.rating_value FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_comedy UNION ALL
    SELECT 'Drama', f.rating_value FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_drama UNION ALL
    SELECT 'Terror', f.rating_value FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_horror UNION ALL
    SELECT 'Ciencia Ficción', f.rating_value FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_sci_fi UNION ALL
    SELECT 'Cine Negro', f.rating_value FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_film_noir UNION ALL
    SELECT 'Documental', f.rating_value FROM marts.fct_ratings f JOIN marts.dim_movies m USING (movie_id) WHERE m.is_documentary
),
resumen AS (
    SELECT 
        genero,
        ROUND(AVG(rating_value), 2) AS rating_promedio,
        COUNT(*) AS total_votos
    FROM genero_ratings
    GROUP BY genero
)
-- Mejor votado
(SELECT 'Mejor Votado' AS tipo, genero, rating_promedio, total_votos FROM resumen ORDER BY rating_promedio DESC LIMIT 1)
UNION ALL
-- Peor votado
(SELECT 'Peor Votado' AS tipo, genero, rating_promedio, total_votos FROM resumen ORDER BY rating_promedio ASC LIMIT 1);