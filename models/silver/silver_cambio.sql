WITH aux AS (
  SELECT
        c.mes,
        d.mes_num,
        c.BRL,
        c.EUR,
        c.CNY,
        c.EGP,
        c.KRW,
        c.CLP,
        c.MXN,

  CURRENT_TIMESTAMP() AS carregado_em
FROM
  {{ref('seed_cambio')}} AS c
LEFT JOIN
  {{ref('de_para_data')}} AS d

ON c.mes = d.mes
)

SELECT *,
  CASE moeda
    WHEN "BRL" THEN "Real"
    WHEN "EUR" THEN "Euro"
    WHEN "CNY" THEN "Yuan"
    WHEN "EGP" THEN "Libra Egípcia"
    WHEN "KRW" THEN "Won Sul-coreano"
    WHEN "CLP" THEN "Peso Chileno"
    WHEN "MXN" THEN "Peso Mexicano"
  END AS nome_moeda
   FROM aux
UNPIVOT(valor FOR moeda IN (BRL,
EUR,
CNY,
EGP,
KRW,
CLP,
MXN))

