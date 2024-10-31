CREATE SCHEMA EST_CASO_V;
USE EST_CASO_V;

-- Tabela de Clientes
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

-- Tabela de Fornecedores
CREATE TABLE IF NOT EXISTS FORNECEDORES (
    FORN_CNPJ VARCHAR(14) PRIMARY KEY, -- Modificado para 14 caracteres
    FORN_NOME VARCHAR(100) NOT NULL,
    FORN_TELEFONE VARCHAR(16) NOT NULL,
    FORN_EMAIL VARCHAR(50) NOT NULL
);

-- Tabela de Produtos
CREATE TABLE IF NOT EXISTS PRODUTOS (
    PROD_ID INT PRIMARY KEY,
    PROD_CATEGORIA VARCHAR(50) NOT NULL,
    PROD_QTDDISPONIVEL INT NOT NULL,
    PROD_PRECO DECIMAL(10, 3) NOT NULL
);

-- Tabela Associativa entre Produtos e Fornecedores
CREATE TABLE IF NOT EXISTS PRODUTOS_FORNECEDORES (
    PROD_ID INT,
    FORN_CNPJ VARCHAR(14),
    PRIMARY KEY (PROD_ID, FORN_CNPJ),
    CONSTRAINT PRFO_FK_PRODUTOS FOREIGN KEY (PROD_ID) REFERENCES PRODUTOS(PROD_ID),
    CONSTRAINT PRFO_FK_FORNECEDORES FOREIGN KEY (FORN_CNPJ) REFERENCES FORNECEDORES(FORN_CNPJ)
);

-- Tabela de Pagamentos
CREATE TABLE IF NOT EXISTS PAGAMENTOS (
    PAG_ID INT PRIMARY KEY,
    PAG_DATA DATE NOT NULL,
    PAG_HORA TIME NOT NULL,
    PAG_VALOR DECIMAL(10, 3) NOT NULL,
    PAG_STATUS ENUM('PENDENTE', 'PAGO', 'CANCELADO') NOT NULL
);

-- Tabela de Vendas
CREATE TABLE IF NOT EXISTS VENDAS (
    VENDA_ID INT PRIMARY KEY,
    CLI_CPF VARCHAR(14) NOT NULL,
    PAG_ID INT NOT NULL,
    CONSTRAINT VENDA_FK_CLIENTES FOREIGN KEY (CLI_CPF) REFERENCES CLIENTES(CLI_CPF),
    CONSTRAINT VENDA_FK_PAGAMENTOS FOREIGN KEY (PAG_ID) REFERENCES PAGAMENTOS(PAG_ID)
);

-- Tabela Associativa entre Vendas e Produtos
CREATE TABLE IF NOT EXISTS VENDAS_PRODUTOS (
    VENDA_ID INT,
    PROD_ID INT,
    PRIMARY KEY (VENDA_ID, PROD_ID),
    VEPRO_QTD_VENDIDA INT NOT NULL,
    VEPRO_VALORTOTAL DECIMAL(10, 3) NOT NULL,
    CONSTRAINT VEPRO_FK_PRODUTOS FOREIGN KEY (PROD_ID) REFERENCES PRODUTOS(PROD_ID),
    CONSTRAINT VEPRO_FK_VENDAS FOREIGN KEY (VENDA_ID) REFERENCES VENDAS(VENDA_ID)
);

-- DDL's para a Tabela CLIENTES
ALTER TABLE CLIENTES ADD COLUMN CLI_DATA_NASCIMENTO DATE COMMENT 'DATA DE NASCIMENTO DO CLIENTE';
ALTER TABLE CLIENTES CHANGE CLI_NUMRUA CLI_NUMRUA VARCHAR(25) NOT NULL COMMENT 'NÚMERO DA RUA';
ALTER TABLE CLIENTES MODIFY CLI_CEP CLI_CEP VARCHAR(15) NOT NULL COMMENT 'CÓDIGO POSTAL DO CLIENTE';
ALTER TABLE CLIENTES DROP COLUMN CLI_DATA_NASCIMENTO COMMENT 'REMOVE A COLUNA DATA DE NASCIMENTO DO CLIENTE';

