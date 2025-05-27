<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bem-vindo ao PetShop Melluna 🐾</title>
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
            padding: 20px;
            box-sizing: border-box;
            color: var(--text-color);
            text-align: center;
        }

        .container {
            background-color: var(--light-text-color);
            padding: 25px 25px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }

        h1 {
            color: var(--primary-color);
            font-size: 2.2em;
            margin-bottom: 10px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        h1 .icon {
            color: var(--accent-color);
            margin-left: 8px;
            font-size: 0.9em;
        }

        .welcome-text {
            font-size: 1em;
            color: var(--text-color);
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 10px;
            width: 100%;
        }

        .botao {
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

        @media (min-width: 768px) {
            .container {
                padding: 35px 35px;
                max-width: 480px;
            }
            .button-group {
                flex-direction: row;
                justify-content: center;
                gap: 15px;
            }
            .botao {
                width: auto;
                padding: 12px 30px;
            }
            h1 {
                font-size: 2.6em;
            }
            .welcome-text {
                font-size: 1.05em;
            }
        }

        footer {
            margin-top: 30px;
            color: var(--text-color);
            font-size: 0.8em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bem-vindo ao PetShop Melluna <i class="fas fa-paw icon"></i></h1>
        <p class="welcome-text">Seu melhor amigo merece o melhor cuidado e atenção. Descubra nossos serviços e produtos!</p>

        <div class="button-group">
            <a href="<%= request.getContextPath() %>/pages/login.jsp" class="botao">
                <i class="fas fa-sign-in-alt icon"></i> Já tenho conta
            </a>
            <a href="<%= request.getContextPath() %>/pages/cadastroCliente.jsp" class="botao">
                <i class="fas fa-user-plus icon"></i> Quero me cadastrar
            </a>
        </div>
    </div>

    <footer>
        &copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> PetShop Melluna. Todos os direitos reservados.
    </footer>
</body>
</html>