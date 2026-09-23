-- Sistema de Gestão de Clínica Estética
-- Schema DDL, dados de demonstração DML e consultas analíticas.
-- Compatível com PostgreSQL/MySQL; os testes automatizados usam SQLite
-- para validar a estrutura relacional e as regras básicas do modelo.

DROP TABLE IF EXISTS agendamentos;
DROP TABLE IF EXISTS procedimentos;
DROP TABLE IF EXISTS pacientes;

CREATE TABLE pacientes (
    id_paciente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATE DEFAULT CURRENT_DATE
);

CREATE TABLE procedimentos (
    id_procedimento INT PRIMARY KEY,
    nome_procedimento VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL CHECK (preco >= 0),
    duracao_minutos INT NOT NULL CHECK (duracao_minutos > 0)
);

CREATE TABLE agendamentos (
    id_agendamento INT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_procedimento INT NOT NULL,
    data_agendamento TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pendente',
    CONSTRAINT fk_agendamento_paciente
        FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    CONSTRAINT fk_agendamento_procedimento
        FOREIGN KEY (id_procedimento) REFERENCES procedimentos(id_procedimento),
    CONSTRAINT ck_agendamento_status
        CHECK (status IN ('Pendente', 'Concluído', 'Cancelado'))
);

CREATE INDEX idx_agendamentos_paciente
    ON agendamentos (id_paciente);

CREATE INDEX idx_agendamentos_procedimento
    ON agendamentos (id_procedimento);

CREATE INDEX idx_agendamentos_data
    ON agendamentos (data_agendamento);

INSERT INTO pacientes (id_paciente, nome, data_nascimento, telefone) VALUES
    (1, 'Ana Clara Silva', '1995-04-12', '11999998888'),
    (2, 'Bruno Santos', '1988-10-25', '11988887777');

INSERT INTO procedimentos (
    id_procedimento,
    nome_procedimento,
    preco,
    duracao_minutos
) VALUES
    (1, 'Limpeza de Pele Profunda', 150.00, 60),
    (2, 'Peeling Químico', 250.00, 45),
    (3, 'Revitalização Facial', 180.00, 50);

INSERT INTO agendamentos (
    id_agendamento,
    id_paciente,
    id_procedimento,
    data_agendamento,
    status
) VALUES
    (1, 1, 1, '2026-10-05 14:00:00', 'Concluído'),
    (2, 2, 2, '2026-10-06 10:30:00', 'Pendente');

-- Consulta analítica: agenda com paciente e procedimento.
SELECT
    a.id_agendamento,
    p.nome AS paciente,
    pr.nome_procedimento AS procedimento,
    a.data_agendamento,
    a.status
FROM agendamentos AS a
JOIN pacientes AS p
    ON a.id_paciente = p.id_paciente
JOIN procedimentos AS pr
    ON a.id_procedimento = pr.id_procedimento
ORDER BY a.data_agendamento;
