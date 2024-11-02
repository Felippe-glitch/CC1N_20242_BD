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

-------------------------------------------------------------------------------DDL'S----------------------------------------------------------------------------------

-- TABELA CLIENTES
ALTER TABLE CLIENTES ADD COLUMN CLI_TELEFONE VARCHAR(16);
ALTER TABLE CLIENTES MODIFY COLUMN CLI_NUMRUA VARCHAR(30);
DROP TABLE IF EXISTS CLIENTES;
RENAME TABLE CLIENTES TO CLIENTES_ANTIGOS;

-- TABELA FORNECEDORES
ALTER TABLE FORNECEDORES ADD COLUMN FORN_ENDERECO VARCHAR(100);
ALTER TABLE FORNECEDORES MODIFY COLUMN FORN_TELEFONE VARCHAR(20);
DROP TABLE IF EXISTS FORNECEDORES;
RENAME TABLE FORNECEDORES TO FORNECEDORES_ANTIGOS;

-- TABELA PRODUTOS
ALTER TABLE PRODUTOS ADD COLUMN PROD_DESCRICAO TEXT;
ALTER TABLE PRODUTOS MODIFY COLUMN PROD_QTDDISPONIVEL INT DEFAULT 0;
DROP TABLE IF EXISTS PRODUTOS;
RENAME TABLE PRODUTOS TO PRODUTOS_ANTIGOS;

-- TABELA PAGAMENTOS
ALTER TABLE PAGAMENTOS ADD COLUMN PAG_METODO_PAGAMENTO VARCHAR(20);
ALTER TABLE PAGAMENTOS MODIFY COLUMN PAG_STATUS ENUM('PENDENTE', 'PAGO', 'CANCELADO', 'ESTORNADO');
DROP TABLE IF EXISTS PAGAMENTOS;
RENAME TABLE PAGAMENTOS TO HISTORICO_PAGAMENTOS;

-- TABELA VENDAS
ALTER TABLE VENDAS ADD COLUMN VENDA_DATA DATE NOT NULL;
ALTER TABLE VENDAS MODIFY COLUMN CLI_CPF VARCHAR(11);
DROP TABLE IF EXISTS VENDAS;
RENAME TABLE VENDAS TO VENDAS_ANTIGAS;

-- TABELA VENDAS_PRODUTOS
ALTER TABLE VENDAS_PRODUTOS ADD COLUMN VEPRO_DESCONTO DECIMAL(10, 3) DEFAULT 0;
ALTER TABLE VENDAS_PRODUTOS MODIFY COLUMN VEPRO_QTD_VENDIDA INT NOT NULL CHECK (VEPRO_QTD_VENDIDA > 0);
DROP TABLE IF EXISTS VENDAS_PRODUTOS;
RENAME TABLE VENDAS_PRODUTOS TO VENDAS_PRODUTOS_ANTIGOS;


