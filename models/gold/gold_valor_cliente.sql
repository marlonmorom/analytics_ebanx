SELECT  
  cl.nome,
  cl.pais,
  cl.idade,
  ROUND(SUM(co.valor_dolar),2) AS soma_total,
  CURRENT_TIMESTAMP() AS carregado_em

FROM {{ref('silver_compras')}} AS co
LEFT JOIN {{ref('silver_clientes')}} AS cl
ON co.id_cliente = cl.id

GROUP BY 1,2,3
ORDER BY 4 DESC
