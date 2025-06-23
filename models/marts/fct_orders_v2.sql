with orders as (
    select * from {{ ref('int_orders') }}
),

final as (
    select 
        order_id,
        -- location_id,
        customer_id,
        amount as order_amount,
        -- tax_paid,
        order_date as ordered_at--,
        -- customer_name,
        -- location_name,
        -- tax_rate,
        -- cast(location_opened_at as date) as location_opened_at,
        -- datepart(month, ordered_at) as ordered_month,
        -- datepart(day, ordered_at) as ordered_day, 
        -- datepart(year, ordered_at) as ordered_year
    from orders
)

select * 
from final