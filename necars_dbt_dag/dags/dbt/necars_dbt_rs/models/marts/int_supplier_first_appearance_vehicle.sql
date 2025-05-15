-- Get each supplier's first appearance in the vehicle table
select
    row_number() over(
        partition by vehicle_supplier
        order by purchase_invoice_date
    ) as appearance
    ,purchase_invoice_date as purchase_date
    ,vehicle_supplier
from
    -- Redshift requires a FROM-clause alias when immediately preceding QUALIFY
    {{ ref('stg_source_vehicle') }} as stg_source_vehicle
qualify
    appearance = 1