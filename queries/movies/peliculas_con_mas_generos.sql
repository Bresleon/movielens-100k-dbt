SELECT 
    movie_id,
    movie_title,
    (
        is_action::int + is_adventure::int + is_animation::int + is_children::int + 
        is_comedy::int + is_crime::int + is_documentary::int + is_drama::int + 
        is_fantasy::int + is_film_noir::int + is_horror::int + is_musical::int + 
        is_mystery::int + is_romance::int + is_sci_fi::int + is_thriller::int + 
        is_war::int + is_western::int
    ) AS total_generos
FROM marts.dim_movies
ORDER BY total_generos DESC
LIMIT 10;