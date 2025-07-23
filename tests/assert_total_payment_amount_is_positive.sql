select
    customer_id, 
    avg(amount) as average_amount
from {{ ref('jaffle_shop', 'orders') }}
group by customer_id
having avg(amount) > 0