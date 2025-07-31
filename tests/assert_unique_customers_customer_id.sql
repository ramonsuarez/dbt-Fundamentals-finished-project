select
    id
from {{ source ('jaffle_shop', 'customer') }}
where id is not null
group by id
having id > 1
