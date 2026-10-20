WITH pivote_genero AS (
    SELECT
        genre_name,
        age_group,
        MAX(CASE WHEN user_gender = 'F' THEN rating_promedio END) AS rating_femenino,
        MAX(CASE WHEN user_gender = 'M' THEN rating_promedio END) AS rating_masculino,
        SUM(total_evaluaciones) AS total_votos
    FROM marts.mart_genre_demographic_affinity
    GROUP BY genre_name, age_group
)
SELECT
    genre_name,
    age_group,
    rating_femenino,
    rating_masculino,
    ROUND(ABS(rating_femenino - rating_masculino), 2) AS diferencia_absoluta,
    CASE
        WHEN rating_femenino > rating_masculino THEN 'Mayor agrado Femenino'
        WHEN rating_masculino > rating_femenino THEN 'Mayor agrado Masculino'
        ELSE 'Neutro'
    END AS sesgo_audiencia,
    total_votos
FROM pivote_genero
WHERE rating_femenino IS NOT NULL
  AND rating_masculino IS NOT NULL
ORDER BY diferencia_absoluta DESC
LIMIT 10;
