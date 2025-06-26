select
    customer_id, 
    avg(amount) as average_amount
from {{ ref('orders') }}
group by customer_id
having avg(amount) > 0