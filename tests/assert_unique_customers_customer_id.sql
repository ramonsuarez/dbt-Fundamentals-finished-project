select
    customer_id
from {{ ref('jaffle_shop', 'orders') }}
group by customer_id
having customer_id > 1