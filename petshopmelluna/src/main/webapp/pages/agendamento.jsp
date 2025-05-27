<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="br.com.melluna.model.Animal" %>
<%
  List<Animal> animais = (List<Animal>) request.getAttribute("animais");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Agendamento</title>
  <script>
    function calcular() {
      const tipo = document.getElementById('tipoServico').value;
      const animalSelect = document.getElementById('idAnimal');
      const especie = animalSelect.selectedOptions[0].dataset.especie;
      const peso = parseFloat(animalSelect.selectedOptions[0].dataset.peso);
      const entrega = document.getElementById('entrega').checked;
      const pagamento = document.getElementById('formaPagamento').value;

      let valor = 0;

      if (especie === 'Gato') {
        valor = tipo === 'Banho' ? 15 : 25;
      } else if (especie === 'Cachorro') {
        if (peso <= 10) {
          valor = tipo === 'Banho' ? 30 : 75;
        } else {
          valor = tipo === 'Banho' ? 50 : 95;
        }
      }

      let duracao = tipo === 'Banho' ? '30 minutos' : '1 hora';

      if (entrega) valor += 10;
      const desconto = (pagamento === 'avista') ? valor * 0.05 : 0;

      document.getElementById('valorTotal').value = `R$ ${(valor - desconto).toFixed(2)}`;
      document.getElementById('duracao').value = duracao;
      document.getElementById('desconto').value = `R$ ${desconto.toFixed(2)}`;
    }
  </script>
</head>
<body>
  <h2>Agendar Atendimento</h2>
  <form method="post" action="atendimentos">
    <label>Data e Hora:</label>
    <input type="datetime-local" name="dataHora" required><br>

    <label>Tipo de Serviço:</label>
    <select name="tipoServico" id="tipoServico" onchange="calcular()">
      <option value="Banho">Banho</option>
      <option value="Banho e Tosa">Banho e Tosa</option>
    </select><br>

    <label>Animal:</label>
    <select name="idAnimal" id="idAnimal" onchange="calcular()">
      <%
        for (Animal a : animais) {
      %>
        <option value="<%= a.getIdAnimal() %>" data-especie="<%= a.getEspecie() %>" data-peso="<%= a.getPeso() %>">
          <%= a.getNome() %> (<%= a.getEspecie() %> - <%= a.getPeso() %>kg)
        </option>
      <%
        }
      %>
    </select><br>

    <label><input type="checkbox" id="entrega" name="incluiEntrega" onchange="calcular()"> Incluir entrega (R$ 10)</label><br>

    <label>Forma de Pagamento:</label>
    <select name="formaPagamento" id="formaPagamento" onchange="calcular()">
      <option value="avista">À vista (5% de desconto)</option>
      <option value="cartao">Cartão</option>
    </select><br>

    <label>Valor Total:</label>
    <input type="text" id="valorTotal" name="valorTotal" readonly><br>

    <label>Duração Estimada:</label>
    <input type="text" id="duracao" name="duracaoEstimada" readonly><br>

    <label>Desconto Aplicado:</label>
    <input type="text" id="desconto" name="descontoAplicado" readonly><br>

    <button type="submit">Agendar</button>
  </form>
</body>
</html>
