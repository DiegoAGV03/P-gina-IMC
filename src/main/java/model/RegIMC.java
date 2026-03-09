package model;

import java.util.Date;

public class RegIMC {

    private int idRegistro;
    private int idUsuario;
    private double peso;
    private double imc;
    private Date fecha;

    public RegIMC() {
    }

    public int getIdRegistro() {
        return idRegistro;
    }

    public void setIdRegistro(int idRegistro) {
        this.idRegistro = idRegistro;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public double getImc() {
        return imc;
    }

    public void setImc(double imc) {
        this.imc = imc;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    // Método para calcular IMC
    public double calcularIMC(double peso, double estatura) {
        return peso / (estatura * estatura);
    }
}