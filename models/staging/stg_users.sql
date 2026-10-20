with source as (

    select * from {{ source('ml_source', 'users') }}

),

renamed as (

    select
        cast(user_id as integer)           as user_id,
        cast(age as smallint)              as user_age,
        upper(trim(gender))                as user_gender,
        lower(trim(occupation))            as occupation_name,
        trim(zip_code)                     as zip_code

    from source

)

select * from renamed