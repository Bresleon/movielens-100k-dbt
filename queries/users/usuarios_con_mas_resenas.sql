SELECT 
    user_id,
    occupation_name,
    age_group,
    user_gender,
    total_ratings_given,
    avg_rating_given
FROM marts.dim_users
ORDER BY total_ratings_given DESC
LIMIT 10;