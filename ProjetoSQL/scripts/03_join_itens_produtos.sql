-- SCRIPT 03 | JOIN (4 tabelas): itens de cada pedido com cliente, produto e subtotal
USE ecommerce;

SELECT p.id_pedido,
       c.nome  AS cliente,
       pr.nome AS produto,
       ip.quantidade,
       ip.preco_unitario,
       ip.quantidade * ip.preco_unitario AS subtotal
FROM item_pedido ip
JOIN pedido  p  ON p.id_pedido   = ip.id_pedido
JOIN cliente c  ON c.id_cliente  = p.id_cliente
JOIN produto pr ON pr.id_produto = ip.id_produto
ORDER BY p.id_pedido, pr.nome;
