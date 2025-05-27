package br.com.melluna.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import br.com.melluna.model.Cliente;
import br.com.melluna.util.Conexao;

public class ClienteDAO {

    public void inserir(Cliente cliente) {
        String sql = "INSERT INTO Cliente (cpf, nome, email, senha, endereco, fidelidade) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = Conexao.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cliente.getCpf());
            stmt.setString(2, cliente.getNome());
            stmt.setString(3, cliente.getEmail());
            stmt.setString(4, cliente.getSenha());
            stmt.setString(5, cliente.getEndereco());
            stmt.setInt(6, cliente.getFidelidade());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao inserir cliente: " + e.getMessage(), e);
        }
    }

    public Cliente buscarPorCpf(String cpf) {
        String sql = "SELECT cpf, nome, email, senha, endereco, fidelidade FROM Cliente WHERE cpf = ?";
        Cliente cliente = null;
        try (Connection conn = Conexao.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cpf);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cliente = new Cliente();
                    cliente.setCpf(rs.getString("cpf"));
                    cliente.setNome(rs.getString("nome"));
                    cliente.setEmail(rs.getString("email"));
                    cliente.setSenha(rs.getString("senha"));
                    cliente.setEndereco(rs.getString("endereco"));
                    cliente.setFidelidade(rs.getInt("fidelidade"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao buscar cliente por CPF: " + e.getMessage(), e);
        }
        return cliente;
    }

    public boolean autenticar(String email, String senha) {
        String sql = "SELECT COUNT(*) FROM Cliente WHERE email = ? AND senha = ?";
        try (Connection conn = Conexao.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, senha);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro na autenticação: " + e.getMessage(), e);
        }
        return false;
    }

    public Cliente buscarPorEmail(String email) {
        String sql = "SELECT cpf, nome, email, senha, endereco, fidelidade FROM Cliente WHERE email = ?";
        Cliente cliente = null;
        try (Connection conn = Conexao.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cliente = new Cliente();
                    cliente.setCpf(rs.getString("cpf"));
                    cliente.setNome(rs.getString("nome"));
                    cliente.setEmail(rs.getString("email"));
                    cliente.setSenha(rs.getString("senha"));
                    cliente.setEndereco(rs.getString("endereco"));
                    cliente.setFidelidade(rs.getInt("fidelidade"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao buscar cliente por email: " + e.getMessage(), e);
        }
        return cliente;
    }


    public void atualizar(Cliente cliente) {
        String sql = "UPDATE Cliente SET nome=?, email=?, senha=?, endereco=?, fidelidade=? WHERE cpf=?";
        try (Connection conn = Conexao.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cliente.getNome());
            stmt.setString(2, cliente.getEmail());
            stmt.setString(3, cliente.getSenha());
            stmt.setString(4, cliente.getEndereco());
            stmt.setInt(5, cliente.getFidelidade());
            stmt.setString(6, cliente.getCpf());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao atualizar cliente: " + e.getMessage(), e);
        }
    }

    public void deletar(String cpf) {
        String sql = "DELETE FROM Cliente WHERE cpf = ?";
        try (Connection conn = Conexao.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cpf);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao deletar cliente: " + e.getMessage(), e);
        }
    }
}