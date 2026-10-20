with ratings as (

    select * from {{ ref('fct_ratings') }}

),

users as (

    select user_id, age_group, user_gender, occupation_name from {{ ref('dim_users') }}

),

movie_genres as (

    select * from {{ ref('int_movie_genres_expanded') }}

),

joined as (

    select
        mg.genre_name,
        u.age_group,
        u.user_gender,
        r.rating_value
    from ratings r
    inner join users u on r.user_id = u.user_id
    inner join movie_genres mg on r.movie_id = mg.movie_id

),

final as (

    select
        genre_name,
        age_group,
        user_gender,
        count(*)                             as total_evaluaciones,
        round(avg(rating_value)::numeric, 2) as rating_promedio

    from joined
    group by genre_name, age_group, user_gender
    having count(*) >= 25

)

select * from final
