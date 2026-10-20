with genre_seed as (

    select 1 as genre_id, 'Unknown' as genre_name union all
    select 2, 'Action' union all
    select 3, 'Adventure' union all
    select 4, 'Animation' union all
    select 5, 'Children' union all
    select 6, 'Comedy' union all
    select 7, 'Crime' union all
    select 8, 'Documentary' union all
    select 9, 'Drama' union all
    select 10, 'Fantasy' union all
    select 11, 'Film-Noir' union all
    select 12, 'Horror' union all
    select 13, 'Musical' union all
    select 14, 'Mystery' union all
    select 15, 'Romance' union all
    select 16, 'Sci-Fi' union all
    select 17, 'Thriller' union all
    select 18, 'War' union all
    select 19, 'Western'

)

select
    cast(genre_id as integer) as genre_id,
    cast(genre_name as varchar(50)) as genre_name
from genre_seed
