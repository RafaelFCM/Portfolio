package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import conexao.Conexao;
import entidade.Clientes;
import entidade.Enderecos;
import entidade.Enderecos;

public class EnderecosDAO {
	// definicao das variaveis para manipular os dados do banco
	private PreparedStatement ps;
	private ResultSet rs;
	private String sql;
	private Conexao conexao;

	public EnderecosDAO() {
		conexao = new Conexao();
	}
	
	// metodo para inserir um enderecos na base de dados
	public void inserir(Enderecos enderecos) {
		sql = "insert into gti_enderecos values(?, ?, ?, ?, ?, ?, ?)";
		
		try(Connection connection = conexao.conectar()) {
			ps = connection.prepareStatement(sql);
			ps.setString(1, enderecos.getCep());
			ps.setString(2, enderecos.getRua());
			ps.setString(3, enderecos.getNumero_rua());
			ps.setString(4, enderecos.getComplemento());
			ps.setString(5, enderecos.getBairro());
			ps.setString(6, enderecos.getEstado());
			ps.setString(7, enderecos.getCidade());
			ps.execute();
			ps.close();
			connection.close();
		} catch (SQLException e) {
			System.out.println(e);
		}		
	}
	
//	public boolean pesquisar(Enderecos enderecos) {
//		boolean aux = false;
//		sql = "select * from gti_enderecos where cep = ?";
//		
//		try(Connection connection = conexao.conectar()) {
//			ps = connection.prepareStatement(sql);
//			ps.setString(1, enderecos.getCep());
//			rs = ps.executeQuery();
//			if(rs.next()) {
//				aux = true;
//			}
//			ps.close();
//			rs.close();
//			connection.close();
//		} catch (SQLException e) {
//			System.out.println(e);			
//		}
//		return aux;
//	}
//			
//	public List<Enderecos> listar() {
//		List<Enderecos> lista = new ArrayList<>();
//		sql = "select * from gti_enderecos order by cep";
//		
//		try(Connection connection = conexao.conectar()) {
//			ps = connection.prepareStatement(sql);
//			rs = ps.executeQuery();
//			while(rs.next()) {
//				lista.add(new Enderecos(rs.getString("cep"), null, null, null, null, null, null));
//			}			
//			rs.close();
//			ps.close();
//			connection.close();
//		} catch (SQLException e) {
//			System.out.println("Erro ao listar enderecos\n" + e);
//		}
//		
//		return lista;
//	}	
}
