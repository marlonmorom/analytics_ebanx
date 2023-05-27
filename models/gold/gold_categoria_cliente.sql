SELECT  
  cl.nome,
  STRING_AGG(DISTINCT categoria,", " ORDER BY categoria ASC) AS lista_categoria,
  CURRENT_TIMESTAMP() AS carregado_em

FROM {{ref('silver_compras')}} AS co
LEFT JOIN {{ref('silver_clientes')}} AS cl
ON co.id_cliente = cl.id

GROUP BY 1
ORDER BY 1
