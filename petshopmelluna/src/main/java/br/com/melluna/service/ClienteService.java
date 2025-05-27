package br.com.melluna.service;

import br.com.melluna.DAO.ClienteDAO;
import br.com.melluna.model.Cliente;

public class ClienteService {

    private ClienteDAO clienteDAO;

    public ClienteService() {
        this.clienteDAO = new ClienteDAO();
    }

    public void cadastrarCliente(Cliente cliente) {
        try {
            clienteDAO.inserir(cliente);
        } catch (RuntimeException e) {
            throw new RuntimeException("Erro ao cadastrar cliente: " + e.getMessage(), e);
        }
    }

    public Cliente autenticarCliente(String email, String senha) {
        try {
            Cliente cliente = clienteDAO.buscarPorEmail(email);
            if (cliente != null && cliente.getSenha().equals(senha)) {
                return cliente;
            }
            return null;
        } catch (RuntimeException e) {
            throw new RuntimeException("Erro ao autenticar cliente: " + e.getMessage(), e);
        }
    }

    public Cliente buscarClientePorCpf(String cpf) {
        try {
            return clienteDAO.buscarPorCpf(cpf);
        } catch (RuntimeException e) {
            throw new RuntimeException("Erro ao buscar cliente por CPF: " + e.getMessage(), e);
        }
    }

    public void atualizarCliente(Cliente clienteAtualizado) {
        try {
            clienteDAO.atualizar(clienteAtualizado);
        } catch (RuntimeException e) {
            throw new RuntimeException("Erro ao atualizar cliente: " + e.getMessage(), e);
        }
    }

    public void deletarCliente(String cpf) {
        try {
            clienteDAO.deletar(cpf);
        } catch (RuntimeException e) {
            throw new RuntimeException("Erro ao deletar cliente: " + e.getMessage(), e);
        }
    }
}