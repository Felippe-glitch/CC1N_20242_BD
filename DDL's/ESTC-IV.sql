CREATE SCHEMA EST_CASO_IV;
USE ESTC_IV; 

CREATE TABLE IF NOT EXISTS ALUNOS (
	ALUNO_ID INT PRIMARY KEY,
    ALUNO_CPF VARCHAR(14) NOT NULL,
    ALUNO_NOME VARCHAR(100) NOT NULL,
    ALUNO_DATANASC DATE NOT NULL,
    ALUNO_RUA VARCHAR(100) NOT NULL,
    ALUNO_NUM INT,
    ALUNO_COMPLEMENTO TEXT,
    ALUNO_BAIRRO VARCHAR(100) NOT NULL,
    ALUNO_CIDADE VARCHAR(100) NOT NULL,
    ALUNO_CEP VARCHAR(15) NOT NULL,
    ALUNO_UF CHAR(2) NOT NULL,
    ALUNO_PAIS VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS INSTRUTORES (
	INSTRU_ID INT PRIMARY KEY,
    INSTRU_CPF VARCHAR(14) NOT NULL,
    INSTRU_NOME VARCHAR(100) NOT NULL,
    INSTRU_DATANASC DATE NOT NULL,
	INSTRU_RUA VARCHAR(100) NOT NULL,
    INSTRU_NUM INT,
    INSTRU_COMPLEMENTO TEXT,
    INSTRU_BAIRRO VARCHAR(100) NOT NULL,
    INSTRU_CIDADE VARCHAR(100) NOT NULL,
    INSTRU_CEP VARCHAR(15) NOT NULL,
    INSTRU_UF CHAR(2) NOT NULL,
    INSTRU_PAIS VARCHAR(100) NOT NULL,
    INSTRU_ESPECIALIDADE VARCHAR(100) NOT NULL
);


CREATE TABLE IF NOT EXISTS MODALIDADES (
	MOD_ID INT PRIMARY KEY,
    MOD_NOME VARCHAR(100) NOT NULL,
    MOD_DESCRICAO TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS PLANOS_TREINAMENTOS (
	PLAN_ID INT PRIMARY KEY,
    ALUNO_ID INT NOT NULL,
    INSTRU_ID INT NOT NULL,
    PLAN_DESCRICAO TEXT NOT NULL,
    PLAN_DATAINICIO DATE NOT NULL,
    PLAN_DATAFIM DATE,
    CONSTRAINT PLTR_FK_ALUNO FOREIGN KEY(ALUNO_ID) REFERENCES ALUNOS(ALUNO_ID),
    CONSTRAINT PLTR_FK_INSTRUTOR FOREIGN KEY(INSTRU_ID) REFERENCES INSTRUTORES(INSTRU_ID)
);

CREATE TABLE IF NOT EXISTS AULAS (
	AULA_ID INT PRIMARY KEY,
    MOD_ID INT NOT NULL,
    INSTRU_ID INT NOT NULL,
    AULA_HORARIO TIME NOT NULL,
    AULA_CAPACIDADE INT NOT NULL,
	CONSTRAINT AULAS_FK_MODALIDADES FOREIGN KEY (MOD_ID) REFERENCES MODALIDADES(MOD_ID),
    CONSTRAINT AULAS_FK_INSTRUTORES FOREIGN KEY (INSTRU_ID) REFERENCES INSTRUTORES(INSTRU_ID)
);


CREATE TABLE IF NOT EXISTS MATRICULAS (
	MATRICULA_ID INT PRIMARY KEY,
    ALUNO_ID INT NOT NULL,
    MOD_ID INT NOT NULL,
    MATRICULA_DATA DATE NOT NULL,
    MATRICULA_STATUS ENUM("MATRICULADO", "NAO MATRICULADO"),
    CONSTRAINT MATRICULA_FK_ALUNOS FOREIGN KEY (ALUNO_ID) REFERENCES ALUNOS(ALUNO_ID),
    CONSTRAINT MATRICULA_FK_MODALIDADES FOREIGN KEY (MOD_ID) REFERENCES MODALIDADES(MOD_ID)

);

CREATE TABLE IF NOT EXISTS PAGAMENTOS (
	PAG_ID INT PRIMARY KEY,
    MATRICULA_ID INT NOT NULL,
    PAG_DATA DATE NOT NULL,
    PAG_VALOR DECIMAL(10, 3) NOT NULL,
    PAG_STATUS ENUM("PAGO", "PENDENTE"),
    CONSTRAINT PAG_FK_MATRICULAS FOREIGN KEY(MATRICULA_ID) REFERENCES MATRICULAS(MATRICULA_ID)
);

CREATE TABLE IF NOT EXISTS ALUNOS_AULAS (
	AULA_ID INT,
    ALUNO_ID INT,
    PRIMARY KEY(AULA_ID, ALUNO_ID),
    CONSTRAINT ALAU_FK_AULAS FOREIGN KEY(AULA_ID) REFERENCES AULAS(AULA_ID),
    CONSTRAINT ALAU_FK_ALUNOS FOREIGN KEY(ALUNO_ID) REFERENCES ALUNOS(ALUNO_ID) 
);

ALTER TABLE ALUNOS ADD ALUNO_TELEFONE VARCHAR(15);
DROP TABLE IF EXISTS ALUNOS_AULAS;
ALTER TABLE ALUNOS MODIFY ALUNO_NUM VARCHAR(10);
ALTER TABLE ALUNOS CHANGE ALUNO_NUM ALUNO_NUMERO VARCHAR(10);