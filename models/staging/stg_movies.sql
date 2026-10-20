with source as (

    select * from {{ source('ml_source', 'movies') }}

),

cleaned as (

    select
        cast(movie_id as integer)            as movie_id,
        trim(title)                          as movie_title,
        to_date(release_date, 'DD-Mon-YYYY') as release_date,
        trim(imdb_url)                       as imdb_url

    from source
    -- Eliminar registros con nulos en campos obligatorios o títulos inválidos
    where release_date is not null
      and movie_id != 267

)

select * from cleaned
