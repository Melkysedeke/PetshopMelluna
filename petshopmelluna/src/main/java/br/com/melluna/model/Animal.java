package br.com.melluna.model;

public class Animal {
    private int idAnimal; 
    private String nome;
    private String raca;
    private String especie; 
    private double peso;
    private String obs; 
    private String cpfCliente; 

    public Animal() {
    }

    public Animal(int idAnimal, String nome, String raca, String especie, double peso, String obs, String cpfCliente) {
        this.idAnimal = idAnimal;
        this.nome = nome;
        this.raca = raca;
        this.especie = especie;
        this.peso = peso;
        this.obs = obs;
        this.cpfCliente = cpfCliente;
    }

    public int getIdAnimal() {
        return idAnimal;
    }

    public void setIdAnimal(int idAnimal) {
        this.idAnimal = idAnimal;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getRaca() {
        return raca;
    }

    public void setRaca(String raca) {
        this.raca = raca;
    }

    public String getEspecie() {
        return especie;
    }

    public void setEspecie(String especie) {
        this.especie = especie;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public String getObs() {
        return obs;
    }

    public void setObs(String obs) {
        this.obs = obs;
    }

    public String getCpfCliente() {
        return cpfCliente;
    }

    public void setCpfCliente(String cpfCliente) {
        this.cpfCliente = cpfCliente;
    }
}