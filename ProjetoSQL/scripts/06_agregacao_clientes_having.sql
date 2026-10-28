-- SCRIPT 06 | AGREGAÇÃO: COUNT, SUM, GROUP BY e HAVING - clientes que gastaram mais de R$ 500
USE ecommerce;

SELECT c.nome AS cliente,
       COUNT(DISTINCT p.id_pedido) AS qtd_pedidos,
       SUM(ip.quantidade * ip.preco_unitario) AS total_gasto
FROM cliente c
JOIN pedido      p  ON p.id_cliente = c.id_cliente
JOIN item_pedido ip ON ip.id_pedido = p.id_pedido
GROUP BY c.id_cliente, c.nome
HAVING SUM(ip.quantidade * ip.preco_unitario) > 500
ORDER BY total_gasto DESC;
