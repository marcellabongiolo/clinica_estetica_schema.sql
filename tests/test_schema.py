import sqlite3
import unittest
from pathlib import Path


SQL_FILE = Path(__file__).parents[1] / "clinica_estetica_schema.sql"


class TestClinicaEsteticaSchema(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.connection = sqlite3.connect(":memory:")
        cls.connection.execute("PRAGMA foreign_keys = ON")
        sql = SQL_FILE.read_text(encoding="utf-8")
        cls.connection.executescript(sql)

    @classmethod
    def tearDownClass(cls):
        cls.connection.close()

    def test_tabelas_principais_existem(self):
        tabelas = {
            row[0]
            for row in self.connection.execute(
                "SELECT name FROM sqlite_master WHERE type = 'table'"
            )
        }
        self.assertTrue({"pacientes", "procedimentos", "agendamentos"} <= tabelas)

    def test_dados_de_demonstracao_foram_inseridos(self):
        self.assertEqual(
            self.connection.execute("SELECT COUNT(*) FROM pacientes").fetchone()[0], 2
        )
        self.assertEqual(
            self.connection.execute("SELECT COUNT(*) FROM procedimentos").fetchone()[0], 3
        )
        self.assertEqual(
            self.connection.execute("SELECT COUNT(*) FROM agendamentos").fetchone()[0], 2
        )

    def test_join_da_agenda_retorna_dados_relacionados(self):
        query = """
            SELECT p.nome, pr.nome_procedimento, a.status
            FROM agendamentos AS a
            JOIN pacientes AS p ON a.id_paciente = p.id_paciente
            JOIN procedimentos AS pr
                ON a.id_procedimento = pr.id_procedimento
            ORDER BY a.id_agendamento
        """
        resultados = self.connection.execute(query).fetchall()
        self.assertEqual(
            resultados[0],
            ("Ana Clara Silva", "Limpeza de Pele Profunda", "Concluído"),
        )
        self.assertEqual(
            resultados[1],
            ("Bruno Santos", "Peeling Químico", "Pendente"),
        )

    def test_chave_estrangeira_e_integridade_sao_aplicadas(self):
        with self.assertRaises(sqlite3.IntegrityError):
            self.connection.execute(
                """
                INSERT INTO agendamentos (
                    id_agendamento, id_paciente, id_procedimento,
                    data_agendamento
                )
                VALUES (99, 999, 1, '2026-10-07 09:00:00')
                """
            )

    def test_status_invalido_e_rejeitado(self):
        with self.assertRaises(sqlite3.IntegrityError):
            self.connection.execute(
                """
                INSERT INTO agendamentos (
                    id_agendamento, id_paciente, id_procedimento,
                    data_agendamento, status
                )
                VALUES (99, 1, 1, '2026-10-07 09:00:00', 'Inexistente')
                """
            )


if __name__ == "__main__":
    unittest.main()
