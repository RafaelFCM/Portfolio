package entidade;

import java.time.LocalDate;

public class Colaboracoes {
	private int id_protocolo;
	private LocalDate data_colaboracao;
	private String nota_avaliacao;
	private String tema_colaboracao;
	private String texto_colaboracao;
	private Clientes clientes;
	
	public Colaboracoes(int id_protocolo, LocalDate data_colaboracao, String nota_avaliacao, String tema_colaboracao, String texto_colaboracao, Clientes clientes) {
		super();
		this.id_protocolo = id_protocolo;
		this.data_colaboracao = data_colaboracao;
		this.nota_avaliacao = nota_avaliacao;
		this.tema_colaboracao = tema_colaboracao;
		this.texto_colaboracao = texto_colaboracao;
		this.clientes = clientes;
	}

	@Override
	public String toString() {
		String aux = "";
		aux += "Data da colaboracao: " + data_colaboracao + "\n";
		aux += "Nota da colaboracao: " + nota_avaliacao + "\n";
		aux += "Tema da colaboracao: " + tema_colaboracao + "\n";
		aux += "Texto da colaboracao: " + texto_colaboracao + "\n";
		aux += "Clientes: " + clientes.getPrimeiro_nome() + " " + clientes.getUltimo_nome() + "\n";
		return aux;
	}

	public int getId_protocolo() {
		return id_protocolo;
	}

	public void setId_protocolo(int id_protocolo) {
		this.id_protocolo = id_protocolo;
	}

	public LocalDate getData_colaboracao() {
		return data_colaboracao;
	}

	public void setData_colaboracao(LocalDate data_colaboracao) {
		this.data_colaboracao = data_colaboracao;
	}

	public String getNota_avaliacao() {
		return nota_avaliacao;
	}

	public void setNota_avaliacao(String nota_avaliacao) {
		this.nota_avaliacao = nota_avaliacao;
	}

	public String getTema_colaboracao() {
		return tema_colaboracao;
	}

	public void setTema_colaboracao(String tema_colaboracao) {
		this.tema_colaboracao = tema_colaboracao;
	}
	
	public String getTexto_colaboracao() {
		return texto_colaboracao;
	}
	
	public void setTexto_colaboracao(String texto_colaboracao) {
		this.texto_colaboracao = texto_colaboracao;
	}

	public Clientes getClientes() {
		return clientes;
	}

	public void setClientes(Clientes clientes) {
		this.clientes = clientes;
	}

}
