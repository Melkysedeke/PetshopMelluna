<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.melluna.model.Cliente" %>
<%@ page import="br.com.melluna.model.Animal" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>


<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel do Cliente - PetShop Melluna 🐾</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #FF8BA7;
            --secondary-color: #FFC0CB;
            --accent-color: #A36A9F;
            --text-color: #333333;
            --light-text-color: #FFFFFF;
            --bg-light-color: #F8F8F8;
            --bg-dark-color: #FFF0F5;
            --border-color: #E0E0E0;
            --focus-border-color: var(--accent-color);
            --card-bg: #FFFFFF;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-dark-color);
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
            box-sizing: border-box;
            color: var(--text-color);
            text-align: center;
        }

        .header {
            width: 100%;
            max-width: 900px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            margin-bottom: 20px;
            border-bottom: 1px solid var(--secondary-color);
        }

        h1 {
            color: var(--primary-color);
            font-size: 2.2em;
            font-weight: 700;
            letter-spacing: 1px;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        h1 .icon {
            color: var(--accent-color);
            font-size: 0.9em;
        }

        .logout-button {
            background-color: #dc3545;
            color: var(--light-text-color);
            border: none;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .logout-button:hover {
            background-color: #c82333;
            transform: translateY(-1px);
        }

        .main-content {
            background-color: var(--card-bg);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 25px;
        }

        .welcome-message {
            font-size: 1.3em;
            color: var(--text-color);
            margin-bottom: 15px;
            font-weight: 600;
        }

        .welcome-message span {
            color: var(--primary-color);
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            width: 100%;
            margin-bottom: 20px;
        }

        .menu-item {
            background-color: var(--secondary-color);
            color: var(--text-color);
            padding: 20px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1em;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            text-align: center;
            cursor: pointer;
        }

        .menu-item:hover {
            background-color: var(--primary-color);
            color: var(--light-text-color);
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }

        .menu-item .icon {
            font-size: 2em;
            color: var(--accent-color);
            transition: color 0.3s ease;
        }

        .menu-item:hover .icon {
            color: var(--light-text-color);
        }

        .section-title {
            color: var(--accent-color);
            font-size: 1.8em;
            margin-top: 30px;
            margin-bottom: 20px;
            width: 100%;
            text-align: left;
            border-bottom: 1px solid var(--secondary-color);
            padding-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .section-title h3 {
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .add-button {
            background-color: var(--primary-color);
            color: var(--light-text-color);
            border: none;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .add-button:hover {
            background-color: #FF6B93;
            transform: translateY(-1px);
        }

        .animal-list-container { /* Novo container para a lista de animais */
            width: 100%;
            margin-top: 15px;
            text-align: left;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); /* 2 colunas em telas maiores, ou mais */
            gap: 20px;
        }

        .animal-card {
            background-color: var(--bg-light-color);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 15px 20px;
            display: flex;
            flex-direction: column;
            gap: 5px;
            text-align: left;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            position: relative; /* Para posicionar os botões de ação */
        }

        .animal-card strong {
            color: var(--primary-color);
            font-size: 1em;
        }

        .animal-card p {
            margin: 0;
            font-size: 0.95em;
        }

        .animal-actions {
            position: absolute;
            top: 10px;
            right: 10px;
            display: flex;
            gap: 8px;
        }

        .animal-actions .action-button {
            background: none;
            border: none;
            font-size: 1.2em;
            cursor: pointer;
            color: var(--accent-color);
            transition: color 0.2s ease;
        }

        .animal-actions .action-button.edit:hover {
            color: #28a745; /* Verde para editar */
        }

        .animal-actions .action-button.delete:hover {
            color: #dc3545; /* Vermelho para deletar */
        }

        .no-animals-message {
            font-style: italic;
            color: #777;
            padding: 20px;
            border: 1px dashed var(--border-color);
            border-radius: 8px;
            margin-top: 10px;
            grid-column: 1 / -1; /* Ocupa todas as colunas no grid */
        }

        .message {
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            width: 100%;
            font-weight: 500;
            text-align: center;
        }

        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .history-section {
            width: 100%;
            text-align: left;
            margin-top: 30px;
        }

        .history-section h3 {
            color: var(--primary-color);
            font-size: 1.6em;
            margin-bottom: 15px;
            border-bottom: 2px solid var(--secondary-color);
            padding-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .appointment-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
        }

        .appointment-item {
            background-color: var(--bg-light-color);
            border: 1px solid var(--border-color);
            padding: 12px;
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            gap: 0px;
            text-align: left;
            font-size: 0.85em;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }

        .appointment-item strong {
            color: var(--accent-color);
            font-size: 1em;
            margin-bottom: 0px;
        }

        .appointment-item span {
            color: var(--text-color);
            margin-bottom: 0px;
        }

        .no-appointments {
            color: var(--text-color);
            font-style: italic;
            padding: 20px;
            border: 1px dashed var(--border-color);
            border-radius: 8px;
            margin-top: 10px;
            grid-column: 1 / -1;
        }

        footer {
            margin-top: 30px;
            color: var(--text-color);
            font-size: 0.8em;
        }

        /* Responsividade */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            .logout-button {
                align-self: flex-end;
            }
            .welcome-message {
                font-size: 1.1em;
            }
            .menu-grid {
                grid-template-columns: 1fr 1fr;
            }
            .menu-item {
                font-size: 1em;
                padding: 15px;
            }
            .menu-item .icon {
                font-size: 1.8em;
            }
            .section-title {
                flex-direction: column;
                align-items: flex-start;
            }
            .section-title h3 {
                margin-bottom: 10px;
            }
            .add-button {
                width: 100%;
                text-align: center;
                justify-content: center;
            }
            .animal-list-container {
                grid-template-columns: 1fr; /* Uma coluna em telas menores para a lista de animais */
            }
            .appointment-list {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            }
            .appointment-item {
                padding: 10px;
                font-size: 0.8em;
            }
        }

        @media (max-width: 480px) {
            .menu-grid {
                grid-template-columns: 1fr;
            }
            h1 {
                font-size: 1.8em;
            }
            .logout-button {
                font-size: 0.8em;
                padding: 6px 12px;
            }
            .appointment-list {
                grid-template-columns: 1fr;
            }
            .appointment-item {
                font-size: 0.85em;
            }
        }
    </style>
</head>
<body>
    <%
        Cliente clienteLogado = (Cliente) session.getAttribute("clienteLogado");

        if (clienteLogado == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        List<Animal> animaisDoCliente = (List<Animal>) request.getAttribute("animaisDoCliente");
        if (animaisDoCliente == null) {
             animaisDoCliente = new ArrayList<>();
        }

        List<String[]> agendamentos = new ArrayList<>();
        agendamentos.add(new String[]{"Toby", "Banho e Tosa", "2025-06-10", "14:00", "R$ 85,00"});
        agendamentos.add(new String[]{"Mia", "Consulta Veterinária", "2025-06-15", "10:30", "R$ 120,00"});
        agendamentos.add(new String[]{"Rex", "Vacinação", "2025-07-01", "09:00", "R$ 90,00"});
        agendamentos.add(new String[]{"Luna", "Check-up Geral", "2025-07-05", "11:00", "R$ 150,00"});
        agendamentos.add(new String[]{"Biscoito", "Banho", "2025-07-12", "16:00", "R$ 60,00"});

        String mensagemSucesso = (String) request.getAttribute("mensagemSucesso");
        String mensagemErro = (String) request.getAttribute("mensagemErro");
    %>

    <div class="header">
        <h1>Olá, <%= clienteLogado.getNome() %>! <i class="fas fa-smile icon"></i></h1>
        <a href="<%= request.getContextPath() %>/ClienteController?acao=logout" class="logout-button">
            <i class="fas fa-sign-out-alt"></i> Sair
        </a>
    </div>

    <div class="main-content">
        <p class="welcome-message">Bem-vindo(a) ao seu painel, <span><%= clienteLogado.getNome() %></span>. Aqui você gerencia tudo sobre seus pets e agendamentos!</p>

        <% if (mensagemSucesso != null) { %>
            <div class="message success"><%= mensagemSucesso %></div>
        <% } %>
        <% if (mensagemErro != null) { %>
            <div class="message error"><%= mensagemErro %></div>
        <% } %>

        <div class="menu-grid">
            <%-- "Meus Animais" foi removido pois a lista já aparece diretamente --%>
            <a href="<%= request.getContextPath() %>/pages/fazerAgendamento.jsp" class="menu-item">
                <i class="fas fa-calendar-alt icon"></i>
                Fazer Agendamento
            </a>
            <a href="<%= request.getContextPath() %>/ClienteController?acao=carregarPerfil" class="menu-item">
                <i class="fas fa-user icon"></i>
                Meus Dados
            </a>
            <div class="menu-item disabled-link">
                <i class="fas fa-history icon"></i>
                Meus Agendamentos
            </div>
        </div>

        <div class="section-title">
            <h3>Seus Animais Cadastrados <i class="fas fa-dog icon"></i></h3>
            <a href="<%= request.getContextPath() %>/AnimalController?acao=cadastrarForm" class="add-button">
                <i class="fas fa-plus-circle"></i> Cadastrar Novo
            </a>
        </div>
        <div class="animal-list-container">
            <% if (!animaisDoCliente.isEmpty()) { %>
                <% for (Animal animal : animaisDoCliente) { %>
                    <div class="animal-card">
                        <div class="animal-actions">
                            <a href="<%= request.getContextPath() %>/AnimalController?acao=editarForm&id=<%= animal.getIdAnimal() %>" class="action-button edit" title="Editar">
                                <i class="fas fa-edit"></i>
                            </a>
                            <form action="<%= request.getContextPath() %>/AnimalController" method="post" style="display:inline;" onsubmit="return confirm('Tem certeza que deseja excluir o animal <%= animal.getNome() %>?');">
                                <input type="hidden" name="acao" value="deletar">
                                <input type="hidden" name="idAnimal" value="<%= animal.getIdAnimal() %>">
                                <button type="submit" class="action-button delete" title="Excluir">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </form>
                        </div>
                        <p><strong>Nome:</strong> <%= animal.getNome() %></p>
                        <p><strong>Espécie:</strong> <%= animal.getEspecie() %></p>
                        <p><strong>Raça:</strong> <%= animal.getRaca() != null && !animal.getRaca().isEmpty() ? animal.getRaca() : "Não informada" %></p>
                        <p><strong>Peso:</strong> <%= animal.getPeso() %> kg</p>
                        <p><strong>Obs:</strong> <%= animal.getObs() != null && !animal.getObs().isEmpty() ? animal.getObs() : "Nenhuma" %></p>
                    </div>
                <% } %>
            <% } else { %>
                <p class="no-animals-message">Você ainda não tem animais cadastrados. Que tal <a href="<%= request.getContextPath() %>/AnimalController?acao=cadastrarForm">cadastrar um agora</a>?</p>
            <% } %>
        </div>

        <div class="history-section">
            <h3>Histórico de Agendamentos <i class="fas fa-clipboard-list icon"></i></h3>
            <ul class="appointment-list">
                <% if (agendamentos.isEmpty()) { %>
                    <p class="no-appointments">Você ainda não possui agendamentos. <a href="<%= request.getContextPath() %>/pages/fazerAgendamento.jsp">Que tal agendar um serviço agora?</a></p>
                <% } else { %>
                    <% for (String[] agendamento : agendamentos) { %>
                        <li class="appointment-item">
                            <strong>Animal:</strong> <span><%= agendamento[0] %></span><br>
                            <strong>Serviço:</strong> <span><%= agendamento[1] %></span><br>
                            <strong>Data:</strong> <span><%= agendamento[2] %></span><br>
                            <strong>Hora:</strong> <span><%= agendamento[3] %></span><br>
                            <strong>Valor:</strong> <span><%= agendamento[4] %></span>
                        </li>
                    <% } %>
                <% } %>
            </ul>
        </div>
    </div>

    <footer>
        &copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> PetShop Melluna. Todos os direitos reservados.
    </footer>
    <script>
        // Script para a confirmação de exclusão
        document.addEventListener('DOMContentLoaded', function() {
            const deleteForms = document.querySelectorAll('form[action$="AnimalController"][method="post"]');
            deleteForms.forEach(form => {
                if (form.querySelector('input[name="acao"]').value === 'deletar') {
                    form.addEventListener('submit', function(event) {
                        const animalNome = this.querySelector('p strong').nextSibling.textContent.trim(); // Ajustado para pegar o nome
                        if (!confirm('Tem certeza que deseja excluir o animal ' + animalNome + '?')) {
                            event.preventDefault();
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>