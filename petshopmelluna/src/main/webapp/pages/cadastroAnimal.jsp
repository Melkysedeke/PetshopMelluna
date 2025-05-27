<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.melluna.model.Cliente" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Novo Animal - PetShop AmigoFiel 🐾</title>
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

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr; /* Duas colunas */
            gap: 15px 20px; /* Espaçamento entre linhas e colunas */
            width: 100%;
        }

        .form-group {
            text-align: left;
            margin-bottom: 0; /* Remover margem inferior padrão para usar o gap do grid */
        }

        .form-group.full-width {
            grid-column: 1 / -1; /* Ocupa todas as colunas */
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: var(--text-color);
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select,
        .form-group textarea {
            width: calc(100% - 20px); /* Ajuste para padding */
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            font-size: 1em;
            color: var(--text-color);
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-group input[type="text"]:focus,
        .form-group input[type="number"]:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: var(--focus-border-color);
            box-shadow: 0 0 0 3px rgba(163, 106, 159, 0.2);
            outline: none;
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

        .submit-button {
            background-color: var(--primary-color);
            color: var(--light-text-color);
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            font-size: 1.1em;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            width: 100%;
            max-width: 250px;
            margin-top: 10px;
        }

        .submit-button:hover {
            background-color: #FF6B93;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        footer {
            margin-top: 30px;
            color: var(--text-color);
            font-size: 0.8em;
        }

        /* Responsividade para telas menores */
        @media (max-width: 550px) {
            .form-grid {
                grid-template-columns: 1fr; /* Uma coluna em telas menores */
                gap: 15px;
            }
            .form-group.full-width {
                grid-column: auto; /* Reseta para uma coluna */
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

        String mensagemSucesso = (String) request.getAttribute("mensagemSucesso");
        String mensagemErro = (String) request.getAttribute("mensagemErro");
    %>

    <div class="header">
        <h1>Cadastrar Animal <i class="fas fa-paw icon"></i></h1>
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

        <form action="<%= request.getContextPath() %>/AnimalController" method="post">
            <input type="hidden" name="acao" value="cadastrar">
            <input type="hidden" name="cpfCliente" value="<%= clienteLogado.getCpf() %>">

            <div class="form-grid">
                <div class="form-group">
                    <label for="nome">Nome do Animal:</label>
                    <input type="text" id="nome" name="nome" required>
                </div>

                <div class="form-group">
                    <label for="especie">Espécie:</label>
                    <select id="especie" name="especie" required>
                        <option value="">Selecione...</option>
                        <option value="Cão">Cão</option>
                        <option value="Gato">Gato</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="raca">Raça:</label>
                    <input type="text" id="raca" name="raca">
                </div>

                <div class="form-group">
                    <label for="peso">Peso (kg):</label>
                    <input type="number" id="peso" name="peso" step="0.01" min="0.1" required>
                </div>

                <div class="form-group full-width">
                    <label for="obs">Observações (opcional):</label>
                    <textarea id="obs" name="obs" rows="3"></textarea>
                </div>
            </div>

            <button type="submit" class="submit-button">Cadastrar Animal</button>
        </form>
    </div>

    <footer>
        &copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> PetShop AmigoFiel. Todos os direitos reservados.
    </footer>
</body>
</html>