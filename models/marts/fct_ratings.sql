with enriched as (

    select * from {{ ref('int_ratings_enriched') }}

),

final as (

    select
        md5(concat(user_id::text, '-', movie_id::text, '-', rating_unix_timestamp::text)) as rating_id,
        user_id,
        movie_id,
        rating_value,
        rated_at,
        rated_at::date as rating_date,
        rating_month,
        rating_season

    from enriched

)

select * from final
