{% snapshot compras_snapshot %}

    {{
        config(
            target_database='desafio-ebanx',
            target_schema='snapshots',
            unique_key='id',
            strategy='check',
            check_cols=['status']
        )
    }}

    select * from {{ source('silver', 'silver_compras')}}

{% endsnapshot %}
