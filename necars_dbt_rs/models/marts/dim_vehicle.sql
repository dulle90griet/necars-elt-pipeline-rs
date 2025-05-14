select
  stock_id, stock_type, make, model, door_count, transmission_type, fuel_type
from (
  select
    stock_id
    ,stock_type
    ,make
    -- model: all text up to " [N]dr "
    ,regexp_substr(vehicle_description, '.*(?=\\s\\d\\s?dr\\b)', 1, 1, 'ip') as model
    -- door count: the first digit after model (and before "dr")
    ,regexp_substr(vehicle_description, '\\d', len(model) + 1) as door_count
    -- door count end: a helper value, the index at which the door count substring ends
    ,regexp_instr(vehicle_description, '\\b\\d\\s?dr\\b', len(model) + 1, 1, 1, 'i') as door_count_end
    -- fuel type: any of the matching words, with any number of spaces after it,
    --   one or more times
    ,regexp_substr(vehicle_description, '\\b(((petrol|diesel|electric|plug-in|plug|in|hybrid)\\s*)+)\\b', door_count_end, 1, 'i') as fuel_type
    -- fuel start: a helper value, the index at which the fuel substring starts
    ,regexp_instr(vehicle_description, '\\b(petrol|diesel|electric|plug-in|plug|in|hybrid)', door_count_end, 1, 0, 'i') as fuel_start
    -- transmission type: if fuel_type found, the text between door_count and fuel_type
    ,case
      when fuel_start > 0
        then trim(substring(vehicle_description, door_count_end, fuel_start - door_count_end))
      else -- otherwise, the text between door_count and end of string
        trim(substring(vehicle_description, door_count_end))
    end as transmission_type
  from
    {{ ref('int_vehicle') }}
)