-- SCRIPT 11 | DML (desativação lógica): em vez de apagar o cliente, marca como inativo
USE ecommerce;

-- Antes
SELECT id_cliente, nome, ativo FROM cliente WHERE id_cliente = 6;

UPDATE cliente
SET ativo = 0
WHERE id_cliente = 6;

-- Depois
SELECT id_cliente, nome, ativo FROM cliente WHERE id_cliente = 6;
