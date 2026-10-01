use restaurante;

select nome, categoria from produtos where preco > 30;

select nome, telefone, data_nascimento from clientes where year (data_nascimento) < 1985;

select id_produto, ingredientes from info_produtos where ingredientes like '%carne%';

select nome, categoria from produtos order by categoria asc, nome desc; 

select preco, nome from produtos order by preco desc limit 5;

select * from produtos where categoria ='prato principal' limit 2 offset 5;

CREATE TABLE backup_pedidos LIKE pedidos;

INSERT INTO backup_pedidos SELECT * FROM pedidos;

