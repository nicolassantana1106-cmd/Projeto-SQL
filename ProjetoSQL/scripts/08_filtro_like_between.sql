-- SCRIPT 08 | FILTROS: WHERE, LIKE, BETWEEN e ORDER BY
USE ecommerce;

SELECT nome, preco, estoque
FROM produto
WHERE nome LIKE '%Livro%'
   OR preco BETWEEN 100 AND 300
ORDER BY preco DESC;
