select
  s_c.sage_ref
  ,s_c.stock_number as stock_id
  ,d_s.supplier_id
  ,to_date(s_c.date, 'yyyy-mm-dd') as payment_date
  ,to_char(s_c.date, 'hh24:mi:ss') as payment_time
  ,s_c.nominal_code
  ,case
    when s_c.nominal_code in (5302, 5303, 5305)
      then s_c.recondition_description
  end as description
  ,s_c.quantity
  ,s_c.gross_amount
  ,s_c.vat
  ,s_c.net_cost_price
  ,s_c.net_extra_price
  ,s_c.profit
from
  {{ ref('stg_source_cost') }} as s_c
join
  {{ ref('dim_supplier') }} as d_s
  on s_c.recondition_supplier = d_s.supplier_name
join
  {{ ref('dim_nominal_code') }} as d_n
  on s_c.nominal_code = d_n.code_id
