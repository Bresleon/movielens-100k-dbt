with source as (

    select * from {{ source('ml_source', 'movies') }}
    where release_date is not null
      and movie_id != 267

),

unpivoted as (

    select cast(movie_id as integer) as movie_id, 1 as genre_id from source where unknown = 1 union all
    select cast(movie_id as integer), 2 from source where "Action" = 1 union all
    select cast(movie_id as integer), 3 from source where "Adventure" = 1 union all
    select cast(movie_id as integer), 4 from source where "Animation" = 1 union all
    select cast(movie_id as integer), 5 from source where "Childrens" = 1 union all
    select cast(movie_id as integer), 6 from source where "Comedy" = 1 union all
    select cast(movie_id as integer), 7 from source where "Crime" = 1 union all
    select cast(movie_id as integer), 8 from source where "Documentary" = 1 union all
    select cast(movie_id as integer), 9 from source where "Drama" = 1 union all
    select cast(movie_id as integer), 10 from source where "Fantasy" = 1 union all
    select cast(movie_id as integer), 11 from source where "Film_Noir" = 1 union all
    select cast(movie_id as integer), 12 from source where "Horror" = 1 union all
    select cast(movie_id as integer), 13 from source where "Musical" = 1 union all
    select cast(movie_id as integer), 14 from source where "Mystery" = 1 union all
    select cast(movie_id as integer), 15 from source where "Romance" = 1 union all
    select cast(movie_id as integer), 16 from source where "Sci_Fi" = 1 union all
    select cast(movie_id as integer), 17 from source where "Thriller" = 1 union all
    select cast(movie_id as integer), 18 from source where "War" = 1 union all
    select cast(movie_id as integer), 19 from source where "Western" = 1

)

select * from unpivoted
