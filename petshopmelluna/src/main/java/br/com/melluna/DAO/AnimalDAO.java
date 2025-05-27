package br.com.melluna.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import br.com.melluna.model.Animal;
import br.com.melluna.util.Conexao;

public class AnimalDAO { 

    public void inserir(Animal animal) {
        String sql = "INSERT INTO animal (nome, especie, raca, peso, obs, cpfCliente) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = Conexao.getConexao();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, animal.getNome());
            ps.setString(2, animal.getEspecie());
            ps.setString(3, animal.getRaca());
            ps.setDouble(4, animal.getPeso());
            ps.setString(5, animal.getObs());
            ps.setString(6, animal.getCpfCliente());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao inserir animal: " + e.getMessage());
            e.printStackTrace(); 
            throw new RuntimeException("Erro ao inserir animal no banco de dados.", e);
        }
    }

    public Animal buscarPorId(int idAnimal) {
        String sql = "SELECT * FROM animal WHERE idAnimal = ?";
        try (Connection conn = Conexao.getConexao();
                PreparedStatement ps = conn.prepareStatement(sql)) {
               ps.setInt(1, idAnimal);
               try (ResultSet rs = ps.executeQuery()) {
                   if (rs.next()) {
                       return new Animal(
                           rs.getInt("idAnimal"),
                           rs.getString("nome"),
                           rs.getString("especie"),
                           rs.getString("raca"),
                           rs.getDouble("peso"),
                           rs.getString("obs"),
                           rs.getString("cpfCliente")
                       );
                   }
               }
           } catch (SQLException e) {
            System.err.println("Erro ao buscar animal por ID: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Erro ao buscar animal no banco de dados.", e);
        }
        return null;
    }

    public List<Animal> buscarAnimaisPorCpfCliente(String cpfCliente) {
        List<Animal> animais = new ArrayList<>();
        String sql = "SELECT * FROM animal WHERE cpfCliente = ? ORDER BY nome";
        try (Connection conn = Conexao.getConexao();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cpfCliente);
            try (ResultSet rs = ps.executeQuery()) { 
                while (rs.next()) {
                    animais.add(new Animal(
                        rs.getInt("idAnimal"),
                        rs.getString("nome"),
                        rs.getString("especie"),
                        rs.getString("raca"),
                        rs.getDouble("peso"),
                        rs.getString("obs"),
                        rs.getString("cpfCliente")
                    ));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar animais por CPF do cliente: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Erro ao buscar animais no banco de dados.", e);
        }
        return animais;
    }

    public void atualizar(Animal animal) {
        String sql = "UPDATE animal SET nome = ?, especie = ?, raca = ?, peso = ?, obs = ? WHERE idAnimal = ? AND cpfCliente = ?";
        try (Connection conn = Conexao.getConexao();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, animal.getNome());
            ps.setString(2, animal.getEspecie());
            ps.setString(3, animal.getRaca());
            ps.setDouble(4, animal.getPeso());
            ps.setString(5, animal.getObs());
            ps.setInt(6, animal.getIdAnimal());
            ps.setString(7, animal.getCpfCliente());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new RuntimeException("Animal não encontrado ou não pertence ao cliente especificado.");
            }
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar animal: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Erro ao atualizar animal no banco de dados.", e);
        }
    }

    public void deletar(int idAnimal) {
        String sql = "DELETE FROM animal WHERE idAnimal = ?";
        try (Connection conn = Conexao.getConexao();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idAnimal);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new RuntimeException("Animal não encontrado para exclusão.");
            }
        } catch (SQLException e) {
            System.err.println("Erro ao deletar animal: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Erro ao deletar animal do banco de dados.", e);
        }
    }

}