CREATE SCHEMA EST_CASO_V;

USE EST_CASO_V;

-- TABELA DE CLIENTES
CREATE TABLE IF NOT EXISTS CLIENTES (
    CLI_CPF VARCHAR(14) PRIMARY KEY,
    CLI_NOME VARCHAR(100) NOT NULL,
    CLI_RUA VARCHAR(50),
    CLI_NUMRUA VARCHAR(25) NOT NULL,
    CLI_BAIRRO VARCHAR(50) NOT NULL,
    CLI_CIDADE VARCHAR(50) NOT NULL,
    CLI_UF CHAR(2) NOT NULL,
    CLI_PAIS VARCHAR(100) NOT NULL,
    CLI_CEP VARCHAR(15) NOT NULL,
    CLI_STATUS_PROMO ENUM('APROVADO', 'REPROVADO') NOT NULL
);

-- TABELA DE FORNECEDORES
CREATE TABLE IF NOT EXISTS FORNECEDORES (
    FORN_CNPJ VARCHAR(14) PRIMARY KEY,
    FORN_NOME VARCHAR(100) NOT NULL,
    FORN_TELEFONE VARCHAR(16) NOT NULL,
    FORN_EMAIL VARCHAR(50) NOT NULL
);

-- TABELA DE PRODUTOS
CREATE TABLE IF NOT EXISTS PRODUTOS (
    PROD_ID INT PRIMARY KEY,
    PROD_CATEGORIA VARCHAR(50) NOT NULL,
    PROD_QTDDISPONIVEL INT NOT NULL,
    PROD_PRECO DECIMAL(10, 3) NOT NULL
);

-- TABELA ASSOCIATIVA ENTRE PRODUTOS E FORNECEDORES
CREATE TABLE IF NOT EXISTS PRODUTOS_FORNECEDORES (
    PROD_ID INT,
    FORN_CNPJ VARCHAR(14),
    PRIMARY KEY (PROD_ID, FORN_CNPJ),
    CONSTRAINT PRFO_FK_PRODUTOS FOREIGN KEY (PROD_ID) REFERENCES PRODUTOS(PROD_ID),
    CONSTRAINT PRFO_FK_FORNECEDORES FOREIGN KEY (FORN_CNPJ) REFERENCES FORNECEDORES(FORN_CNPJ)
);

-- TABELA DE PAGAMENTOS
CREATE TABLE IF NOT EXISTS PAGAMENTOS (
    PAG_ID INT PRIMARY KEY,
    PAG_DATA DATE NOT NULL,
    PAG_HORA TIME NOT NULL,
    PAG_VALOR DECIMAL(10, 3) NOT NULL,
    PAG_STATUS ENUM('PENDENTE', 'PAGO', 'CANCELADO') NOT NULL
);

-- TABELA DE VENDAS
CREATE TABLE IF NOT EXISTS VENDAS (
    VENDA_ID INT PRIMARY KEY,
    CLI_CPF VARCHAR(14) NOT NULL,
    PAG_ID INT NOT NULL,
    CONSTRAINT VENDA_FK_CLIENTES FOREIGN KEY (CLI_CPF) REFERENCES CLIENTES(CLI_CPF),
    CONSTRAINT VENDA_FK_PAGAMENTOS FOREIGN KEY (PAG_ID) REFERENCES PAGAMENTOS(PAG_ID)
);

-- TABELA ASSOCIATIVA ENTRE VENDAS E PRODUTOS
CREATE TABLE IF NOT EXISTS VENDAS_PRODUTOS (
    VENDA_ID INT,
    PROD_ID INT,
    PRIMARY KEY (VENDA_ID, PROD_ID),
    VEPRO_QTD_VENDIDA INT NOT NULL,
    VEPRO_VALORTOTAL DECIMAL(10, 3) NOT NULL,
    CONSTRAINT VEPRO_FK_PRODUTOS FOREIGN KEY (PROD_ID) REFERENCES PRODUTOS(PROD_ID),
    CONSTRAINT VEPRO_FK_VENDAS FOREIGN KEY (VENDA_ID) REFERENCES VENDAS(VENDA_ID)
);

