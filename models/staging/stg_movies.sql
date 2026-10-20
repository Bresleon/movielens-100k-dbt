with source as (

    select * from {{ source('ml_source', 'movies') }}

),

renamed as (

    select
        cast(movie_id as integer)                             as movie_id,
        trim(title)                                           as movie_title,
        to_date(release_date, 'DD-Mon-YYYY')                  as release_date,
        trim(imdb_url)                                        as imdb_url,

        -- Banderas booleanas de género
        cast(unknown as integer) = 1                          as is_genre_unknown,
        cast("Action" as integer) = 1                         as is_action,
        cast("Adventure" as integer) = 1                      as is_adventure,
        cast("Animation" as integer) = 1                      as is_animation,
        cast("Childrens" as integer) = 1                      as is_children,
        cast("Comedy" as integer) = 1                         as is_comedy,
        cast("Crime" as integer) = 1                          as is_crime,
        cast("Documentary" as integer) = 1                    as is_documentary,
        cast("Drama" as integer) = 1                          as is_drama,
        cast("Fantasy" as integer) = 1                        as is_fantasy,
        cast("Film_Noir" as integer) = 1                      as is_film_noir,
        cast("Horror" as integer) = 1                         as is_horror,
        cast("Musical" as integer) = 1                        as is_musical,
        cast("Mystery" as integer) = 1                        as is_mystery,
        cast("Romance" as integer) = 1                        as is_romance,
        cast("Sci_Fi" as integer) = 1                         as is_sci_fi,
        cast("Thriller" as integer) = 1                       as is_thriller,
        cast("War" as integer) = 1                            as is_war,
        cast("Western" as integer) = 1                        as is_western

    from source

)

select * from renamed
