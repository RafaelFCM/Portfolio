package util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Util {
	
	public LocalDate formatarData(String dataString) {
		String[] aux = dataString.split("-");
		dataString = "";
		dataString = aux[2] + "/" + aux[1] + "/" + aux[0];
		DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		LocalDate date = LocalDate.parse(dataString, formato);
		return date;
	}
	
	public String criptografar(String senha) {
		String password = "";
		try {
			MessageDigest alg = MessageDigest.getInstance("SHA-256");
			byte[] aux = alg.digest(senha.getBytes("UTF-8"));
			StringBuilder senhaHex = new StringBuilder();
			for(byte b : aux) {
				senhaHex.append(String.format("%02X", 0xFF & b));
			}
			password = senhaHex.toString();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return password;
	}
	
}
