with ratings as (

    select * from {{ ref('stg_ratings') }}

),

metrics as (

    select
        user_id,
        count(*)                             as total_ratings_given,
        round(avg(rating_value)::numeric, 2) as avg_rating_given,
        min(rated_at)                        as first_rating_at,
        max(rated_at)                        as last_rating_at

    from ratings
    group by user_id

)

select * from metrics
