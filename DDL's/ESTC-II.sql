#CRIANDO O BANCO DE DADOS
CREATE SCHEMA EMPRESA_AEREA;

#USANDO O BANCO DE DADOS
USE EMPRESA_AEREA;


#--------------------TABELA DE PASSAGEIROS--------------------
CREATE TABLE IF NOT EXISTS PASSAGEIROS (
    PASS_CPF VARCHAR(14) PRIMARY KEY,
    PASS_NOME VARCHAR(50) NOT NULL,
    PASS_TELEFONE VARCHAR(15) NOT NULL,
    PASS_RUA VARCHAR(100) NOT NULL,
    PASS_NUMRUA INT,
    PASS_BAIRRO VARCHAR(50) NOT NULL,
    PASS_CIDADE VARCHAR(50) NOT NULL,
    PASS_ESTADO VARCHAR(50) NOT NULL,
    PASS_PAIS VARCHAR(50) NOT NULL,
    PASS_CODPOSTAL VARCHAR(10) NOT NULL,
    PASS_EMAIL VARCHAR(50) NOT NULL
);

#--------------------TABELA DE FUNCIONARIOS--------------------

CREATE TABLE IF NOT EXISTS FUNCIONARIOS (
    FUNC_ID INT PRIMARY KEY,
    FUNC_CPF VARCHAR(14) NOT NULL,
    FUNC_NOME VARCHAR(50) NOT NULL,
    FUNC_DATANASC DATE NOT NULL,
    FUNC_RUA VARCHAR(100) NOT NULL,
    FUNC_NUMRUA INT,
    FUNC_BAIRRO VARCHAR(50) NOT NULL,
    FUNC_CIDADE VARCHAR(50) NOT NULL,
    FUNC_ESTADO VARCHAR(50) NOT NULL,
    FUNC_PAIS VARCHAR(50) NOT NULL,
    FUNC_CODPOSTAL VARCHAR(10) NOT NULL
);

#--------------------TABELA DE AERONAVES--------------------

CREATE TABLE IF NOT EXISTS AERONAVES (
    AERON_PREFIXO VARCHAR(10) PRIMARY KEY,
    AERON_MODELO VARCHAR(50) NOT NULL,
    AERON_FABRICANTE VARCHAR(50) NOT NULL,
    AERON_ANOFABR YEAR NOT NULL,
    AERON_CAPACIDADE TEXT NOT NULL,
    AERON_AUTONOMIA VARCHAR(10) NOT NULL
);

#--------------------TABELA DE AEROPORTOS--------------------

CREATE TABLE IF NOT EXISTS AEROPORTOS (
    AEROP_CODIGO INT PRIMARY KEY,
    AEROP_NOME VARCHAR(50) NOT NULL,
    AEROP_CIDADE VARCHAR(50) NOT NULL,
    AEROP_PAIS VARCHAR(50) NOT NULL,
    AEROP_LATITUDE TEXT NOT NULL,
    AEROP_LONGITUDE TEXT NOT NULL
);

#--------------------TABELA DE VOOS--------------------

CREATE TABLE IF NOT EXISTS VOOS (
    VOO_ID INT PRIMARY KEY,
    VOO_DATA DATE NOT NULL,
    VOO_HORA TIME NOT NULL,
    VOO_AEROP_ORIGEM INT NOT NULL,
    VOO_AEROP_DESTINO INT NOT NULL,
    VOO_AERONAVE VARCHAR(10) NOT NULL,
    CONSTRAINT FK_AEROP_ORIGEM FOREIGN KEY(VOO_AEROP_ORIGEM) REFERENCES AEROPORTOS(AEROP_CODIGO),
    CONSTRAINT FK_AEROP_DESTINO FOREIGN KEY(VOO_AEROP_DESTINO) REFERENCES AEROPORTOS(AEROP_CODIGO),
    CONSTRAINT FK_AERONAVE FOREIGN KEY(VOO_AERONAVE) REFERENCES AERONAVES(AERON_PREFIXO)
);

#--------------------TABELA DE EQUIPES--------------------

CREATE TABLE IF NOT EXISTS EQUIPES (
    VOO_ID INT NOT NULL,
    FUNC_ID INT NOT NULL,
    PRIMARY KEY(VOO_ID, FUNC_ID),
    CONSTRAINT VOFU_FK_VOO FOREIGN KEY(VOO_ID) REFERENCES VOOS(VOO_ID),
    CONSTRAINT VOFU_FK_FUNCIONARIO FOREIGN KEY(FUNC_ID) REFERENCES FUNCIONARIOS(FUNC_ID)
);

#--------------------TABELA DE RESERVAS--------------------

CREATE TABLE IF NOT EXISTS RESERVAS (
    RESERVA_COD INT PRIMARY KEY,
    VOO_ID INT NOT NULL,
    PASS_CPF VARCHAR(14) NOT NULL,
    CONSTRAINT FK_PASSAGEIROS FOREIGN KEY(PASS_CPF) REFERENCES PASSAGEIROS(PASS_CPF),
    CONSTRAINT FK_VOOS FOREIGN KEY(VOO_ID) REFERENCES VOOS(VOO_ID)
);

