select
    id,
    count(*) as count_id
from {{ source ('jaffle_shop', 'customers') }}
where id is not null
group by id
having count(*) > 1
