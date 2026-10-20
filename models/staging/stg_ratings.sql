with source as (

    select * from {{ source('ml_source', 'ratings') }}

),

renamed as (

    select
        cast(user_id as integer)           as user_id,
        cast(movie_id as integer)          as movie_id,
        cast(rating as smallint)           as rating_value,
        cast(timestamp as bigint)          as rating_unix_timestamp,
        cast(datetime as timestamp)        as rated_at

    from source

)

select * from renamed