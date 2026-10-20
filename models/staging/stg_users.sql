with source as (

    select * from {{ source('ml_source', 'users') }}

),

cleaned as (

    select
        cast(user_id as integer)           as user_id,
        cast(age as smallint)              as user_age,
        upper(trim(gender))                as user_gender,
        lower(trim(occupation))            as occupation_name,
        trim(zip_code)                     as zip_code

    from source
    where user_id is not null

)

select * from cleaned
