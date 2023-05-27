WITH aux AS (
SELECT
    DISTINCT
    id,
    nome,
    pais,
    CASE 
    WHEN CAST(SPLIT(data_nascimento, REGEXP_EXTRACT(data_nascimento, r'\D'))[OFFSET(0)] AS INT64)>1900 THEN 
    
    PARSE_DATE('%Y-%m-%d',
        CONCAT(SPLIT(data_nascimento, REGEXP_EXTRACT(data_nascimento, r'\D'))[OFFSET(0)],"-",
        SPLIT(data_nascimento, REGEXP_EXTRACT(data_nascimento, r'\D'))[OFFSET(1)],"-",
        SPLIT(data_nascimento, REGEXP_EXTRACT(data_nascimento, r'\D'))[OFFSET(2)])
        )

    WHEN CAST(SPLIT(data_nascimento, REGEXP_EXTRACT(data_nascimento, r'\D'))[OFFSET(2)] AS INT64)>1900 THEN 
    PARSE_DATE('%Y-%m-%d',
    CONCAT(SPLIT(data_nascimento, REGEXP_EXTRACT(data_nascimento, r'\D'))[OFFSET(2)],"-",
        SPLIT(data_nascimento, REGEXP_EXTRACT(data_nascimento, r'\D'))[OFFSET(1)],"-",
        SPLIT(data_nascimento, REGEXP_EXTRACT(data_nascimento, r'\D'))[OFFSET(0)])
    )
    END AS data_nascimento,

    CURRENT_TIMESTAMP() AS carregado_em

    FROM
        {{ref('seed_clientes')}} 
)

SELECT *, 
    DATE_DIFF(CURRENT_DATE(), data_nascimento, YEAR) AS idade,
FROM
  aux
