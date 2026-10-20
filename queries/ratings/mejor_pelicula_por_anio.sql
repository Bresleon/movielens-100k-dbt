WITH anios AS (
    SELECT
        release_year,
        movie_title,
        avg_rating,
        total_ratings,
        ROW_NUMBER() OVER (
            PARTITION BY release_year
            ORDER BY avg_rating DESC, total_ratings DESC
        ) AS rn
    FROM marts.dim_movies
    WHERE release_year IS NOT NULL
      AND total_ratings >= 20
)
SELECT
    release_year,
    movie_title,
    avg_rating,
    total_ratings
FROM anios
WHERE rn = 1
ORDER BY release_year DESC;
