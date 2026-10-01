use restaurante;

-- Criação de View
CREATE OR REPLACE VIEW resumo_pedido AS
SELECT pe.id_pedido,
       pe.quantidade,
       pe.data_pedido,
       c.nome  AS nome_cliente,
       c.email,
       f.nome  AS nome_funcionario,
       pr.nome AS nome_produto,
       pr.preco
FROM pedidos pe
INNER JOIN clientes     c  ON c.id_cliente     = pe.id_cliente
INNER JOIN funcionarios f  ON f.id_funcionario = pe.id_funcionario
INNER JOIN produtos     pr ON pr.id_produto    = pe.id_produto;

-- Consulta com o total calculado na hora
SELECT id_pedido,
       nome_cliente,
       quantidade * preco AS total
FROM resumo_pedido;

-- Atualização da view com o campo total
CREATE OR REPLACE VIEW resumo_pedido AS
SELECT pe.id_pedido,
       pe.quantidade,
       pe.data_pedido,
       c.nome  AS nome_cliente,
       c.email,
       f.nome  AS nome_funcionario,
       pr.nome AS nome_produto,
       pr.preco,
       pe.quantidade * pr.preco AS total
FROM pedidos pe
INNER JOIN clientes     c  ON c.id_cliente     = pe.id_cliente
INNER JOIN funcionarios f  ON f.id_funcionario = pe.id_funcionario
INNER JOIN produtos     pr ON pr.id_produto    = pe.id_produto;

-- Repetir a consulta da questão 3 usando o campo total da view
SELECT id_pedido,
       nome_cliente,
       total
FROM resumo_pedido;

-- Mesma consulta com EXPLAIN
EXPLAIN
SELECT id_pedido,
       nome_cliente,
       total
FROM resumo_pedido;

-- Função BuscaIngredientesProduto: recebe o id do produto e retorna os ingredientes
DROP FUNCTION IF EXISTS BuscaIngredientesProduto;
DELIMITER $$
 
CREATE FUNCTION BuscaIngredientesProduto(p_id_produto INT)
RETURNS TEXT
READS SQL DATA
BEGIN
    DECLARE v_ingredientes TEXT;
 
    SELECT ingredientes
      INTO v_ingredientes
      FROM info_produtos
     WHERE id_produto = p_id_produto
     LIMIT 1;
 
    RETURN v_ingredientes;
END$$
 
DELIMITER ;

-- Executar a função com o id de produto 10
SELECT BuscaIngredientesProduto(10) AS ingredientes;

-- Função mediaPedido: compara o total do pedido com a média de todos os pedidos
DROP FUNCTION IF EXISTS mediaPedido;

DELIMITER $$
 
CREATE FUNCTION mediaPedido(p_id_pedido INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_media DECIMAL(12,4);
    DECLARE v_msg   VARCHAR(100);
 
    -- total do pedido informado
    SELECT total
      INTO v_total
      FROM resumo_pedido
     WHERE id_pedido = p_id_pedido;
 
    -- média do total de todos os pedidos
    SELECT AVG(total)
      INTO v_media
      FROM resumo_pedido;
 
    IF v_total IS NULL THEN
        SET v_msg = 'Pedido não encontrado';
    ELSEIF v_total > v_media THEN
        SET v_msg = 'O total do pedido está acima da média de todos os pedidos';
    ELSEIF v_total < v_media THEN
        SET v_msg = 'O total do pedido está abaixo da média de todos os pedidos';
    ELSE
        SET v_msg = 'O total do pedido é igual à média de todos os pedidos';
    END IF;
 
    RETURN v_msg;
END$$
 
DELIMITER ;

-- Executar a função mediaPedido com os pedidos 5 e 6
SELECT mediaPedido(5) AS resultado_pedido_5;
SELECT mediaPedido(6) AS resultado_pedido_6;

SHOW CREATE FUNCTION mediaPedido;
SELECT id_pedido, total FROM resumo_pedido WHERE id_pedido IN (5, 6);
SELECT AVG(total) AS media_geral FROM resumo_pedido;





