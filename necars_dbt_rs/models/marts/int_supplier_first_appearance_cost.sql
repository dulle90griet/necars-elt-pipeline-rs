-- Get each supplier's first appearance in the cost table
with ranked_appearances as (
    select
        row_number() over(
            partition by recondition_supplier
            order by date
        ) as appearance
        ,date as recondition_date
        ,recondition_supplier
    from
        {{ ref('stg_source_cost') }}
)
select
    recondition_date
    ,recondition_supplier
from
    ranked_appearances
where
    appearance = 1
