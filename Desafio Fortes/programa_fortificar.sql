-- Banco de Dados: Programa Fortificar
CREATE DATABASE ProgramaFortificar;
USE ProgramaFortificar;

-- Tabela de Colaboradores
CREATE TABLE Colaboradores 
(
    id_colaborador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    setor VARCHAR(100),
    cargo VARCHAR(100),
    data_entrada DATE,
    status_ativo BOOLEAN DEFAULT TRUE,
    endereco TEXT,
    cidade VARCHAR(100),
    estado VARCHAR(2),
    cep VARCHAR(10)
);

-- Tabela de Instituições
CREATE TABLE Instituicoes 
(
    id_instituicao INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cnpj VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(255),
    endereco TEXT,
    cidade VARCHAR(100),
    estado VARCHAR(2),
    cep VARCHAR(10),
    tipo_instituicao ENUM('Pública', 'Privada', 'OSC', 'ONG', 'Outro') NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    descricao TEXT
);

-- Tabela de Projetos
CREATE TABLE Projetos 
(
    id_projeto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    acoes_planejadas TEXT,
    data_inicio DATE,
    data_fim DATE,
    status ENUM('Planejado', 'Em Execução', 'Concluído', 'Cancelado') DEFAULT 'Planejado',
    quantidade_beneficiados INT,
    id_instituicao INT,
    FOREIGN KEY (id_instituicao) REFERENCES Instituicoes(id_instituicao),
    valor_previsto DECIMAL(10, 2),
    valor_executado DECIMAL(10, 2)
);

-- Tabela de Temas
CREATE TABLE Temas 
(
    id_tema INT AUTO_INCREMENT PRIMARY KEY,
    tema VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela de Projetos_Temas (Muitos-para-Muitos)
CREATE TABLE Projetos_Temas 
(
    id_projeto INT,
    id_tema INT,
    PRIMARY KEY (id_projeto, id_tema),
    FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto),
    FOREIGN KEY (id_tema) REFERENCES Temas(id_tema)
);

-- Tabela de Doações
CREATE TABLE Doacoes 
(
    id_doacao INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10, 2) NOT NULL,
    data_doacao DATE NOT NULL,
    tipo_doacao ENUM('Financeira', 'Bens', 'Serviços', 'Outro') NOT NULL,
    descricao TEXT,
    id_projeto INT,
    id_colaborador INT,
    FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto),
    FOREIGN KEY (id_colaborador) REFERENCES Colaboradores(id_colaborador)
);

-- Tabela de Participação em Projetos
CREATE TABLE Participacoes 
(
    id_participacao INT AUTO_INCREMENT PRIMARY KEY,
    id_colaborador INT,
    id_projeto INT,
    papel ENUM('Coordenador', 'Voluntário', 'Apoio Técnico', 'Outros') NOT NULL,
    horas_trabalhadas DECIMAL(5, 2),
    data_participacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_colaborador) REFERENCES Colaboradores(id_colaborador),
    FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto)
);

-- Tabela de Relatórios
CREATE TABLE Relatorios 
(
    id_relatorio INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT,
    data_emissao DATETIME DEFAULT CURRENT_TIMESTAMP,
    resumo TEXT,
    comentarios TEXT,
    FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto)
);

-- Tabela de Acompanhamento
CREATE TABLE Acompanhamento 
(
    id_acompanhamento INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT,
    etapa_atual VARCHAR(255),
    progresso DECIMAL(5, 2) DEFAULT 0.00,
    ultima_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    observacoes TEXT,
    FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto)
);

-- Tabela de Feedback
CREATE TABLE Feedback 
(
    id_feedback INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT,
    autor VARCHAR(255),
    papel_autor ENUM('Beneficiário', 'Colaborador', 'Instituição', 'Outro'),
    comentario TEXT,
    data_feedback DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto)
);

-- Tabela de Documentos
CREATE TABLE Documentos 
(
    id_documento INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT,
    id_instituicao INT,
    id_relatorio INT,
    descricao TEXT,
    link_documento VARCHAR(255),
    data_upload DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto),
    FOREIGN KEY (id_instituicao) REFERENCES Instituicoes(id_instituicao),
    FOREIGN KEY (id_relatorio) REFERENCES Relatorios(id_relatorio)
);
