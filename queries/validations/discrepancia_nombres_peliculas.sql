SELECT 
    movie_id,
    movie_title,
    -- Extrae el contenido dentro de paréntesis que no sea el año de 4 dígitos
    SUBSTRING(movie_title FROM '\(([^0-9]{4}[^\)]*)\)') AS posible_nombre_extranjero
FROM staging.stg_movies
WHERE movie_title ~ '\(([^0-9]{4}[^\)]*)\)'
ORDER BY movie_id;