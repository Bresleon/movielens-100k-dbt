WITH estadisticas_genero AS (
    SELECT
        genre_name,
        SUM(total_evaluaciones) AS volumen_total,
        ROUND(
            SUM(rating_promedio * total_evaluaciones) / SUM(total_evaluaciones),
            2
        ) AS satisfaccion_promedio
    FROM marts.mart_genre_demographic_affinity
    GROUP BY genre_name
),
medias_globales AS (
    SELECT
        AVG(volumen_total) AS umbral_volumen,
        AVG(satisfaccion_promedio) AS umbral_satisfaccion
    FROM estadisticas_genero
)
SELECT
    g.genre_name,
    g.volumen_total,
    g.satisfaccion_promedio,
    CASE
        WHEN g.volumen_total >= m.umbral_volumen AND g.satisfaccion_promedio >= m.umbral_satisfaccion
            THEN 'Estrella (Alto consumo, Alta aprobación)'
        WHEN g.volumen_total < m.umbral_volumen AND g.satisfaccion_promedio >= m.umbral_satisfaccion
            THEN 'Oportunidad / Nicho de Alta Calidad'
        WHEN g.volumen_total >= m.umbral_volumen AND g.satisfaccion_promedio < m.umbral_satisfaccion
            THEN 'Consumo Masivo / Satisfacción Moderada'
        ELSE 'Revisión Crítica (Bajo consumo y calificación)'
    END AS clasificacion_estrategica
FROM estadisticas_genero g
CROSS JOIN medias_globales m
ORDER BY g.satisfaccion_promedio DESC, g.volumen_total DESC;
