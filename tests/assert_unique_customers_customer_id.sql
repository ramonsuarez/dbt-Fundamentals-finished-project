select id, count(*) as count
from {{ source ('jaffle_shop', 'customers') }}
where id is not null
group by id
having count(*) > 1
