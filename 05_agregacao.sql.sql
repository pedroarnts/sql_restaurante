use restaurante;

-- Calcule a quantidade de pedidos = 50
SELECT COUNT(*) AS quantidade_pedidos
FROM pedidos;

-- Calcule a quantidade de clientes únicos que realizaram pedidos = 24
SELECT COUNT(DISTINCT id_cliente) AS clientes_unicos
FROM pedidos;

-- Calcule a média de preço dos produtos = 23.12
SELECT ROUND(AVG(preco), 2) AS media_preco
FROM produtos;

-- Calcule o mínimo e máximo do preço dos produtos = MAX: 45 | MIN:5
SELECT MIN(preco) AS preco_minimo,
       MAX(preco) AS preco_maximo
FROM produtos;

-- Selecione o nome e o preço do produto e faça um rank dos 5 produtos mais caros
SELECT nome,
       preco,
       RANK() OVER (ORDER BY preco DESC) AS rank_preco
FROM produtos
ORDER BY preco DESC
LIMIT 5;

-- Selecione a média dos preços dos produtos agrupados por categoria
SELECT categoria, 
       ROUND(AVG(preco), 2) AS media_preco
FROM produtos
GROUP BY categoria;

-- Selecionar o fornecedor e a quantidade de produtos daquele fornecedor
SELECT fornecedor, 
       COUNT(*) AS quantidade_produtos
FROM info_produtos
GROUP BY fornecedor
ORDER BY quantidade_produtos DESC;

-- Selecionar os fornecedores que possuem mais de um produto cadastrado
SELECT fornecedor,
       COUNT(*) AS quantidade_produtos
FROM info_produtos
GROUP BY fornecedor
HAVING COUNT(*) > 1
ORDER BY quantidade_produtos DESC;

-- Selecionar os clientes que realizaram apenas 1 pedido
SELECT id_cliente, 
       COUNT(*) AS quantidade_pedidos
FROM pedidos
GROUP BY id_cliente
HAVING COUNT(*) = 1;


