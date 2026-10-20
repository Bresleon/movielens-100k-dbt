WITH decadas AS (
    SELECT 
        (release_year / 10) * 10 AS decada,
        movie_title,
        avg_rating,
        total_ratings,
        ROW_NUMBER() OVER (
            PARTITION BY (release_year / 10) * 10 
            ORDER BY avg_rating DESC, total_ratings DESC
        ) AS rn
    FROM marts.dim_movies
    WHERE release_year IS NOT NULL AND total_ratings >= 30
)
SELECT decada, movie_title, avg_rating, total_ratings
FROM decadas
WHERE rn = 1
ORDER BY decada ASC;