-- dbt run-operation print_model_columns --args '{"model_name": "your_model_name"}'
-- Results will be shown in logs as this: 
-- 09:12:38 - name: order_id
--   data_type: int
-- - name: customer_id
--   data_type: int
-- - name: order_date
--   data_type: date
-- - name: amount
--   data_type: int


{% macro find_datatypes(model) %}
    {% set relation = ref(model) %}
    {% set cols=adapter.get_columns_in_relation(relation) %}

    {% set output_lines = [] %}

    {%- for col in cols %}
        {% do output_lines.append("- name: " ~ col.name | lower ~ "\n  data_type: " ~ col.dtype | lower) %}
    {%- endfor %}

    {% do print('\n'.join(output_lines)) %}

{% endmacro %}

/*
-- Original macro in course
-- {% macro find_datatypes(model) %}
--     {% set cols=adapter.get_columns_in_relation(model) %}
--     {%- for col in cols %}
--       - name: {{ col.name | lower }}
--         data_type: {{ col.dtype | lower }}
--     {%- endfor %}
-- {% endmacro %}
*/