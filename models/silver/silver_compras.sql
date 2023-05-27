{% set valor_multa = 0.25 %}

SELECT
    id,
    id_cliente,
    data_vencimento,
    CASE WHEN data_pagamento != "NULL"
    THEN DATE(data_pagamento) 
    ELSE NULL
    END AS data_pagamento,
    categoria,
    status,
    co.valor,
    co.moeda,
    COALESCE(ca.valor,1) AS cotacao,
    ROUND(co.valor*COALESCE(ca.valor,1),2) AS valor_dolar,
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
  {{ref('seed_compras')}} AS co

LEFT JOIN {{ref('silver_cambio')}} AS ca

ON EXTRACT(MONTH from co.data_vencimento) = ca.mes_num
AND co.moeda = ca.moeda