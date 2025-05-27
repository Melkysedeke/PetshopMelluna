<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.melluna.model.Cliente" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meus Dados - PetShop Melluna 🐾</title>
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
            --danger-color: #dc3545;
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
            max-width: 700px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            margin-bottom: 20px;
            border-bottom: 1px solid var(--secondary-color);
        }

        h1 {
            color: var(--primary-color);
            font-size: 2em;
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

        .back-button {
            background-color: var(--accent-color);
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

        .back-button:hover {
            background-color: #7A4E7A;
            transform: translateY(-1px);
        }

        .main-content {
            background-color: var(--card-bg);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 700px;
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 25px;
        }

        .form-group {
            width: 100%;
            margin-bottom: 15px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: var(--text-color);
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            font-size: 1em;
            color: var(--text-color);
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-group input[type="text"]:focus,
        .form-group input[type="email"]:focus,
        .form-group input[type="password"]:focus {
            border-color: var(--focus-border-color);
            box-shadow: 0 0 0 3px rgba(163, 106, 159, 0.2);
            outline: none;
        }

        .form-group input[readonly] {
            background-color: var(--bg-light-color);
            cursor: not-allowed;
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

        .button-group {
            display: flex;
            justify-content: space-between; /* Ajuste para espaçar os botões */
            width: 100%;
            max-width: 550px; /* Ajuste a largura conforme necessário */
            gap: 15px; /* Espaço entre os botões */
            margin-top: 10px;
        }

        .submit-button, .delete-button {
            padding: 12px 25px;
            border-radius: 25px;
            font-size: 1.1em;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            flex-grow: 1;
            text-align: center;
            border: none;
        }

        .submit-button {
            background-color: var(--primary-color);
            color: var(--light-text-color);
        }

        .submit-button:hover {
            background-color: #FF6B93;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .delete-button {
            background-color: var(--danger-color);
            color: var(--light-text-color);
        }

        .delete-button:hover {
            background-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        footer {
            margin-top: 30px;
            color: var(--text-color);
            font-size: 0.8em;
        }
    </style>
</head>
<body>
    <%
        Cliente clienteLogado = (Cliente) session.getAttribute("clienteLogado");
        if (clienteLogado == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        String mensagemSucesso = (String) request.getAttribute("mensagemSucesso");
        String mensagemErro = (String) request.getAttribute("mensagemErro");
    %>

    <div class="header">
        <h1>Meus Dados <i class="fas fa-user-circle icon"></i></h1>
        <a href="<%= request.getContextPath() %>/AnimalController?acao=listar" class="back-button">
            <i class="fas fa-arrow-left"></i> Voltar
        </a>
    </div>

    <div class="main-content">
        <% if (mensagemSucesso != null) { %>
            <div class="message success"><%= mensagemSucesso %></div>
        <% } %>
        <% if (mensagemErro != null) { %>
            <div class="message error"><%= mensagemErro %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/ClienteController" method="post">
            <input type="hidden" name="acao" value="atualizarPerfil">

            <div class="form-group">
                <label for="cpf">CPF:</label>
                <input type="text" id="cpf" name="cpf" value="<%= clienteLogado.getCpf() %>" readonly>
            </div>

            <div class="form-group">
                <label for="nome">Nome Completa:</label>
                <input type="text" id="nome" name="nome" value="<%= clienteLogado.getNome() %>" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= clienteLogado.getEmail() %>" required>
            </div>

            <div class="form-group">
                <label for="endereco">Endereço:</label>
                <input type="text" id="endereco" name="endereco" value="<%= clienteLogado.getEndereco() %>">
            </div>

            <div class="form-group">
                <label for="fidelidade">Fidelidade (Agendamentos Finalizados):</label>
                <input type="text" id="fidelidade" name="fidelidade" value="<%= clienteLogado.getFidelidade() %>" readonly>
            </div>

            <div class="form-group">
                <label for="senha">Nova Senha:</label>
                <input type="password" id="senha" name="senha" placeholder="Deixe em branco para não alterar">
                <small style="color: #666; font-size: 0.85em; margin-top: 5px; display: block;">Preencha apenas se deseja alterar sua senha.</small>
            </div>

            <div class="button-group">
                <button type="submit" class="submit-button">Salvar Alterações</button>
                <button type="button" class="delete-button" onclick="confirmarDelecao()">Deletar Conta</button>
            </div>
        </form>
    </div>

    <footer>
        &copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> PetShop AmigoFiel. Todos os direitos reservados.
    </footer>

    <script>
        function confirmarDelecao() {
            if (confirm("ATENÇÃO: Deletar sua conta é uma ação irreversível. Todos os seus dados, incluindo seus animais e agendamentos, serão removidos. Deseja realmente continuar?")) {
                var form = document.createElement('form');
                form.setAttribute('method', 'post');
                form.setAttribute('action', '<%= request.getContextPath() %>/ClienteController');

                var hiddenField = document.createElement('input');
                hiddenField.setAttribute('type', 'hidden');
                hiddenField.setAttribute('name', 'acao');
                hiddenField.setAttribute('value', 'deletarCliente');
                form.appendChild(hiddenField);

                var hiddenCpfField = document.createElement('input');
                hiddenCpfField.setAttribute('type', 'hidden');
                hiddenCpfField.setAttribute('name', 'cpf');
                hiddenCpfField.setAttribute('value', '<%= clienteLogado.getCpf() %>');
                form.appendChild(hiddenCpfField);

                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>