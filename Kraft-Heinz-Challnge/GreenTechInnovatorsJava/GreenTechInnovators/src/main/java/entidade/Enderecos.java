package entidade;

public class Enderecos {
	private String cep;
	private String rua;
	private String numero_rua;
	private String complemento;
	private String bairro;
	private String estado;
	private String cidade;
	
	public Enderecos(String cep, String rua, String numero_rua, String complemento, String bairro, String estado,
			String cidade) {
		super();
		this.cep = cep;
		this.rua = rua;
		this.numero_rua = numero_rua;
		this.complemento = complemento;
		this.bairro = bairro;
		this.estado = estado;
		this.cidade = cidade;
	}

	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

	public String getRua() {
		return rua;
	}

	public void setRua(String rua) {
		this.rua = rua;
	}

	public String getNumero_rua() {
		return numero_rua;
	}

	public void setNumero_rua(String numero_rua) {
		this.numero_rua = numero_rua;
	}

	public String getComplemento() {
		return complemento;
	}

	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}

	public String getBairro() {
		return bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	
}
