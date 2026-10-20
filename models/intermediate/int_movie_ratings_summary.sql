with ratings as (

    select * from {{ ref('stg_ratings') }}

),

aggregated as (

    select
        movie_id,
        count(*)                                   as total_ratings,
        round(avg(rating_value)::numeric, 2)       as avg_rating,
        round(stddev(rating_value)::numeric, 2)    as stddev_rating,
        min(rating_value)                          as min_rating,
        max(rating_value)                          as max_rating

    from ratings
    group by movie_id

)

select * from aggregated