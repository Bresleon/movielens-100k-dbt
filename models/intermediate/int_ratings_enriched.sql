with ratings as (

    select * from {{ ref('stg_ratings') }}

),

movies as (

    select movie_id, movie_title, release_date from {{ ref('stg_movies') }}

),

users as (

    select user_id, user_age, user_gender, occupation_name from {{ ref('stg_users') }}

),

enriched as (

    select
        r.user_id,
        r.movie_id,
        r.rating_value,
        r.rated_at,
        r.rating_unix_timestamp,
        m.movie_title,
        m.release_date,
        extract(year from m.release_date)::integer as movie_release_year,
        u.user_age,
        u.user_gender,
        u.occupation_name,

        -- Dimensiones temporales
        to_char(r.rated_at, 'YYYY-MM') as rating_month,
        case
            when extract(month from r.rated_at) in (12, 1, 2) then 'Invierno'
            when extract(month from r.rated_at) in (3, 4, 5) then 'Primavera'
            when extract(month from r.rated_at) in (6, 7, 8) then 'Verano'
            else 'Otoño'
        end as rating_season

    from ratings r
    inner join movies m on r.movie_id = m.movie_id
    inner join users u on r.user_id = u.user_id

)

select * from enriched
