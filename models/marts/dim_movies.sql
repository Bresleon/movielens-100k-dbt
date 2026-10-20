with movies as (

    select * from {{ ref('stg_movies') }}

),

summary as (

    select * from {{ ref('int_movie_ratings_summary') }}

),

final as (

    select
        m.movie_id,
        m.movie_title,
        m.release_date,
        extract(year from m.release_date)::integer as release_year,
        m.imdb_url,
        
        -- Géneros
        m.is_genre_unknown,
        m.is_action,
        m.is_adventure,
        m.is_animation,
        m.is_children,
        m.is_comedy,
        m.is_crime,
        m.is_documentary,
        m.is_drama,
        m.is_fantasy,
        m.is_film_noir,
        m.is_horror,
        m.is_musical,
        m.is_mystery,
        m.is_romance,
        m.is_sci_fi,
        m.is_thriller,
        m.is_war,
        m.is_western,

        -- Métricas agregadas de intermediate
        coalesce(s.total_ratings, 0) as total_ratings,
        s.avg_rating,
        s.stddev_rating

    from movies m
    left join summary s on m.movie_id = s.movie_id

)

select * from final