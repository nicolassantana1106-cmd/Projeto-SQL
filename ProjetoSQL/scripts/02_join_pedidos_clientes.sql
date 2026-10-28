-- SCRIPT 02 | JOIN (2 tabelas): pedidos com o nome do cliente
USE ecommerce;

SELECT p.id_pedido, c.nome AS cliente, p.data_pedido, p.status
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente
ORDER BY p.data_pedido;
