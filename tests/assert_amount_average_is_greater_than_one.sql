{{ config(enabled = false) }}

select
    customer_id, 
    avg(amount) as average_amount
from {{ ref('orders') }}
group by customer_id
having count(customer_id) > 1 and average_amount < 1