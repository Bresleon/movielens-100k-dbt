WITH ranking_edad AS (
    SELECT
        age_group,
        genre_name,
        SUM(total_evaluaciones) AS total_votos,
        ROUND(
            SUM(rating_promedio * total_evaluaciones) / SUM(total_evaluaciones),
            2
        ) AS rating_ponderado,
        DENSE_RANK() OVER (
            PARTITION BY age_group
            ORDER BY SUM(rating_promedio * total_evaluaciones) / SUM(total_evaluaciones) DESC
        ) AS rank_genero
    FROM marts.mart_genre_demographic_affinity
    GROUP BY age_group, genre_name
)
SELECT
    age_group,
    rank_genero,
    genre_name,
    rating_ponderado,
    total_votos
FROM ranking_edad
WHERE rank_genero <= 3
ORDER BY
    CASE age_group
        WHEN 'Menor de 18' THEN 1
        WHEN '18-24' THEN 2
        WHEN '25-34' THEN 3
        WHEN '35-49' THEN 4
        ELSE 5
    END,
    rank_genero;
