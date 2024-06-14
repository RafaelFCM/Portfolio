package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidade.Clientes;
import entidade.Colaboracoes;
import entidade.Enderecos;
import dao.ClientesDAO;
import dao.ColaboracoesDAO;
import dao.EnderecosDAO;
import util.Util;

/**
 * Servlet implementation class AgendaServlet
 */

// url maping vai no action=" " do form
//localhost:8080/ContextRoot/URLMap
//REQUISIÇÃO: method=" "
//GET - dados aparecem na url do navegador
//POST - dados ficam no fim da pág

@WebServlet("/AdicionaContribuicao")
public class AdicionaContribuicao extends HttpServlet{
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdicionaContribuicao() {
		super();
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String nome = request.getParameter("nome");
		String sobrenome = request.getParameter("sobrenome");
		String cpf = request.getParameter("cpf");
		String data = request.getParameter("data");
		String senha = request.getParameter("senha");
		String email = request.getParameter("email");
		String celular = request.getParameter("celular");
		String rua = request.getParameter("rua");
		String numeroRua = request.getParameter("numeroRua");
		String complemento = request.getParameter("complemento");
		String bairro = request.getParameter("bairro");
		String estado = request.getParameter("estado");
		String cidade = request.getParameter("cidade");
		String cep = request.getParameter("cep");
		String assunto = request.getParameter("assunto");
		String nota = request.getParameter("nota");
		String mensagem = request.getParameter("mensagem");
		
		Util util = new Util();
		
		EnderecosDAO daoEnd = new EnderecosDAO();
		Enderecos enderecos = new Enderecos(cep, rua, numeroRua, complemento, bairro, estado, cidade);
		daoEnd.inserir(enderecos);
		
		ClientesDAO daoCliente = new ClientesDAO();
		Clientes clientes = new Clientes(nome, sobrenome, cpf, util.formatarData(data), email, util.criptografar(senha), mensagem, enderecos);
		daoCliente.inserir(clientes);
		
		ColaboracoesDAO daoColab = new ColaboracoesDAO();
		Colaboracoes colaboracoes = new Colaboracoes(0, util.formatarData(data), nota, assunto, mensagem, clientes);
		daoColab.inserir(colaboracoes);
		
		//mandando uma response		
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>"
				+ "<html lang='pt-BR'>"
				+ "<head>"
				+ "    <meta charset='UTF-8'>"
				+ "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
				+ "    <title>GreenTech Innovators</title>"
				+ "    <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css' rel='stylesheet'"
				+ "        integrity='sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT' crossorigin='anonymous'>"
				+ "		<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/5.0.6/jquery.inputmask.min.js'></script>"
				+ "</head>"
				+ "<body>"
				+ "    <section class='container-fluid pt-5'>"
				+ "            <div class='row'>"
				+ "                <div class='col-12 text-center mb-5 fs-1'>"
				+ "                    <h1 class='fs-1'>Formulario enviado com sucesso</h1>"
				+ "                    <h2>Verifique se os dados foram enviados corretamente</h2>"
				+ "                </div>"
				+ "                <div class='col-12 col-lg-6 text-center fs-5'>"
				+ "                    <h3>Nome: </h3>"
				+ "                    <p>" + nome + "</p>"
				+ "                    <br>"
				+ "                    <h3>Sobrenome: </h3>"
				+ "                    <p>" + sobrenome + "</p>"
				+ "                    <br>"
				+ "                    <h3>CPF: </h3>"
				+ "                    <p>" + cpf + "</p>"
				+ "                    <br>"
				+ "                    <h3>Senha: </h3>"
				+ "                    <p>" + senha + "</p>"
				+ "                    <br>"
				+ "                    <h3>Email: </h3>"
				+ "                    <p>" + email + "</p>"
				+ "                    <br>"
				+ "                    <h3>Celular: </h3>"
				+ "                    <p>" + celular + "</p>"
				+ "                    <br>"
				+ "                    <h3>Rua: </h3>"
				+ "                    <p>" + rua + "</p>"
				+ "                    <br>"
				+ "                    <h3>Numero da Rua: </h3>"
				+ "                    <p>" + numeroRua + "</p>"
				+ "                </div>"
				+ "					<div class='col-12 col-lg-6 text-center fs-5'>"
				+ "                    <h3>Complemento: </h3>"
				+ "                    <p>" + complemento + "</p>"
				+ "                    <br>"
				+ "                    <h3>Bairro: </h3>"
				+ "                    <p>" + bairro + "</p>"
				+ "                    <br>"
				+ "                    <h3>Estado: </h3>"
				+ "                    <p>" + estado + "</p>"
				+ "                    <br>"
				+ "                    <h3>Cidade: </h3>"
				+ "                    <p>" + cidade + "</p>"
				+ "                    <br>"
				+ "                    <h3>CEP: </h3>"
				+ "                    <p>" + cep + "</p>"
				+ "                    <br>"
				+ "                    <h3>Assunto: </h3>"
				+ "                    <p>" + assunto + "</p>"
				+ "                    <br>"
				+ "                    <h3>Nota: </h3>"
				+ "                    <p>" + nota + "</p>"
				+ "                    <br>"
				+ "                    <h3>Mensagem: </h3>"
				+ "                    <p>" + mensagem + "</p>"
				+ "                    <br>"
				+ "                </div>"
				+ "        	</div>"
				+ "    </section>"
				+ "</body>"
				+ "</html>");
		
	}
	
}
