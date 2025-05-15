select
  cast(substring(s_v.full_stock_number, 2) as int) as stock_id
  ,d_s.supplier_id
  ,s_v.purchase_invoice_no as purchase_invoice_id
  ,to_date(s_v.purchase_invoice_date, 'yyyy-mm-dd') as purchase_invoice_date
  ,to_char(s_v.purchase_invoice_date, 'dd/mm/yyyy hh24:mi:ss') as purchase_invoice_time
  ,s_v.nominal_purchase_code as nominal_code
  ,s_v.purchase_price_gbp
  ,s_v.part_ex
  ,to_date(s_v.in_stock_date, 'yyyy-mm-dd') as in_stock_date
from
  {{ ref('stg_source_vehicle') }} as s_v
join
  {{ ref('dim_supplier') }} as d_s
on
  s_v.vehicle_supplier = d_s.supplier_name