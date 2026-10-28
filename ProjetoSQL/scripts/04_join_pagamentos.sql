-- SCRIPT 04 | JOIN (4 tabelas): pagamentos com cliente e forma de pagamento
USE ecommerce;

SELECT p.id_pedido,
       c.nome  AS cliente,
       fp.nome AS forma_pagamento,
       pg.valor,
       pg.status AS status_pagamento,
       pg.data_pagamento
FROM pagamento pg
JOIN pedido          p  ON p.id_pedido = pg.id_pedido
JOIN cliente         c  ON c.id_cliente = p.id_cliente
JOIN forma_pagamento fp ON fp.id_forma_pagamento = pg.id_forma_pagamento
ORDER BY p.id_pedido;
