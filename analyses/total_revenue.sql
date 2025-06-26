select
    sum(amount) as total_successful_revenue
from {{ ref('stg_stripe__payments') }}
where status = 'success'