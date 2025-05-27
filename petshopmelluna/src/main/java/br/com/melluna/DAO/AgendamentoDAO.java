package br.com.melluna.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import br.com.melluna.model.Agendamento;
import br.com.melluna.model.Animal;
import br.com.melluna.util.Conexao;

public class AgendamentoDAO {

    public void inserir(Agendamento agendamento) {
        String sql = "INSERT INTO Agendamento (data, hora, servico, transporte, hidratacao, escova, tipoPagamento, status, valor, idAnimal) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexao.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, agendamento.getData());
            stmt.setString(2, agendamento.getHora());
            stmt.setString(3, agendamento.getServico());
            stmt.setBoolean(4, agendamento.isTransporte());
            stmt.setBoolean(5, agendamento.isHidratacao());
            stmt.setBoolean(6, agendamento.isEscova());
            stmt.setString(7, agendamento.getTipoPagamento());
            stmt.setString(8, agendamento.getStatus());
            stmt.setDouble(9, agendamento.getValorTotal());
            stmt.setInt(10, agendamento.getIdAnimal());

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    agendamento.setIdAgendamento(rs.getInt(1));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao inserir agendamento: " + e.getMessage(), e);
        }
    }

    public List<Agendamento> buscarAgendamentosPorCpfCliente(String cpfCliente) {
        List<Agendamento> agendamentos = new ArrayList<>();
        String sql = "SELECT " +
                     "a.idAgendamento, a.data, a.hora, a.servico, " +
                     "a.transporte, a.hidratacao, a.escova, a.tipoPagamento, a.status, a.valor, " +
                     "an.idAnimal, an.nome, an.raca, an.especie, an.peso, an.obs, an.cpfCliente " +
                     "FROM Agendamento a " +
                     "JOIN Animal an ON a.idAnimal = an.idAnimal " +
                     "WHERE an.cpfCliente = ? ORDER BY a.data DESC, a.hora DESC";

        AnimalDAO animalDAO = new AnimalDAO(); 
        try (Connection conn = Conexao.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cpfCliente);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Agendamento agendamento = new Agendamento();
                    agendamento.setIdAgendamento(rs.getInt("idAgendamento"));
                    agendamento.setData(rs.getString("data"));
                    agendamento.setHora(rs.getString("hora"));
                    agendamento.setServico(rs.getString("servico"));
                    agendamento.setTransporte(rs.getBoolean("transporte"));
                    agendamento.setHidratacao(rs.getBoolean("hidratacao"));
                    agendamento.setEscova(rs.getBoolean("escova"));
                    agendamento.setTipoPagamento(rs.getString("tipoPagamento"));
                    agendamento.setStatus(rs.getString("status"));
                    agendamento.setValorTotal(rs.getDouble("valor"));
                    agendamento.setIdAnimal(rs.getInt("idAnimal"));

                    Animal animal = new Animal();
                    animal.setIdAnimal(rs.getInt("idAnimal"));
                    animal.setNome(rs.getString("nome"));
                    animal.setRaca(rs.getString("raca"));
                    animal.setEspecie(rs.getString("especie"));
                    animal.setPeso(rs.getDouble("peso"));
                    animal.setObs(rs.getString("obs"));
                    animal.setCpfCliente(rs.getString("cpfCliente"));

                    agendamento.setAnimal(animal);

                    agendamentos.add(agendamento);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao buscar agendamentos do cliente: " + e.getMessage(), e);
        } finally {
            try {
            } catch (Exception e) {
                System.err.println("Erro ao fechar AnimalDAO em AgendamentoDAO: " + e.getMessage());
            }
        }
        return agendamentos;
    }

    public void atualizarStatus(int idAgendamento, String novoStatus) {
        String sql = "UPDATE Agendamento SET status = ? WHERE idAgendamento = ?";
        try (Connection conn = Conexao.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, novoStatus);
            stmt.setInt(2, idAgendamento);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao atualizar status do agendamento: " + e.getMessage(), e);
        }
    }

    public int contarAgendamentosFinalizados(String cpfCliente) {
        String sql = "SELECT COUNT(a.idAgendamento) FROM Agendamento a " +
                     "JOIN Animal an ON a.idAnimal = an.idAnimal " +
                     "WHERE an.cpfCliente = ? AND a.status = 'Finalizado'";
        int count = 0;
        try (Connection conn = Conexao.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cpfCliente);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao contar agendamentos finalizados: " + e.getMessage(), e);
        }
        return count;
    }
}