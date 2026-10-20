with users as (

    select * from {{ ref('stg_users') }}

),

behavior as (

    select * from {{ ref('int_user_behavior_metrics') }}

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
        initcap(u.occupation_name)                 as occupation_name,
        u.zip_code,
        coalesce(b.total_ratings_given, 0)         as total_ratings_given,
        b.avg_rating_given,
        b.first_rating_at,
        b.last_rating_at,
        case
            when b.total_ratings_given >= 150 then 'Power Reviewer'
            when b.total_ratings_given >= 50 then 'Usuario Frecuente'
            else 'Usuario Ocasional'
        end as user_segment

    from users u
    left join behavior b on u.user_id = b.user_id

)

select * from final
