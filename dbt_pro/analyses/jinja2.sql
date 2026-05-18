{%- set apples= ["Red", "Green", "Blue", "McIntosh", "honeycrisp"] -%}

{% for apple in apples%}
    {{apple}}
{% endfor %}