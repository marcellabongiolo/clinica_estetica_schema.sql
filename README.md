/*
 * Módulo: Sistema de Gestão de Clínica Estética (Medical Cosmetics)
 * Autor: Marcella Bongiolo
 * Descrição: Script DDL/DML para criação do banco de dados, tabelas,
 *            inserção de registros e queries analíticas (Foco: PostgreSQL/MySQL).
 */

-- ==========================================
-- 1. ESTRUTURA DO BANCO DE DADOS (DDL)
-- ==========================================

-- Criação da tabela de Pacientes
CREATE TABLE pacientes (
    id_paciente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATE DEFAULT CURRENT_DATE
);

-- Criação da tabela de Procedimentos (Ex: Skincare, Limpeza de pele, etc)
CREATE TABLE procedimentos (
    id_procedimento INT PRIMARY KEY,
    nome_procedimento VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    duracao_minutos INT NOT NULL
);

-- Criação da tabela de Agendamentos (Relacionamento entre Paciente e Procedimento)
CREATE TABLE agendamentos (
    id_agendamento INT PRIMARY KEY,
    id_paciente INT,
    id_procedimento INT,
    data_agendamento TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'Pendente',
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_procedimento) REFERENCES procedimentos(id_procedimento)
);

-- ==========================================
-- 2. INSERÇÃO DE DADOS MOCKADOS (DML)
-- ==========================================

INSERT INTO pacientes (id_paciente, nome, data_nascimento, telefone) VALUES
(1, 'Ana Clara Silva', '1995-04-12', '11999998888'),
(2, 'Bruno Santos', '1988-10-25', '11988887777');

INSERT INTO procedimentos (id_procedimento, nome_procedimento, preco, duracao_minutos) VALUES
(1, 'Limpeza de Pele Profunda', 150.00, 60),
(2, 'Peeling Químico', 250.00, 45),
(3, 'Revitalização Facial', 180.00, 50);

INSERT INTO agendamentos (id_agendamento, id_paciente, id_procedimento, data_agendamento, status) VALUES
(1, 1, 1, '2026-10-05 14:00:00', 'Concluído'),
(2, 2, 2, '2026-10-06 10:30:00', 'Pendente');

-- ==========================================
-- 3. QUERIES ANALÍTICAS DE NEGÓCIO
-- ==========================================

-- Query: Listar todos os agendamentos com os nomes dos pacientes e procedimentos
SELECT 
    a.id_agendamento,
    p.nome AS paciente,
    pr.nome_procedimento AS procedimento,
    a.data_agendamento,
    a.status
FROM 
    agendamentos a
JOIN 
    pacientes p ON a.id_paciente = p.id_paciente
JOIN 
    procedimentos pr ON a.id_procedimento = pr.id_procedimento
ORDER BY 
    a.data_agendamento;
