with movies as (

    select * from {{ ref('stg_movies') }}

),

metrics as (

    select * from {{ ref('int_movie_ratings_metrics') }}

),

genres_summary as (

    select
        movie_id,
        string_agg(genre_name, ', ' order by genre_name) as genres_list,
        count(*) as total_genres_count
    from {{ ref('int_movie_genres_expanded') }}
    group by movie_id

),

final as (

    select
        m.movie_id,
        m.movie_title,
        m.release_date,
        extract(year from m.release_date)::integer as release_year,
        m.imdb_url,
        coalesce(g.genres_list, 'None')            as genres_list,
        coalesce(g.total_genres_count, 0)          as total_genres_count,
        coalesce(met.total_ratings, 0)             as total_ratings,
        met.avg_rating,
        met.stddev_rating

    from movies m
    left join metrics met on m.movie_id = met.movie_id
    left join genres_summary g on m.movie_id = g.movie_id

)

select * from final
