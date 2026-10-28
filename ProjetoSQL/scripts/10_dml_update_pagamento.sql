-- SCRIPT 10 | DML (UPDATE): cliente pagou o boleto do pedido 4
USE ecommerce;

-- Antes
SELECT p.id_pedido, p.status AS status_pedido, pg.status AS status_pagamento
FROM pedido p JOIN pagamento pg ON pg.id_pedido = p.id_pedido
WHERE p.id_pedido = 4;

UPDATE pagamento
SET status = 'Aprovado', data_pagamento = NOW()
WHERE id_pedido = 4;

UPDATE pedido
SET status = 'Pago'
WHERE id_pedido = 4;

-- Depois
SELECT p.id_pedido, p.status AS status_pedido, pg.status AS status_pagamento
FROM pedido p JOIN pagamento pg ON pg.id_pedido = p.id_pedido
WHERE p.id_pedido = 4;
