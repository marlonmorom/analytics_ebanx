{% set valor_multa = 0.25 %}

WITH aux AS (

SELECT
    id,
    id_cliente,
    data_vencimento,
    IF(data_pagamento != "NULL", DATE(data_pagamento), NULL) AS data_pagamento,
    categoria,
    status,
    valor,
    moeda,
    CASE 
      WHEN status = "Pago" AND data_vencimento>=DATE(data_pagamento)
        THEN "Pago sem Atraso"
      WHEN status = "Pago" AND data_vencimento<DATE(data_pagamento)
        THEN "Pago com Atraso"
      WHEN status = "Pendente" AND data_vencimento<CURRENT_DATE()
        THEN "Parcialmente Vencido"
      WHEN status = "Pendente" AND data_vencimento>=CURRENT_DATE()
        THEN "Não Vencido"

    END
    AS status_vencimento,

    CASE 
      WHEN status = "Pago"
        THEN DATE_DIFF(DATE(data_pagamento), data_vencimento, DAY) 
      WHEN status = "Pendente"
        THEN DATE_DIFF(current_date(), data_vencimento, DAY) 
        END AS dias_atraso,

    IF(status = "Pago" AND DATE_DIFF(DATE(data_pagamento), data_vencimento, DAY)>0 , {{valor_multa}}*DATE_DIFF(DATE(data_pagamento), data_vencimento, DAY) , 0) AS multa_dolar,
   FROM
  {{ref('seed_compras')}}
)
    
SELECT 
    a.*,
    COALESCE(ca.valor,1) AS cotacao,
    ROUND(a.valor*COALESCE(ca.valor,1),2) AS valor_dolar,
FROM
  aux AS a

LEFT JOIN {{ref('silver_cambio')}} AS ca

ON EXTRACT(MONTH FROM COALESCE(a.data_pagamento,a.data_vencimento)) = ca.mes_num
AND a.moeda = ca.moeda
