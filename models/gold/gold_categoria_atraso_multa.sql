SELECT  
  categoria,
  ROUND(SUM(multa_dolar),2) AS valor_total_multas,
  CURRENT_TIMESTAMP() AS carregado_em
  
FROM {{ ref ('silver_compras')}}

WHERE status_vencimento = "Pago com Atraso"
GROUP BY 1
ORDER BY 2 DESC
