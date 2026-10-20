with users as (

    select * from {{ ref('stg_users') }}

),

summary as (

    select * from {{ ref('int_user_ratings_summary') }}

),

final as (

    select
        u.user_id,
        u.user_age,
        case 
            when u.user_age < 18 then 'Menor de 18'
            when u.user_age between 18 and 24 then '18-24'
            when u.user_age between 25 and 34 then '25-34'
            when u.user_age between 35 and 49 then '35-49'
            else '50+'
        end as age_group,
        u.user_gender,
        initcap(u.occupation_name) as occupation_name,
        u.zip_code,

        -- Métricas de consumo desde intermediate
        coalesce(s.total_ratings_given, 0) as total_ratings_given,
        s.avg_rating_given,
        s.first_rating_at,
        s.last_rating_at

    from users u
    left join summary s on u.user_id = s.user_id

)

select * from final