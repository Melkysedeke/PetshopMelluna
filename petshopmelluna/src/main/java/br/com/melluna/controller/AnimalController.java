package br.com.melluna.controller;

import java.io.IOException;
import java.util.List;

import br.com.melluna.model.Animal;
import br.com.melluna.model.Cliente;
import br.com.melluna.service.AnimalService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AnimalController")
public class AnimalController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AnimalService animalService;

    @Override
    public void init() throws ServletException {
        super.init();
        animalService = new AnimalService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        HttpSession session = request.getSession();
        Cliente clienteLogado = (Cliente) session.getAttribute("clienteLogado");

        if (clienteLogado == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        try {
            switch (acao) {
                case "cadastrar":
                    Animal novoAnimal = new Animal();
                    novoAnimal.setNome(request.getParameter("nome"));
                    novoAnimal.setRaca(request.getParameter("raca"));
                    novoAnimal.setEspecie(request.getParameter("especie"));
                    String pesoStr = request.getParameter("peso");
                    if (pesoStr != null && !pesoStr.trim().isEmpty()) {
                        novoAnimal.setPeso(Double.parseDouble(pesoStr));
                    } else {
                        novoAnimal.setPeso(0.0);
                    }
                    novoAnimal.setObs(request.getParameter("obs"));
                    novoAnimal.setCpfCliente(clienteLogado.getCpf());

                    animalService.cadastrarAnimal(novoAnimal);

                    request.setAttribute("mensagemSucesso", "Animal cadastrado com sucesso!");
                    response.sendRedirect(request.getContextPath() + "/AnimalController?acao=listar");
                    break;

                // Nova ação para atualizar animal
                case "atualizar":
                    Animal animalAtualizar = new Animal();
                    animalAtualizar.setIdAnimal(Integer.parseInt(request.getParameter("idAnimal"))); // ID do animal
                    animalAtualizar.setNome(request.getParameter("nome"));
                    animalAtualizar.setRaca(request.getParameter("raca"));
                    animalAtualizar.setEspecie(request.getParameter("especie"));
                    String pesoAtualizarStr = request.getParameter("peso");
                    if (pesoAtualizarStr != null && !pesoAtualizarStr.trim().isEmpty()) {
                        animalAtualizar.setPeso(Double.parseDouble(pesoAtualizarStr));
                    } else {
                        animalAtualizar.setPeso(0.0);
                    }
                    animalAtualizar.setObs(request.getParameter("obs"));
                    animalAtualizar.setCpfCliente(clienteLogado.getCpf()); // Garante que o cliente logado é o dono

                    animalService.atualizarAnimal(animalAtualizar);

                    request.setAttribute("mensagemSucesso", "Dados do animal atualizados com sucesso!");
                    response.sendRedirect(request.getContextPath() + "/AnimalController?acao=listar");
                    break;
                case "deletar":
                    int idAnimalDeletar = Integer.parseInt(request.getParameter("idAnimal"));
                    animalService.deletarAnimal(idAnimalDeletar, clienteLogado.getCpf()); // Passa o CPF para verificação de posse

                    request.setAttribute("mensagemSucesso", "Animal excluído com sucesso!");
                    response.sendRedirect(request.getContextPath() + "/AnimalController?acao=listar");
                    break;

                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação inválida para AnimalController!");
                    break;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("mensagemErro", "Erro no formato de número. Por favor, insira valores válidos.");
            request.getRequestDispatcher("/AnimalController?acao=listar").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("mensagemErro", e.getMessage());
            request.getRequestDispatcher("/AnimalController?acao=listar").forward(request, response);
        } catch (RuntimeException e) {
            e.printStackTrace();
            request.setAttribute("mensagemErro", "Ocorreu um erro no servidor: " + e.getMessage());
            request.getRequestDispatcher("/AnimalController?acao=listar").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        HttpSession session = request.getSession();
        Cliente clienteLogado = (Cliente) session.getAttribute("clienteLogado");

        if (clienteLogado == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        try {
            // Se a ação for nula ou vazia, define como "listar"
            if (acao == null || acao.isEmpty()) {
                acao = "listar";
            }

            switch (acao) {
                case "listar":
                    List<Animal> animais = animalService.listarAnimaisPorCliente(clienteLogado.getCpf());
                    request.setAttribute("animaisDoCliente", animais);
                    request.getRequestDispatcher("/pages/painelCliente.jsp").forward(request, response);
                    break;

                case "cadastrarForm":
                    request.getRequestDispatcher("/pages/cadastroAnimal.jsp").forward(request, response);
                    break;

                case "editarForm":
                    int idAnimalEditar = Integer.parseInt(request.getParameter("id"));
                    Animal animalParaEditar = animalService.buscarAnimalPorId(idAnimalEditar);

                    if (animalParaEditar != null && animalParaEditar.getCpfCliente().equals(clienteLogado.getCpf())) {
                        request.setAttribute("animal", animalParaEditar);
                        request.getRequestDispatcher("/pages/editarAnimal.jsp").forward(request, response);
                    } else {
                        request.setAttribute("mensagemErro", "Animal não encontrado ou você não tem permissão para editá-lo.");
                        response.sendRedirect(request.getContextPath() + "/AnimalController?acao=listar"); 
                    }
                    break;


                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação GET inválida para AnimalController!");
                    break;
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de animal inválido no parâmetro.");
        } catch (RuntimeException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor: " + e.getMessage());
        }
    }
}