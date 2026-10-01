use restaurante;

-- Selecione todos os pedidos que do id funcionário igual a 4 e status é igual a ‘Pendente’
select * from pedidos where id_funcionario = '4' and status = 'Pendente';

-- Selecione todos os pedidos que o status não é igual a ‘Concluído’
SELECT * FROM pedidos WHERE status <> 'Concluído';

-- Selecione os pedidos que contenham os id produtos: 1, 3, 5, 7 ou 8
select * from pedidos where id_produto in (1,3,5,7,8);

-- Selecione os clientes que começam com a letra c
select *from clientes where nome like 'c%';

-- Selecione as informações de produtos que contenham nos ingredientes ‘carne’ ou ‘frango’
select * from info_produtos where ingredientes like 'carne%' or ingredientes like 'frango%';

-- Selecione os produtos com o preço entre 20 a 30
select * from produtos where preco between 20 and 30;

-- Atualizar id pedido 6 da tabela pedidos para status = NULL
select * from pedidos;
SET SQL_SAFE_UPDATES = 1;
update pedidos set status = null where id_pedido = 6;

-- Selecione os pedidos com status nulos
select * from pedidos where status is null;

-- Selecionar o id pedido e o status da tabela pedidos, porém para todos os status nulos, mostrar 'Cancelado'
select id_pedido,
       IFNULL(status, 'Cancelado') AS status
from pedidos;

-- Selecione o nome, cargo, salário dos funcionários e adicione um campo chamado media_salario, que irá mostrar ‘Acima da média’, para o salário > 3000, senão 'Abaixo da média'
SELECT 
    nome, 
    cargo,
    salario,
    CASE 
        WHEN salario > 3000 THEN 'Acima da Média'
        ELSE 'Abaixo da Média'
    END AS media_salario 
FROM funcionarios;
