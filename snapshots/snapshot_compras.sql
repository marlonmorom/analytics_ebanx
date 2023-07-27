{% snapshot snapshot_compras %}

    {{
        config(
            target_database='desafio-ebanx',
            target_schema='snapshots',
            unique_key='id',
            strategy='check',
            check_cols=['status','data_pagamento']
        )
    }}

    select * from {{ ref('seed_compras')}}

{% endsnapshot %}