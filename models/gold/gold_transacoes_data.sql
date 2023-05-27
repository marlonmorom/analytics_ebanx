SELECT
  data_vencimento,
  categoria,
  status,
  COUNT(*) AS quantidade_transacoes,
  ROUND(SUM(valor_dolar),2) AS valor_total_dolar,
  ROUND(SUM(multa_dolar),2) AS valor_total_multa,
  CURRENT_TIMESTAMP() AS carregado_em
  
FROM
   {{ ref('silver_compras')}}

GROUP BY 1,2,3
ORDER BY 1