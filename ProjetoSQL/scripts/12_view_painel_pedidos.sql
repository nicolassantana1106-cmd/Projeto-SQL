-- VIEW ESTRATÉGICA | painel executivo de pedidos
USE ecommerce;

CREATE OR REPLACE VIEW vw_painel_pedidos AS
SELECT p.id_pedido,
       c.nome  AS cliente,
       p.data_pedido,
       p.status AS status_pedido,
       SUM(ip.quantidade) AS qtd_itens,
       SUM(ip.quantidade * ip.preco_unitario) AS valor_total,
       fp.nome AS forma_pagamento,
       pg.status AS status_pagamento
FROM pedido p
JOIN cliente         c  ON c.id_cliente = p.id_cliente
JOIN item_pedido     ip ON ip.id_pedido = p.id_pedido
JOIN pagamento       pg ON pg.id_pedido = p.id_pedido
JOIN forma_pagamento fp ON fp.id_forma_pagamento = pg.id_forma_pagamento
GROUP BY p.id_pedido, c.nome, p.data_pedido, p.status, fp.nome, pg.status;

SELECT * FROM vw_painel_pedidos ORDER BY id_pedido;
