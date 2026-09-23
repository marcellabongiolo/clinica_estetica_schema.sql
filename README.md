# 🏥 Clínica Estética — Database Schema

Projeto de **modelagem relacional em SQL** para uma clínica estética, desenvolvido como exercício de banco de dados.

O repositório demonstra a criação de tabelas, relacionamentos por chaves estrangeiras, restrições de integridade, índices, dados de demonstração e uma consulta com múltiplos `JOINs`.

## Objetivos

- Praticar modelagem de banco de dados relacional.
- Aplicar conceitos de **DDL** e **DML**.
- Trabalhar com chaves primárias e estrangeiras.
- Definir restrições de integridade com `NOT NULL` e `CHECK`.
- Criar índices para colunas usadas nos relacionamentos e consultas.
- Consultar dados relacionados com `JOIN`.
- Documentar um pequeno cenário de negócio em SQL.

## Modelo de dados

O banco possui três entidades principais:

- **pacientes** — dados cadastrais dos pacientes.
- **procedimentos** — serviços oferecidos pela clínica.
- **agendamentos** — relaciona pacientes e procedimentos em uma data e horário.

Relacionamentos:

```text
pacientes 1 ─────── N agendamentos N ─────── 1 procedimentos
```

Cada agendamento pertence a um paciente e a um procedimento.

## Estrutura

```text
clinica_estetica_schema.sql/
├── .github/
│   └── workflows/
│       └── tests.yml
├── tests/
│   └── test_schema.py
├── .gitignore
├── LICENSE
├── README.md
└── clinica_estetica_schema.sql
```

## Conteúdo do script

O arquivo SQL contém:

1. **DDL**
   - criação das tabelas;
   - chaves primárias;
   - chaves estrangeiras;
   - restrições de integridade;
   - índices.

2. **DML**
   - dados de demonstração para pacientes, procedimentos e agendamentos.

3. **Consulta analítica**
   - combinação de dados de três tabelas com `JOIN`;
   - ordenação por data do agendamento.

## Tecnologias

- SQL
- Modelagem relacional
- PostgreSQL / MySQL
- SQLite para os testes automatizados
- Python `unittest`
- GitHub Actions

## Como executar

O script principal está em:

```text
clinica_estetica_schema.sql
```

Ele pode ser executado em um ambiente SQL compatível, como PostgreSQL ou MySQL.

Para executar os testes localmente:

```bash
python -m unittest discover -s tests -v
```

Os testes utilizam o SQLite disponível na biblioteca padrão do Python para verificar a estrutura e as regras básicas do modelo sem exigir a instalação de um servidor de banco de dados.

## Observação sobre os dados

Os registros inseridos no script são **dados fictícios para demonstração**. O projeto não representa uma base clínica real.

## Próximos passos

- adicionar uma tabela de profissionais;
- modelar pagamentos e formas de pagamento;
- registrar histórico de status dos agendamentos;
- adicionar consultas de faturamento;
- criar uma camada de acesso via API;
- evoluir o modelo para um projeto completo de backend.

## Licença

Este projeto está disponível sob a licença MIT.
