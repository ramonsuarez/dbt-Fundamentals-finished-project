-- dbt run-operation find_all_model_datatypes

{% macro find_all_model_datatypes() %}
    {% for node in graph.nodes.values() | selectattr('resource_type', 'equalto', 'model') %}
        {% set relation = ref(node.name) %}
        {% set cols = adapter.get_columns_in_relation(relation) %}

        {% do print("=== " ~ node.name ~ " ===") %}
        {% for col in cols %}
            {% do print("- name: " ~ col.name | lower ~ "\n  data_type: " ~ col.dtype | lower) %}
        {% endfor %}
        {% do print("") %}
    {% endfor %}
{% endmacro %}
