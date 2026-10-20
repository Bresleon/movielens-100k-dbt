SELECT
    r.user_id,
    r.movie_id,
    m.title AS movie_title,
    TO_DATE(m.release_date, 'DD-Mon-YYYY') AS fecha_estreno,
    r.datetime::timestamp AS fecha_calificacion,
    (TO_DATE(m.release_date, 'DD-Mon-YYYY') - r.datetime::date) AS dias_antes_del_estreno
FROM source.ratings r
JOIN source.movies m ON r.movie_id = m.movie_id
WHERE m.release_date IS NOT NULL
  AND r.datetime::date < TO_DATE(m.release_date, 'DD-Mon-YYYY')
ORDER BY dias_antes_del_estreno DESC;
