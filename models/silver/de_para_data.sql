{{ config(materialized='ephemeral') }}


SELECT 
"Janeiro" AS mes,
1 AS mes_num

UNION ALL

SELECT
"Fevereiro" AS mes,
2 AS mes_num

UNION ALL

SELECT
"Março" AS mes,
3 AS mes_num

UNION ALL

SELECT
"Abril" AS mes,
4 AS mes_num

UNION ALL

SELECT
"Maio" AS mes,
5 AS mes_num

UNION ALL

SELECT
"Junho" AS mes,
6 AS mes_num

UNION ALL

SELECT
"Julho" AS mes,
7 AS mes_num

UNION ALL

SELECT
"Agosto" AS mes,
8 AS mes_num

UNION ALL

SELECT
"Setembro" AS mes,
9 AS mes_num

UNION ALL

SELECT
"Outubro" AS mes,
10 AS mes_num

UNION ALL

SELECT
"Novembro" AS mes,
11 AS mes_num

UNION ALL

SELECT
"Dezembro" AS mes,
12 AS mes_num
