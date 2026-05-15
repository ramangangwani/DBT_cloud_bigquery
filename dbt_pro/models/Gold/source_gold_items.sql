with deduped as (

    select
        *,
        row_number() over (
            partition by id
            order by updateDate desc
        ) as rn

    from {{ source('source', 'items') }}

)

select
    id,
    name,
    category,
    updateDate

from deduped

where rn = 1