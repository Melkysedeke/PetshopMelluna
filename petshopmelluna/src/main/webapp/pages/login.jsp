<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - PetShop Melluna 🐾</title>
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
            --error-color: #DC3545; /* Cor para mensagens de erro */
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-dark-color);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            padding: 15px;
            box-sizing: border-box;
            color: var(--text-color);
            text-align: center;
        }

        .container {
            background-color: var(--light-text-color);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 450px; /* Mantém a largura consistente com o cadastro */
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }

        h2 {
            color: var(--primary-color);
            font-size: 1.8em;
            margin-bottom: 10px;
            font-weight: 700;
            letter-spacing: 0.8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        h2 .icon {
            color: var(--accent-color);
            font-size: 0.8em;
        }

        .error-message {
            color: var(--error-color);
            font-size: 0.9em;
            margin-bottom: 15px;
            text-align: center;
            padding: 8px 15px;
            border-radius: 5px;
            background-color: rgba(220, 53, 69, 0.1);
            border: 1px solid var(--error-color);
        }

        form {
            display: flex;
            flex-direction: column;
            width: 100%;
            gap: 10px;
        }

        .form-group {
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 3px;
            font-weight: 600;
            color: var(--text-color);
            font-size: 0.9em; /* Ajuste para melhor legibilidade */
        }

        input {
            width: calc(100% - 20px);
            padding: 8px 10px; /* Ajuste para melhor usabilidade */
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 1em; /* Ajuste para melhor legibilidade */
            color: var(--text-color);
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: var(--focus-border-color);
            box-shadow: 0 0 0 3px rgba(163, 106, 159, 0.2);
        }

        .botao {
            margin-top: 15px;
            background-color: var(--primary-color);
            color: var(--light-text-color);
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            width: 100%;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .botao:hover {
            background-color: var(--accent-color);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        .botao .icon {
            font-size: 1.1em;
        }

        .link-text {
            margin-top: 10px;
            font-size: 0.9em;
            color: var(--text-color);
        }

        .link-text a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .link-text a:hover {
            color: var(--accent-color);
            text-decoration: underline;
        }

        /* Responsividade (media queries para telas maiores) */
        @media (min-width: 600px) {
            .container {
                padding: 30px;
                max-width: 400px;
            }
            h2 {
                font-size: 2em;
            }
            label {
                font-size: 1em;
            }
            input {
                padding: 10px;
                font-size: 1em;
            }
            .botao {
                padding: 12px 25px;
                font-size: 1.05em;
            }
            .link-text {
                font-size: 0.95em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login de Cliente <i class="fas fa-sign-in-alt icon"></i></h2>

        <%
            // Verifica se há uma mensagem de erro vinda do ClienteController
            String mensagemErro = (String) request.getAttribute("mensagemErro");
            if (mensagemErro != null) {
        %>
                <p class="error-message"><i class="fas fa-exclamation-triangle"></i> <%= mensagemErro %></p>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/ClienteController" method="post">
            <input type="hidden" name="acao" value="login">

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email" required>
            </div>

            <div class="form-group">
                <label for="senha">Senha:</label>
                <input type="password" name="senha" id="senha" required>
            </div>

            <button type="submit" class="botao">
                <i class="fas fa-sign-in-alt icon"></i> Entrar
            </button>
        </form>
        <p class="link-text">Não tem cadastro? <a href="<%= request.getContextPath() %>/pages/cadastroCliente.jsp">Cadastre-se aqui</a></p>
        <p class="link-text"><a href="../index.jsp">Voltar à página inicial</a></p>
    </div>
</body>
</html>