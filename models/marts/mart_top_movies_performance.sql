with movies as (

    select * from {{ ref('dim_movies') }}

),

final as (

    select
        movie_id,
        movie_title,
        release_year,
        genres_list,
        total_ratings,
        avg_rating,
        stddev_rating,
        case
            when avg_rating >= 4.0 and total_ratings >= 100 then 'Blockbuster Aclamado'
            when avg_rating >= 4.0 and total_ratings < 100 then 'Película de Culto'
            when avg_rating < 2.5 then 'Bajo Rendimiento'
            else 'Rendimiento Estándar'
        end as performance_category,
        dense_rank() over (order by avg_rating desc, total_ratings desc) as rank_calidad

    from movies
    where total_ratings >= 50

)

select * from final
