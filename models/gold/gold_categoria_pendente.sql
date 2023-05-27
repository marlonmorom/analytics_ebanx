SELECT  
  categoria,
  ROUND(SUM(valor_dolar),2) AS valor_total_dolar,
  CURRENT_TIMESTAMP() AS carregado_em
  
FROM {{ref('silver_compras')}}

WHERE status = "Pendente"
GROUP BY 1
ORDER BY 2 DESC
