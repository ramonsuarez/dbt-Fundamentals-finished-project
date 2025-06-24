select
    customer_id, 
from {{ ref('orders') }}
group by customer_id
having customer_id > 1