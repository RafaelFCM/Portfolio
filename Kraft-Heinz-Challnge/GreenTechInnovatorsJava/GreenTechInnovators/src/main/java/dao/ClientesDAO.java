package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import conexao.Conexao;
import entidade.Clientes;
import entidade.Colaboracoes;
import entidade.Enderecos;

public class ClientesDAO {
	// definicao das variaveis para manipular os dados do banco
		private PreparedStatement ps;
		private ResultSet rs;
		private String sql;
		private Conexao conexao;
		
		public ClientesDAO() {
			conexao = new Conexao();
		}
		
		// metodo para inserir os dados de um clientes no banco
		public void inserir(Clientes clientes) {
			sql = "insert into gti_clientes values(?, ?, ?, ?, ?, ?, ?, ?)";
			
			try(Connection connection = conexao.conectar()) {
				ps = connection.prepareStatement(sql);
				ps.setString(1, clientes.getPrimeiro_nome());
				ps.setString(2, clientes.getUltimo_nome());
				ps.setString(3, clientes.getCpf());
				ps.setDate(4, Date.valueOf(clientes.getDataNascimento()));
				ps.setString(5, clientes.getEmail());
				ps.setString(6, clientes.getSenha());
				ps.setString(7, clientes.getTelefone());
				ps.setString(8, clientes.getEnderecos().getCep());
				ps.execute();
				ps.close();
				connection.close();
			} catch (SQLException e) {
				System.out.println(e);			
			}
		}

		// metodo para pesquisar um cliente
//		public boolean pesquisar(Clientes clientes) {
//			boolean aux = false;
//			sql = "select * from gti_clientes where id_cliente = ?";
//			
//			try(Connection connection = conexao.conectar()) {
//				ps = connection.prepareStatement(sql);
//				ps.setInt(1, clientes.getId_cliente());
//				rs = ps.executeQuery();
//				if(rs.next()) {
//					aux = true;
//				}
//				ps.close();
//				rs.close();
//				connection.close();
//			} catch (SQLException e) {
//				System.out.println(e);			
//			}
//			
//			return aux;
//		}
//		 //metodo para pesquisar um cliente pelo ID
//		public Clientes pesquisar(int id) {
//			Clientes clientes = null;
//			sql = "select id_cliente, primeiro_nome, ultimo_nome, email, telefone, cep"
//					+ "as enderecos from gti_clientes";
//			
//			try(Connection connection = conexao.conectar()) {
//				ps = connection.prepareStatement(sql);
//				ps.setInt(1, id);
//				rs = ps.executeQuery();
//				if(rs.next()) {
//					int id_cliente = rs.getInt("id_cliente");
//					String primeiro_nome = rs.getString("primeiro_nome");
//					String ultimo_nome = rs.getString("ultimo_nome");
//					String email = rs.getString("email");
//					String telefone = rs.getString("telefone");
//					String cep = rs.getString("enderecos");
//					Enderecos enderecos = new Enderecos(cep, null, null, null, null, null, null);
//					clientes = new Clientes(id_cliente, primeiro_nome, ultimo_nome, email, telefone, enderecos);
//				}
//				rs.close();
//				ps.close();
//				connection.close();
//			} catch (SQLException e) {
//				System.out.println("Erro ao pesquisar colaboracoes\n" + e);
//			}		
//			return clientes;
//		}
//
//		// metodo para listar todos os clientes
//		public List<Clientes> listar() {
//			List<Clientes> lista = new ArrayList<>();
//			sql = "select id_cliente, primeiro_nome, ultimo_nome, email, telefone, cep as enderecos from gti_clientes order by id_cliente";
//			
//			try(Connection connection = conexao.conectar()) {
//				ps = connection.prepareStatement(sql);
//				rs = ps.executeQuery();
//				while(rs.next()) {
//					String cep = rs.getString("enderecos");
//					Enderecos enderecos = new Enderecos(cep, null, null, null, null, null, null);
//					lista.add(new Clientes(rs.getInt("id_cliente"), rs.getString("primeiro_nome"), rs.getString("ultimo_nome"), rs.getString("email"), rs.getString("telefone"), enderecos));
//				}
//				rs.close();
//				ps.close();
//			} catch (SQLException e) {
//				System.out.println("Erro ao listar clientes\n" + e);
//			}		
//			return lista;
//		}
}
