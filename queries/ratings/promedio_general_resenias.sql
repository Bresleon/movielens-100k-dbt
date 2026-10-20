SELECT 
    ROUND(AVG(rating_value), 3) AS rating_promedio_global,
    COUNT(*) AS total_calificaciones_evaluadas
FROM marts.fct_ratings;