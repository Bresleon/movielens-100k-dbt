with source_ratings as (

    select * from {{ source('ml_source', 'ratings') }}

),

movies as (

    select movie_id, release_date from {{ ref('stg_movies') }}

),

cleaned as (

    select
        cast(r.user_id as integer)        as user_id,
        cast(r.movie_id as integer)       as movie_id,
        cast(r.rating as smallint)        as rating_value,
        cast(r.timestamp as bigint)       as rating_unix_timestamp,
        cast(r.datetime as timestamp)     as rated_at

    from source_ratings r
    inner join movies m on cast(r.movie_id as integer) = m.movie_id
    -- Excluir ratings previos al estreno oficial (valores anómalos/incorrectos)
    where cast(r.datetime as date) >= m.release_date
      and r.rating between 1 and 5

)

select * from cleaned
