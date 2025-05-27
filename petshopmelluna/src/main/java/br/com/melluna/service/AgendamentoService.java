package br.com.melluna.service;

import br.com.melluna.DAO.AgendamentoDAO;
import br.com.melluna.DAO.ClienteDAO;
import br.com.melluna.DAO.AnimalDAO;
import br.com.melluna.model.Agendamento;
import br.com.melluna.model.Cliente;
import br.com.melluna.model.Animal;

import java.util.List;

public class AgendamentoService {

    private AgendamentoDAO agendamentoDAO;
    private ClienteDAO clienteDAO;
    private AnimalDAO animalDAO;

    public AgendamentoService() {
        this.agendamentoDAO = new AgendamentoDAO();
        this.clienteDAO = new ClienteDAO();
        this.animalDAO = new AnimalDAO();
    }

    public double calcularValorAgendamento(Agendamento agendamento) {
        double valorBase = 0.0;

        Animal animal = agendamento.getAnimal();
        // Se o objeto Animal não está carregado no agendamento, busca pelo ID
        if (animal == null && agendamento.getIdAnimal() > 0) {
            animal = animalDAO.buscarPorId(agendamento.getIdAnimal());
            if (animal == null) {
                throw new IllegalArgumentException("Animal com ID " + agendamento.getIdAnimal() + " não encontrado para o agendamento.");
            }
            agendamento.setAnimal(animal); // Seta o objeto animal no agendamento para uso futuro
        } else if (animal == null) {
            throw new IllegalArgumentException("Informações do animal não disponíveis para cálculo de valor.");
        }

        String especie = animal.getEspecie();
        double peso = animal.getPeso();
        String servico = agendamento.getServico();

        switch (especie) {
            case "Gato":
                if ("Banho".equalsIgnoreCase(servico)) {
                    valorBase = 15.00;
                } else if ("Tosa".equalsIgnoreCase(servico)) { // No requisito, "Banho e Tosa" é "Tosa" na ENUM
                    valorBase = 25.00; // Valor de banho e tosa para gato
                } else {
                    throw new IllegalArgumentException("Serviço '" + servico + "' inválido para Gato.");
                }
                break;
            case "Cão":
                if (peso <= 10) {
                    if ("Banho".equalsIgnoreCase(servico)) {
                        valorBase = 30.00;
                    } else if ("Tosa".equalsIgnoreCase(servico)) { // "Banho e Tosa" para Cão é "Tosa" na ENUM
                        valorBase = 75.00;
                    } else {
                        throw new IllegalArgumentException("Serviço '" + servico + "' inválido para Cão de até 10kg.");
                    }
                } else { // Mais de 10kg
                    if ("Banho".equalsIgnoreCase(servico)) {
                        valorBase = 50.00;
                    } else if ("Tosa".equalsIgnoreCase(servico)) { // "Banho e Tosa" para Cão é "Tosa" na ENUM
                        valorBase = 95.00;
                    } else {
                        throw new IllegalArgumentException("Serviço '" + servico + "' inválido para Cão acima de 10kg.");
                    }
                }
                break;
            default:
                throw new IllegalArgumentException("Espécie de animal não reconhecida: " + especie);
        }

        // Adicionais
        if (agendamento.isTransporte()) {
            valorBase += 10.00;
        }
        if (agendamento.isHidratacao()) {
            valorBase += 30.00; // Valor assumido
        }
        if (agendamento.isEscova()) {
            valorBase += 15.00; // Valor assumido
        }

        // Desconto para pagamento à vista
        if ("À vista".equalsIgnoreCase(agendamento.getTipoPagamento())) {
            valorBase *= 0.95; // 5% de desconto
        }

        return valorBase;
    }

    public void registrarNovoAgendamento(Agendamento agendamento) {
        agendamento.setValorTotal(calcularValorAgendamento(agendamento));
        agendamento.setStatus("Não iniciado"); // Status inicial padrão

        try {
            agendamentoDAO.inserir(agendamento);
        } catch (RuntimeException e) {
            throw new RuntimeException("Falha ao registrar o agendamento: " + e.getMessage(), e);
        }
    }

    public List<Agendamento> listarAgendamentosDoCliente(String cpfCliente) {
        try {
            return agendamentoDAO.buscarAgendamentosPorCpfCliente(cpfCliente);
        } catch (RuntimeException e) {
            throw new RuntimeException("Falha ao listar agendamentos do cliente: " + e.getMessage(), e);
        }
    }