-- DDL's para a Tabela FORNECEDORES
ALTER TABLE FORNECEDORES ADD COLUMN FORN_ENDERECO VARCHAR(100) COMMENT 'ENDEREÇO DO FORNECEDOR';
ALTER TABLE FORNECEDORES CHANGE FORN_TELEFONE FORN_TELEFONE VARCHAR(16) NOT NULL COMMENT 'NÚMERO DE TELEFONE DO FORNECEDOR';
ALTER TABLE FORNECEDORES MODIFY FORN_EMAIL FORN_EMAIL VARCHAR(50) NOT NULL COMMENT 'E-MAIL DO FORNECEDOR';
ALTER TABLE FORNECEDORES DROP COLUMN FORN_ENDERECO COMMENT 'REMOVE A COLUNA ENDEREÇO DO FORNECEDOR';

-- DDL's para a Tabela PRODUTOS
ALTER TABLE PRODUTOS ADD COLUMN PROD_DESCRICAO TEXT COMMENT 'DESCRIÇÃO DO PRODUTO';
ALTER TABLE PRODUTOS CHANGE PROD_CATEGORIA PROD_CATEGORIA VARCHAR(50) NOT NULL COMMENT 'CATEGORIA DO PRODUTO';
ALTER TABLE PRODUTOS MODIFY PROD_QTDDISPONIVEL PROD_QTDDISPONIVEL INT NOT NULL COMMENT 'QUANTIDADE DISPONÍVEL DO PRODUTO';
ALTER TABLE PRODUTOS DROP COLUMN PROD_DESCRICAO COMMENT 'REMOVE A COLUNA DESCRIÇÃO DO PRODUTO';

-- DDL's para a Tabela PAGAMENTOS
ALTER TABLE PAGAMENTOS ADD COLUMN PAG_METODO ENUM('CARTÃO', 'DINHEIRO', 'TRANSFERÊNCIA') COMMENT 'MÉTODO DE PAGAMENTO';
ALTER TABLE PAGAMENTOS CHANGE PAG_VALOR PAG_VALOR DECIMAL(10,3) NOT NULL COMMENT 'VALOR DO PAGAMENTO';
ALTER TABLE PAGAMENTOS MODIFY PAG_STATUS PAG_STATUS ENUM('PENDENTE', 'PAGO', 'CANCELADO') NOT NULL COMMENT 'STATUS DO PAGAMENTO';
ALTER TABLE PAGAMENTOS DROP COLUMN PAG_METODO COMMENT 'REMOVE A COLUNA MÉTODO DE PAGAMENTO';

-- DDL's para a Tabela VENDAS
ALTER TABLE VENDAS ADD COLUMN VENDA_DATA DATE NOT NULL COMMENT 'DATA DA VENDA';
ALTER TABLE VENDAS CHANGE CLI_CPF CLI_CPF VARCHAR(14) NOT NULL COMMENT 'CPF DO CLIENTE';
ALTER TABLE VENDAS MODIFY PAG_ID PAG_ID INT NOT NULL COMMENT 'ID DO PAGAMENTO RELACIONADO À VENDA';
ALTER TABLE VENDAS DROP COLUMN VENDA_DATA COMMENT 'REMOVE A COLUNA DATA DA VENDA';

-- DDL's para a Tabela VENDAS_PRODUTOS
ALTER TABLE VENDAS_PRODUTOS ADD COLUMN VEPRO_DESCONTO DECIMAL(10, 3) COMMENT 'DESCONTO APLICADO NA VENDA DO PRODUTO';
ALTER TABLE VENDAS_PRODUTOS CHANGE VEPRO_QTD_VENDIDA VEPRO_QTD_VENDIDA INT NOT NULL COMMENT 'QUANTIDADE VENDIDA DO PRODUTO';
ALTER TABLE VENDAS_PRODUTOS MODIFY VEPRO_VALORTOTAL VEPRO_VALORTOTAL DECIMAL(10, 3) NOT NULL COMMENT 'VALOR TOTAL DA VENDA DO PRODUTO';
ALTER TABLE VENDAS_PRODUTOS DROP COLUMN VEPRO_DESCONTO COMMENT 'REMOVE A COLUNA DESCONTO APLICADO NA VENDA DO PRODUTO';