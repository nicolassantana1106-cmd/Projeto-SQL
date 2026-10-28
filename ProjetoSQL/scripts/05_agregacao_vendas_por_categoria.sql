-- SCRIPT 05 | AGREGAÇÃO: SUM e GROUP BY - total vendido por categoria
USE ecommerce;

SELECT cat.nome AS categoria,
       SUM(ip.quantidade) AS unidades_vendidas,
       SUM(ip.quantidade * ip.preco_unitario) AS total_vendido
FROM item_pedido ip
JOIN produto   pr  ON pr.id_produto   = ip.id_produto
JOIN categoria cat ON cat.id_categoria = pr.id_categoria
GROUP BY cat.nome
ORDER BY total_vendido DESC;
