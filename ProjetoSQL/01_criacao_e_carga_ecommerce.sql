-- =====================================================
-- PROJETO INTEGRADOR - E-COMMERCE & MARKETPLACE (MySQL)
-- Script 01: criação do banco, tabelas e carga inicial
-- =====================================================

DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce;

-- ---------- TABELAS ----------

CREATE TABLE cliente (
  id_cliente     INT AUTO_INCREMENT PRIMARY KEY,
  nome           VARCHAR(100) NOT NULL,
  email          VARCHAR(100) NOT NULL UNIQUE,
  cpf            CHAR(11)     NOT NULL UNIQUE,
  telefone       VARCHAR(20),
  data_cadastro  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ativo          TINYINT(1)   NOT NULL DEFAULT 1
);

CREATE TABLE endereco_entrega (
  id_endereco  INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente   INT          NOT NULL,
  logradouro   VARCHAR(120) NOT NULL,
  numero       VARCHAR(10)  NOT NULL,
  bairro       VARCHAR(60)  NOT NULL,
  cidade       VARCHAR(60)  NOT NULL,
  uf           CHAR(2)      NOT NULL,
  cep          CHAR(8)      NOT NULL,
  CONSTRAINT fk_endereco_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE categoria (
  id_categoria  INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(50)  NOT NULL UNIQUE,
  descricao     VARCHAR(150)
);

CREATE TABLE produto (
  id_produto    INT AUTO_INCREMENT PRIMARY KEY,
  id_categoria  INT           NOT NULL,
  nome          VARCHAR(100)  NOT NULL,
  descricao     VARCHAR(255),
  preco         DECIMAL(10,2) NOT NULL CHECK (preco > 0),
  estoque       INT           NOT NULL DEFAULT 0 CHECK (estoque >= 0),
  ativo         TINYINT(1)    NOT NULL DEFAULT 1,
  CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE forma_pagamento (
  id_forma_pagamento  INT AUTO_INCREMENT PRIMARY KEY,
  nome                VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE pedido (
  id_pedido    INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente   INT         NOT NULL,
  id_endereco  INT         NOT NULL,
  data_pedido  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status       VARCHAR(25) NOT NULL DEFAULT 'Aguardando Pagamento',
  CONSTRAINT fk_pedido_cliente  FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente),
  CONSTRAINT fk_pedido_endereco FOREIGN KEY (id_endereco) REFERENCES endereco_entrega(id_endereco)
);

CREATE TABLE item_pedido (
  id_item        INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido      INT           NOT NULL,
  id_produto     INT           NOT NULL,
  quantidade     INT           NOT NULL CHECK (quantidade > 0),
  preco_unitario DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_item_pedido  FOREIGN KEY (id_pedido)  REFERENCES pedido(id_pedido),
  CONSTRAINT fk_item_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE pagamento (
  id_pagamento        INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido           INT           NOT NULL UNIQUE,
  id_forma_pagamento  INT           NOT NULL,
  valor               DECIMAL(10,2) NOT NULL,
  data_pagamento      DATETIME,
  status              VARCHAR(20)   NOT NULL DEFAULT 'Pendente',
  CONSTRAINT fk_pag_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  CONSTRAINT fk_pag_forma  FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id_forma_pagamento)
);

-- ---------- CARGA INICIAL ----------

INSERT INTO cliente (nome, email, cpf, telefone, data_cadastro) VALUES
('Ana Souza',      'ana.souza@email.com',      '11111111111', '11988880001', '2026-08-01 10:00:00'),
('Bruno Lima',     'bruno.lima@email.com',     '22222222222', '11988880002', '2026-08-05 14:30:00'),
('Carla Mendes',   'carla.mendes@email.com',   '33333333333', '11988880003', '2026-08-10 09:15:00'),
('Diego Alves',    'diego.alves@email.com',    '44444444444', '11988880004', '2026-08-20 16:45:00'),
('Elisa Ramos',    'elisa.ramos@email.com',    '55555555555', '11988880005', '2026-09-01 11:20:00'),
('Felipe Costa',   'felipe.costa@email.com',   '66666666666', '11988880006', '2026-09-15 19:00:00');

INSERT INTO endereco_entrega (id_cliente, logradouro, numero, bairro, cidade, uf, cep) VALUES
(1, 'Rua das Flores',      '100', 'Centro',        'São Paulo',               'SP', '01001000'),
(2, 'Av. Brasil',          '250', 'Jardim Paulista','São Paulo',              'SP', '01430000'),
(3, 'Rua Sete de Setembro','45',  'Centro',        'Ferraz de Vasconcelos',   'SP', '08500000'),
(4, 'Rua das Palmeiras',   '78',  'Vila Nova',     'Guarulhos',               'SP', '07000000'),
(5, 'Av. Paulista',        '900', 'Bela Vista',    'São Paulo',               'SP', '01310000'),
(6, 'Rua XV de Novembro',  '12',  'Centro',        'Mogi das Cruzes',         'SP', '08710000');

INSERT INTO categoria (nome, descricao) VALUES
('Eletrônicos', 'Computadores, celulares e acessórios'),
('Moda',        'Roupas e calçados'),
('Casa',        'Utilidades e eletrodomésticos'),
('Livros',      'Livros técnicos e didáticos');

INSERT INTO produto (id_categoria, nome, descricao, preco, estoque) VALUES
(1, 'Notebook Gamer',        'Notebook 16GB RAM, SSD 512GB', 4500.00, 10),
(1, 'Smartphone X',          'Tela 6.5 polegadas, 128GB',    2200.00, 25),
(1, 'Fone Bluetooth',        'Fone sem fio com microfone',    250.00, 50),
(2, 'Camiseta Básica',       'Algodão, várias cores',          49.90, 100),
(2, 'Calça Jeans',           'Corte reto',                    119.90, 60),
(2, 'Tênis Esportivo',       'Para corrida e academia',       299.90, 40),
(3, 'Cafeteira Elétrica',    '30 xícaras, filtro permanente', 189.90, 30),
(3, 'Liquidificador',        '900W, 2 velocidades',           159.90, 20),
(4, 'Livro SQL na Prática',  'Introdução a bancos de dados',   79.90, 80),
(4, 'Livro Modelagem de Dados','DER e normalização',           89.90, 70);

INSERT INTO forma_pagamento (nome) VALUES
('Cartão de Crédito'), ('Pix'), ('Boleto'), ('Cartão de Débito');

INSERT INTO pedido (id_cliente, id_endereco, data_pedido, status) VALUES
(1, 1, '2026-09-02 10:15:00', 'Entregue'),
(2, 2, '2026-09-05 15:40:00', 'Entregue'),
(3, 3, '2026-09-10 12:00:00', 'Entregue'),
(1, 1, '2026-09-18 09:30:00', 'Aguardando Pagamento'),
(4, 4, '2026-09-25 20:10:00', 'Pago'),
(5, 5, '2026-10-03 13:25:00', 'Entregue'),
(2, 2, '2026-10-08 17:50:00', 'Pago'),
(6, 6, '2026-10-12 08:05:00', 'Cancelado');

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 3, 1,  250.00),
(1, 4, 2,   49.90),
(2, 2, 1, 2200.00),
(3, 6, 1,  299.90),
(3, 5, 1,  119.90),
(4, 9, 1,   79.90),
(4, 10, 1,  89.90),
(5, 1, 1, 4500.00),
(6, 7, 1,  189.90),
(6, 8, 1,  159.90),
(7, 3, 2,  250.00),
(7, 9, 1,   79.90),
(8, 4, 3,   49.90);

INSERT INTO pagamento (id_pedido, id_forma_pagamento, valor, data_pagamento, status) VALUES
(1, 2,  349.80, '2026-09-02 10:20:00', 'Aprovado'),
(2, 1, 2200.00, '2026-09-05 15:45:00', 'Aprovado'),
(3, 2,  419.80, '2026-09-10 12:05:00', 'Aprovado'),
(4, 3,  169.80, NULL,                  'Pendente'),
(5, 1, 4500.00, '2026-09-25 20:15:00', 'Aprovado'),
(6, 4,  349.80, '2026-10-03 13:30:00', 'Aprovado'),
(7, 2,  579.90, '2026-10-08 17:55:00', 'Aprovado'),
(8, 1,  149.70, NULL,                  'Recusado');

-- Conferência rápida (opcional)
SELECT 'cliente' AS tabela, COUNT(*) AS linhas FROM cliente
UNION ALL SELECT 'endereco_entrega', COUNT(*) FROM endereco_entrega
UNION ALL SELECT 'categoria', COUNT(*) FROM categoria
UNION ALL SELECT 'produto', COUNT(*) FROM produto
UNION ALL SELECT 'forma_pagamento', COUNT(*) FROM forma_pagamento
UNION ALL SELECT 'pedido', COUNT(*) FROM pedido
UNION ALL SELECT 'item_pedido', COUNT(*) FROM item_pedido
UNION ALL SELECT 'pagamento', COUNT(*) FROM pagamento;