-- DDL'S PARA TABELA DE PASSAGEIROS
ALTER TABLE PASSAGEIROS ADD COLUMN PASS_DATA_NASC DATE COMMENT 'DATA DE NASCIMENTO DO PASSAGEIRO';
ALTER TABLE PASSAGEIROS CHANGE PASS_CPF PASS_CPF VARCHAR(14) NOT NULL COMMENT 'CPF DO PASSAGEIRO';
ALTER TABLE PASSAGEIROS MODIFY PASS_EMAIL VARCHAR(100) COMMENT 'EMAIL DO PASSAGEIRO';
ALTER TABLE PASSAGEIROS DROP COLUMN PASS_DATA_NASC COMMENT 'REMOVE A COLUNA DE DATA DE NASCIMENTO DO PASSAGEIRO';

-- DDL'S PARA TABELA DE FUNCIONARIOS
ALTER TABLE FUNCIONARIOS ADD COLUMN FUNC_EMAIL VARCHAR(50) COMMENT 'EMAIL DO FUNCIONÁRIO';
ALTER TABLE FUNCIONARIOS CHANGE FUNC_CPF FUNC_CPF VARCHAR(14) NOT NULL COMMENT 'CPF DO FUNCIONÁRIO';
ALTER TABLE FUNCIONARIOS MODIFY FUNC_DATANASC DATE NULL COMMENT 'DATA DE NASCIMENTO DO FUNCIONÁRIO (OPCIONAL)';
ALTER TABLE FUNCIONARIOS DROP COLUMN FUNC_EMAIL COMMENT 'REMOVE A COLUNA DE EMAIL DO FUNCIONÁRIO';

-- DDL'S PARA TABELA DE AERONAVES
ALTER TABLE AERONAVES ADD COLUMN AERON_TIPO VARCHAR(30) COMMENT 'TIPO DA AERONAVE';
ALTER TABLE AERONAVES CHANGE AERON_ANOFABR AERON_ANO_FABRICACAO YEAR NOT NULL COMMENT 'ANO DE FABRICAÇÃO DA AERONAVE';
ALTER TABLE AERONAVES MODIFY AERON_CAPACIDADE TEXT NULL COMMENT 'CAPACIDADE DA AERONAVE (OPCIONAL)';
ALTER TABLE AERONAVES DROP COLUMN AERON_TIPO COMMENT 'REMOVE A COLUNA DE TIPO DA AERONAVE';

-- DDL'S PARA TABELA DE AEROPORTOS
ALTER TABLE AEROPORTOS ADD COLUMN AEROP_REGIAO VARCHAR(30) COMMENT 'REGIÃO DO AEROPORTO';
ALTER TABLE AEROPORTOS CHANGE AEROP_NOME AEROP_NOME_AEROPORTO VARCHAR(50) NOT NULL COMMENT 'NOME DO AEROPORTO';
ALTER TABLE AEROPORTOS MODIFY AEROP_LATITUDE TEXT NULL COMMENT 'LATITUDE DO AEROPORTO (OPCIONAL)';
ALTER TABLE AEROPORTOS DROP COLUMN AEROP_REGIAO COMMENT 'REMOVE A COLUNA DE REGIÃO DO AEROPORTO';

-- DDL'S PARA TABELA DE VOOS
ALTER TABLE VOOS ADD COLUMN VOO_STATUS VARCHAR(20) COMMENT 'STATUS DO VOO';
ALTER TABLE VOOS CHANGE VOO_AERONAVE VOO_AERONAVE_PREFIXO VARCHAR(10) NOT NULL COMMENT 'PREFIXO DA AERONAVE';
ALTER TABLE VOOS MODIFY VOO_HORA TIME NULL COMMENT 'HORA DO VOO (OPCIONAL)';
ALTER TABLE VOOS DROP COLUMN VOO_STATUS COMMENT 'REMOVE A COLUNA DE STATUS DO VOO';

-- DDL'S PARA TABELA DE EQUIPES
ALTER TABLE EQUIPES ADD COLUMN VOO_FUNCAO VARCHAR(50) COMMENT 'FUNÇÃO DO FUNCIONÁRIO NA EQUIPE';
ALTER TABLE EQUIPES CHANGE VOO_ID VOO_ID_REF INT NOT NULL COMMENT 'REFERÊNCIA PARA O VOO';
ALTER TABLE EQUIPES MODIFY FUNC_ID INT NOT NULL COMMENT 'CÓDIGO DO FUNCIONÁRIO';
ALTER TABLE EQUIPES DROP COLUMN VOO_FUNCAO COMMENT 'REMOVE A COLUNA DE FUNÇÃO DO FUNCIONÁRIO NA EQUIPE';

-- DDL'S PARA TABELA DE RESERVAS
ALTER TABLE RESERVAS ADD COLUMN RESERVA_DATA DATE NOT NULL COMMENT 'DATA DA RESERVA';
ALTER TABLE RESERVAS CHANGE PASS_CPF PASS_CPF_PASSAGEIRO VARCHAR(14) NOT NULL COMMENT 'CPF DO PASSAGEIRO QUE REALIZOU A RESERVA';
ALTER TABLE RESERVAS MODIFY VOO_ID INT NOT NULL COMMENT 'ID DO VOO RELACIONADO À RESERVA';
ALTER TABLE RESERVAS DROP COLUMN RESERVA_DATA COMMENT 'REMOVE A COLUNA DE DATA DA RESERVA';


ALTER TABLE PASSAGEIROS ADD PASS_DATA_NASCIMENTO DATE;
ALTER TABLE PASSAGEIROS MODIFY PASS_TELEFONE VARCHAR(20) NOT NULL; 
ALTER TABLE PASSAGEIROS CHANGE COLUMN PASS_RUA ENDERECO_PASS VARCHAR(100) NOT NULL;
DROP TABLE IF EXISTS PASSAGEIROS;
