-- Banco de Dados: restaurante
CREATE DATABASE IF NOT EXISTS restaurante;
USE restaurante;

-- Tabela: funcionarios

CREATE TABLE IF NOT EXISTS funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(100),
    cargo VARCHAR(100),
    salario DECIMAL(10,2),
    data_admissao DATE
);

-- Tabela: clientes

CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(100),
    data_cadastro DATE
);

-- Tabela: produtos

CREATE TABLE IF NOT EXISTS produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(100)
);

-- Tabela: pedidos

CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_funcionario INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    data_pedido DATE,
    status VARCHAR(50),
    CONSTRAINT fk_pedidos_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_pedidos_funcionario
        FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_pedidos_produto
        FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- Tabela: info_produtos

CREATE TABLE IF NOT EXISTS info_produtos (
    id_info INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT,
    ingredientes TEXT,
    fornecedor VARCHAR(255),
    CONSTRAINT fk_info_produto
        FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
        ON UPDATE CASCADE ON DELETE CASCADE
);