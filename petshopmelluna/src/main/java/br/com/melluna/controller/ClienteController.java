package br.com.melluna.controller;

import java.io.IOException;

import br.com.melluna.model.Cliente;
import br.com.melluna.service.ClienteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ClienteController")
public class ClienteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ClienteService clienteService;

    @Override
    public void init() throws ServletException {
        super.init();
        clienteService = new ClienteService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        HttpSession session = request.getSession();
        String contextPath = request.getContextPath();

        try {
            switch (acao) {
                case "cadastrar":
                    Cliente novoCliente = new Cliente();
                    novoCliente.setNome(request.getParameter("nome"));
                    novoCliente.setCpf(request.getParameter("cpf"));
                    novoCliente.setEndereco(request.getParameter("endereco"));
                    novoCliente.setEmail(request.getParameter("email"));
                    novoCliente.setSenha(request.getParameter("senha"));
                    novoCliente.setFidelidade(0);

                    clienteService.cadastrarCliente(novoCliente);

                    session.setAttribute("clienteLogado", novoCliente);
                    response.sendRedirect(contextPath + "/pages/painelCliente.jsp");
                    break;
                case "login":
                    String emailLogin = request.getParameter("email");
                    String senhaLogin = request.getParameter("senha");

                    Cliente clienteAutenticado = clienteService.autenticarCliente(emailLogin, senhaLogin);

                    if (clienteAutenticado != null) {
                        session.setAttribute("clienteLogado", clienteAutenticado);
                        response.sendRedirect(contextPath + "/AnimalController?acao=listar");
                    } else {
                        request.setAttribute("mensagemErro", "Email ou senha inválidos.");
                        request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
                    }
                    break;
                case "logout":
                    session.invalidate();
                    response.sendRedirect(contextPath + "/index.jsp");
                    break;

                case "atualizarPerfil":
                    Cliente clienteLogado = (Cliente) session.getAttribute("clienteLogado");
                    if (clienteLogado == null) {
                        response.sendRedirect(contextPath + "/pages/login.jsp");
                        return;
                    }

                    clienteLogado.setNome(request.getParameter("nome"));
                    clienteLogado.setEndereco(request.getParameter("endereco"));
                    clienteLogado.setEmail(request.getParameter("email"));

                    String novaSenha = request.getParameter("senha");
                    if (novaSenha != null && !novaSenha.isEmpty()) {
                        clienteLogado.setSenha(novaSenha);
                    }

                    clienteService.atualizarCliente(clienteLogado);

                    session.setAttribute("clienteLogado", clienteLogado);
                    request.setAttribute("mensagemSucesso", "Perfil atualizado com sucesso!");
                    request.getRequestDispatcher("/pages/meusDados.jsp").forward(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação inválida!");
                    break;
            }
        } catch (RuntimeException e) {
            e.printStackTrace();
            request.setAttribute("mensagemErro", "Ocorreu um erro no servidor: " + e.getMessage());
            if ("cadastrar".equals(acao)) {
                request.getRequestDispatcher("/pages/cadastro.jsp").forward(request, response);
            } else if ("login".equals(acao)) {
                request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            } else if ("atualizarPerfil".equals(acao)) {
                request.getRequestDispatcher("/pages/meusDados.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor.");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        HttpSession session = request.getSession(false);
        String contextPath = request.getContextPath(); 

        if ("logout".equals(acao)) {
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(contextPath + "/index.jsp");
        } else if ("carregarPerfil".equals(acao)) {
            Cliente clienteLogado = (Cliente) session.getAttribute("clienteLogado");
            if (clienteLogado == null) {
                response.sendRedirect(contextPath + "/pages/login.jsp");
                return;
            }
            try {
                Cliente clienteAtualizado = clienteService.buscarClientePorCpf(clienteLogado.getCpf());
                session.setAttribute("clienteLogado", clienteAtualizado);
            } catch (RuntimeException e) {
                request.setAttribute("mensagemErro", "Erro ao carregar dados do perfil: " + e.getMessage());
                e.printStackTrace();
            }
            request.getRequestDispatcher("/pages/meusDados.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Requisição GET não suportada ou ação inválida.");
        }
    }
}