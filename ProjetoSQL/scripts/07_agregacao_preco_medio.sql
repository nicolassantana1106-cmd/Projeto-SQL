-- SCRIPT 07 | AGREGAÇÃO: COUNT, AVG, MIN, MAX - resumo de preços por categoria
USE ecommerce;

SELECT cat.nome AS categoria,
       COUNT(*)                AS qtd_produtos,
       ROUND(AVG(pr.preco), 2) AS preco_medio,
       MIN(pr.preco)           AS menor_preco,
       MAX(pr.preco)           AS maior_preco
FROM produto pr
JOIN categoria cat ON cat.id_categoria = pr.id_categoria
GROUP BY cat.nome
ORDER BY preco_medio DESC;
