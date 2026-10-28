-- SCRIPT 09 | FILTROS: pedidos de setembro/2026 já pagos ou entregues
USE ecommerce;

SELECT p.id_pedido, c.nome AS cliente, p.data_pedido, p.status
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente
WHERE p.data_pedido BETWEEN '2026-09-01 00:00:00' AND '2026-09-30 23:59:59'
  AND p.status IN ('Entregue', 'Pago')
ORDER BY p.data_pedido DESC;
