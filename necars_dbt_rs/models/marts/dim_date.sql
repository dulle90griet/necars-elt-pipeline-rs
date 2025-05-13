with date_spine as (
  {{ dbt_utils.date_spine(
    datepart="day",
    start_date="to_date('01/01/2020', 'dd/mm/yyyy')",
    end_date="dateadd(year, 1, current_date)"
  ) }}
)
select
  -- date id
  cast(date_day as date) as date_id
  -- day id
  ,cast(extract(year from date_id)||right('00'||extract(dayofyear from date_id), 3) as int) as day_id
  -- day of month
  ,cast(extract(day from date_id) as int) as day_of_month
  -- day of week
  ,cast(extract(dayofweek from date_id) as int) as day_of_week
  -- weekday short name
  ,cast(trim(' ' from to_char(date_id, 'Dy')) as varchar(3)) as weekday_short_name
  -- weekday name
  ,cast(trim(' ' from to_char(date_id, 'Day')) as varchar(9)) as weekday_name
  -- week id
  ,cast(extract(year from date_id)||right('0'||extract(week from date_id), 2) as int) as week_id
  -- week of year
  ,cast(extract(week from date_id) as int) as week_of_year
  -- month id
  ,cast(extract(year from date_id)||right('0'||extract(month from date_id), 2) as int) as month
  -- month of year
  ,cast(extract(month from date_id) as int) as month_of_year
  -- month short name
  ,cast(trim(' ' from to_char(date_id, 'Mon')) as varchar(3)) as month_short_name
  -- month name
  ,cast(trim(' ' from to_char(date_id, 'Month')) as varchar(9)) as month_name
  -- year
  ,cast(extract(year from date_id) as int) as year
  -- quarter_id
  ,cast(extract(year from date_id)||right('0'||extract(quarter from date_id), 2) as int) as quarter_id
  -- quarter_of_year
  ,cast(extract(quarter from date_id) as int) as quarter_of_year
  -- tax_year
  ,case
    when month_of_year < 4
      or (month_of_year = 4 and day_of_month < 6)
      then cast((year - 1)||'-'||year as varchar(9))
    else cast(year||'-'||(year + 1) as varchar(9))
  end as tax_year
from date_spine