#DML'S-------------------------------------------------------------------------------------------------

-- INSERINDO DADOS NA TABELA CLIENTES
INSERT INTO CLIENTES (CLI_CPF, CLI_NOME, CLI_RUA, CLI_NUMRUA, CLI_BAIRRO, CLI_CIDADE, CLI_UF, CLI_PAIS, CLI_CEP, CLI_STATUS_PROMO) VALUES
('12345678901', 'João Silva', 'Rua A', '123', 'Bairro 1', 'Cidade X', 'SP', 'Brasil', '12345-678', 'APROVADO'),
('23456789012', 'Maria Oliveira', 'Rua B', '456', 'Bairro 2', 'Cidade Y', 'RJ', 'Brasil', '23456-789', 'REPROVADO');
UPDATE CLIENTES SET CLI_NOME = 'João da Silva' WHERE CLI_CPF = '12345678901';
UPDATE CLIENTES SET CLI_STATUS_PROMO = 'APROVADO' WHERE CLI_CPF = '23456789012';

-- INSERINDO DADOS NA TABELA FORNECEDORES
INSERT INTO FORNECEDORES (FORN_CNPJ, FORN_NOME, FORN_TELEFONE, FORN_EMAIL) VALUES
('12345678000195', 'Fornecedor A', '11987654321', 'fornecedorA@email.com'),
('23456789000196', 'Fornecedor B', '21987654321', 'fornecedorB@email.com');
UPDATE FORNECEDORES SET FORN_NOME = 'Fornecedor A Atualizado' WHERE FORN_CNPJ = '12345678000195';
UPDATE FORNECEDORES SET FORN_TELEFONE = '21987654321' WHERE FORN_CNPJ = '23456789000196';

-- INSERINDO DADOS NA TABELA PRODUTOS
INSERT INTO PRODUTOS (PROD_ID, PROD_CATEGORIA, PROD_QTDDISPONIVEL, PROD_PRECO) VALUES
(1, 'Eletrônicos', 100, 1999.99),
(2, 'Móveis', 50, 899.99);
UPDATE PRODUTOS SET PROD_PRECO = 1799.99 WHERE PROD_ID = 1;
UPDATE PRODUTOS SET PROD_QTDDISPONIVEL = 45 WHERE PROD_ID = 2;

-- INSERINDO DADOS NA TABELA PRODUTOS_FORNECEDORES
INSERT INTO PRODUTOS_FORNECEDORES (PROD_ID, FORN_CNPJ) VALUES
(1, '12345678000195'),
(2, '23456789000196');
UPDATE PRODUTOS_FORNECEDORES SET FORN_CNPJ = '23456789000196' WHERE PROD_ID = 1;

-- INSERINDO DADOS NA TABELA PAGAMENTOS
INSERT INTO PAGAMENTOS (PAG_ID, PAG_DATA, PAG_HORA, PAG_VALOR, PAG_STATUS) VALUES
(1, '2024-10-01', '14:30:00', 1999.99, 'PAGO'),
(2, '2024-10-02', '15:00:00', 899.99, 'PENDENTE');
UPDATE PAGAMENTOS SET PAG_STATUS = 'CANCELADO' WHERE PAG_ID = 2;

-- INSERINDO DADOS NA TABELA VENDAS
INSERT INTO VENDAS (VENDA_ID, CLI_CPF, PAG_ID) VALUES
(1, '12345678901', 1),
(2, '23456789012', 2);
UPDATE VENDAS SET PAG_ID = 2 WHERE VENDA_ID = 1;

-- INSERINDO DADOS NA TABELA VENDAS_PRODUTOS
INSERT INTO VENDAS_PRODUTOS (VENDA_ID, PROD_ID, VEPRO_QTD_VENDIDA, VEPRO_VALORTOTAL) VALUES
(1, 1, 1, 1999.99),
(2, 2, 1, 899.99);
UPDATE VENDAS_PRODUTOS SET VEPRO_QTD_VENDIDA = 2 WHERE VENDA_ID = 1;