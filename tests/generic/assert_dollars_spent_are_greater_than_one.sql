{% test average_dollars_spent_greater_than_one( model, column_name, group_by_column) %}

{% set group_by_columns = group_by_column.split(',') | map('trim') | list %}
select
    {{ group_by_columns | join(',\n    ') }},
    avg({{ column_name }}) as average_amount
from {{ model }}
group by {{ group_by_columns | join(', ') }}
having avg({{ column_name }}) < 1


{% endtest %}