package br.com.melluna.service;

import br.com.melluna.DAO.AnimalDAO;
import br.com.melluna.model.Animal;
import java.util.List;

public class AnimalService {

    private AnimalDAO animalDAO;

    public AnimalService() {
        this.animalDAO = new AnimalDAO();
    }

    public void cadastrarAnimal(Animal animal) {
        if (animal.getNome() == null || animal.getNome().trim().isEmpty()) {
            throw new IllegalArgumentException("O nome do animal é obrigatório.");
        }
        if (animal.getEspecie() == null || (!animal.getEspecie().equals("Cão") && !animal.getEspecie().equals("Gato"))) {
             throw new IllegalArgumentException("A espécie do animal deve ser 'Cão' ou 'Gato'.");
        }
        if (animal.getPeso() <= 0) {
             throw new IllegalArgumentException("O peso do animal deve ser maior que zero.");
        }
        if (animal.getCpfCliente() == null || animal.getCpfCliente().trim().isEmpty()) {
            throw new IllegalArgumentException("O animal deve estar associado a um cliente (CPF do cliente é obrigatório).");
        }

        try {
            animalDAO.inserir(animal);
        } catch (RuntimeException e) {
            System.err.println("Erro no Service ao cadastrar animal: " + e.getMessage());
            throw new RuntimeException("Erro ao cadastrar animal. Tente novamente mais tarde.", e);
        }
    }

    public Animal buscarAnimalPorId(int idAnimal) {
        try {
            return animalDAO.buscarPorId(idAnimal);
        } catch (RuntimeException e) {
            System.err.println("Erro no Service ao buscar animal por ID: " + e.getMessage());
            throw new RuntimeException("Erro ao buscar animal. Tente novamente mais tarde.", e);
        }
    }

    public List<Animal> listarAnimaisPorCliente(String cpfCliente) {
        try {
            return animalDAO.buscarAnimaisPorCpfCliente(cpfCliente);
        } catch (RuntimeException e) {
            System.err.println("Erro no Service ao listar animais do cliente: " + e.getMessage());
            throw new RuntimeException("Erro ao listar seus animais. Tente novamente mais tarde.", e);
        }
    }

    public void atualizarAnimal(Animal animal) {
        if (animal.getIdAnimal() <= 0) {
            throw new IllegalArgumentException("ID do animal inválido para atualização.");
        }
        if (animal.getNome() == null || animal.getNome().trim().isEmpty()) {
            throw new IllegalArgumentException("O nome do animal é obrigatório.");
        }
        if (animal.getEspecie() == null || (!animal.getEspecie().equals("Cão") && !animal.getEspecie().equals("Gato"))) {
             throw new IllegalArgumentException("A espécie do animal deve ser 'Cão' ou 'Gato'.");
        }
        if (animal.getPeso() <= 0) {
             throw new IllegalArgumentException("O peso do animal deve ser maior que zero.");
        }
        if (animal.getCpfCliente() == null || animal.getCpfCliente().trim().isEmpty()) {
            throw new IllegalArgumentException("O animal deve estar associado a um cliente para ser atualizado.");
        }

        try {
            animalDAO.atualizar(animal);
        } catch (RuntimeException e) {
            System.err.println("Erro no Service ao atualizar animal: " + e.getMessage());
            throw new RuntimeException("Erro ao atualizar animal. Tente novamente mais tarde.", e);
        }
    }

    public void deletarAnimal(int idAnimal, String cpfCliente) {
        if (idAnimal <= 0) {
            throw new IllegalArgumentException("ID do animal inválido para exclusão.");
        }
        if (cpfCliente == null || cpfCliente.trim().isEmpty()) {
            throw new IllegalArgumentException("CPF do cliente é obrigatório para exclusão segura.");
        }

        try {
            Animal animal = animalDAO.buscarPorId(idAnimal);
            if (animal == null || !animal.getCpfCliente().equals(cpfCliente)) {
                throw new IllegalArgumentException("Você não tem permissão para deletar este animal.");
            }
            animalDAO.deletar(idAnimal);
        } catch (RuntimeException e) {
            System.err.println("Erro no Service ao deletar animal: " + e.getMessage());
            throw new RuntimeException("Erro ao deletar animal. Tente novamente mais tarde.", e);
        }
    }
}