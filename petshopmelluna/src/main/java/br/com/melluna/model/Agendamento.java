package br.com.melluna.model;

public class Agendamento {
    private int idAgendamento; 
    private String data; 
    private String hora;
    private String servico;
    private boolean transporte;
    private boolean hidratacao;
    private boolean escova;
    private String tipoPagamento;
    private String status;
    private double valorTotal;
    private int idAnimal;
    private Animal animal;

    public Agendamento() {
    }

    public Agendamento(int idAgendamento, String dataAgendamento, String horaAgendamento, String servico,
                       boolean transporte, boolean hidratacao, boolean escova, String tipoPagamento,
                       String status, double valorTotal, int idAnimal) {
        this.idAgendamento = idAgendamento;
        this.data = dataAgendamento;
        this.hora = horaAgendamento;
        this.servico = servico;
        this.transporte = transporte;
        this.hidratacao = hidratacao;
        this.escova = escova;
        this.tipoPagamento = tipoPagamento;
        this.status = status;
        this.valorTotal = valorTotal;
        this.idAnimal = idAnimal;
    }

    public Agendamento(String dataAgendamento, String horaAgendamento, String servico,
                       boolean transporte, boolean hidratacao, boolean escova, String tipoPagamento,
                       String status, double valorTotal, int idAnimal) {
        this.data = dataAgendamento;
        this.hora = horaAgendamento;
        this.servico = servico;
        this.transporte = transporte;
        this.hidratacao = hidratacao;
        this.escova = escova;
        this.tipoPagamento = tipoPagamento;
        this.status = status;
        this.valorTotal = valorTotal;
        this.idAnimal = idAnimal;
    }

    public int getIdAgendamento() {
        return idAgendamento;
    }

    public void setIdAgendamento(int idAgendamento) {
        this.idAgendamento = idAgendamento;
    }

    public String getData() {
        return data;
    }

    public void setData(String dataAgendamento) {
        this.data = dataAgendamento;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String horaAgendamento) {
        this.hora = horaAgendamento;
    }

    public String getServico() {
        return servico;
    }

    public void setServico(String servico) {
        this.servico = servico;
    }

    public boolean isTransporte() {
        return transporte;
    }

    public void setTransporte(boolean transporte) {
        this.transporte = transporte;
    }

    public boolean isHidratacao() {
        return hidratacao;
    }

    public void setHidratacao(boolean hidratacao) {
        this.hidratacao = hidratacao;
    }

    public boolean isEscova() {
        return escova;
    }

    public void setEscova(boolean escova) {
        this.escova = escova;
    }

    public String getTipoPagamento() {
        return tipoPagamento;
    }

    public void setTipoPagamento(String tipoPagamento) {
        this.tipoPagamento = tipoPagamento;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(double valorTotal) {
        this.valorTotal = valorTotal;
    }

    public int getIdAnimal() {
        return idAnimal;
    }

    public void setIdAnimal(int idAnimal) {
        this.idAnimal = idAnimal;
    }

    public Animal getAnimal() {
        return animal;
    }

    public void setAnimal(Animal animal) {
        this.animal = animal;
        if (animal != null) {
            this.idAnimal = animal.getIdAnimal(); // Sincroniza o idAnimal
        }
    }
}