-- En ratings: usuario calificando más de una vez la misma película
SELECT user_id, movie_id, COUNT(*) AS veces_repetido
FROM staging.stg_ratings
GROUP BY user_id, movie_id
HAVING COUNT(*) > 1;

-- En películas: títulos idénticos repetidos en el catálogo
SELECT movie_title, COUNT(*) AS repeticiones
FROM staging.stg_movies
GROUP BY movie_title
HAVING COUNT(*) > 1;