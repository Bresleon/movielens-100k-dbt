with movie_genres as (

    select * from {{ ref('stg_movie_genres') }}

),

genres as (

    select * from {{ ref('stg_genres') }}

),

joined as (

    select
        mg.movie_id,
        mg.genre_id,
        g.genre_name
    from movie_genres mg
    inner join genres g on mg.genre_id = g.genre_id

)

select * from joined