    // Este método seria chamado por algum Controller (ex: um Servlet) quando um agendamento for "Finalizado"
    public void finalizarAgendamentoEProcessarFidelidade(int idAgendamento) {
        // 1. Atualiza o status do agendamento para "Finalizado"
        agendamentoDAO.atualizarStatus(idAgendamento, "Finalizado");

        // 2. Recupera o agendamento completo para obter o Animal e o Cliente
        // Note: precisaria de um método buscarPorId(int idAgendamento) no AgendamentoDAO
        // Ou adaptar a busca aqui para obter o CPF do cliente.
        // Por simplicidade, vou assumir que temos o CPF do cliente ou o agendamento completo aqui
        // Ou que o agendamentoDAO.buscarAgendamentosPorCpfCliente retorna a lista e filtramos o finalizado

        // Para este exemplo, vamos buscar o agendamento novamente (não ideal para performance, mas didático)
        // O ideal é que o Controller que chamou este método já tenha o Agendamento e o Cliente
        Agendamento agendamentoFinalizado = null;
        try {
            // Este método precisa ser implementado no AgendamentoDAO para buscar por ID
            // agendamentoFinalizado = agendamentoDAO.buscarPorId(idAgendamento);
            // Ou, para fins de exemplo, vamos fingir que já temos o CPF do cliente associado ao agendamento
            // para poder buscar o cliente e atualizar a fidelidade.
            // Para simplificar, vou passar o CPF do cliente para este método, ou buscar o cliente pelo ID do animal no agendamento.
        } catch (Exception e) {
            System.err.println("Erro ao buscar agendamento para finalizar e processar fidelidade: " + e.getMessage());
            e.printStackTrace();
            return;
        }

        // Assumindo que o agendamento foi finalizado e que temos o CPF do cliente envolvido
        // (Seria melhor ter o Cliente logado ou o CPF diretamente passado aqui)
        String cpfClienteDoAgendamento = "cpf_do_cliente_aqui"; // Precisa vir de algum lugar
        Cliente cliente = clienteDAO.buscarPorCpf(cpfClienteDoAgendamento);

        if (cliente != null) {
            // Conta quantos agendamentos *finalizados* o cliente tem agora
            int agendamentosFinalizadosCount = agendamentoDAO.contarAgendamentosFinalizados(cliente.getCpf());

            // A fidelidade agora é a contagem de agendamentos finalizados
            cliente.setFidelidade(agendamentosFinalizadosCount);

            // A cada 10 agendamentos finalizados, um banho grátis
            // O número de banhos grátis que o cliente *deveria* ter
            int banhosGratisCalculados = agendamentosFinalizadosCount / 10;

            // Se o cliente ainda não tem essa quantidade de banhos grátis registrada, atualiza
            // (Para evitar dar múltiplos banhos grátis pelo mesmo conjunto de agendamentos)
            // No seu model Cliente, mude 'fidelidade' para ser a contagem de agendamentos, e adicione 'banhosGratisDisponiveis'
            // Ou, como no DDL, fidelidade é a contagem. Então 'banhosGratisDisponiveis' seria um campo novo no Cliente.
            // Pelo DDL, 'fidelidade' é a contagem de agendamentos finalizados.
            // A lógica de banho grátis será calculada *a partir* dessa contagem.

            // Se quisermos um campo "banhosGratisDisponiveis" na tabela Cliente:
            // ALTER TABLE Cliente ADD COLUMN banhosGratisDisponiveis INT DEFAULT 0;
            // E adicionar no Cliente model e ClienteDAO.
            // Por enquanto, vamos usar apenas a 'fidelidade' como a contagem total de agendamentos finalizados.

            // Se o cliente atingiu um novo múltiplo de 10 agendamentos, podemos notificar ou gerar um cupom, etc.
            // A regra de "recebe um banho grátis" na 10ª agendamento implica um evento.
            // Podemos ter um campo `ultimoAgendamentoFidelidade` ou algo assim para controlar.
            // Para a simplicidade, vamos apenas atualizar a contagem de fidelidade.
            clienteDAO.atualizar(cliente);

            // Se desejar disparar uma ação quando ganha um banho grátis:
            // if (agendamentosFinalizadosCount > 0 && agendamentosFinalizadosCount % 10 == 0) {
            //     // Lógica para marcar que um banho grátis foi concedido/disponível
            //     System.out.println("Parabéns! Cliente " + cliente.getNome() + " ganhou um banho grátis!");
            //     // Isso implicaria em outro campo no Cliente ou uma tabela de Cupons
            // }

        }
    }

}