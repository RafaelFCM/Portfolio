package main;

import java.util.Random;

public class Main {

	public static void main(String[] args) {
		int id_protocolo=0, nota_avaliacao=0;
		String data_colaboracao, tema_colaboracao="", texto_colaboracao, cep, rua, bairro, estado, cidade, email, telefone, data_nascimento;
		Random random = new Random();
		
		String[] nomesAleatorios = {"Alice", "Bob", "Carla", "David", "Eva", "Fernando", "Gisele", "Hugo", "Isabel", "Jo�o", "Luna", "Ol�via", "Maria Helena", "Mariana", "Isadora"
				, "Melissa"
				, "Maria"
				, "Catarina"
				, "Lav�nia"
				, "Al�cia"
				, "Maria Eduarda"
				, "Agatha"
				, "Ana Liz"
				, "Yasmin"
				, "Emanuelly"
				, "Ana Clara"
				, "ClaraEduarda"
				, "Ana L�via"
				, "Isabel"
				, "Elis"
				, "P�rola"
				, "Joana"};
	    
		String[] sobrenomesAleatorios = {"Alves", "Brito", "Cunha", "Dias", "Ferreira", "Gon�alves", "Lima", "Machado", "Nunes", "PereiraAguiar"
	    		, "AlbuquerqueAlvarenga"
	    		, "�lvaresBruscato"
	    		, "Bueno"
	    		, "BenacchioDomingues"
	    		, "DominiciGomes"
	    		, "Gon�ales"
	    		, "Gon�alves"
	    		, "Gonzaga"
	    		, "Gouveia"};
	    
		String[] textos = {"A Heinz demonstra um forte compromisso com a sustentabilidade ambiental em suas opera��es."
	    		, "A empresa Heinz adota pr�ticas de produ��o respons�vel, minimizando seu impacto no meio ambiente."
	    		, "A Heinz tem programas sociais s�lidos que apoiam comunidades em todo o mundo."
	    		, "A governan�a corporativa s�lida da Heinz � um exemplo a ser seguido."
	    		, "A Heinz investe em tecnologias sustent�veis para reduzir sua pegada de carbono."
	    		, "A empresa promove a diversidade e a inclus�o em sua for�a de trabalho."
	    		, "A Heinz apoia a agricultura sustent�vel em suas cadeias de suprimentos."
	    		, "A transpar�ncia da Heinz em rela��o aos seus objetivos ESG � not�vel."
	    		, "A Heinz tem pol�ticas rigorosas de seguran�a no trabalho."
	    		, "A empresa est� comprometida com a redu��o do desperd�cio de alimentos em suas opera��es."
	    		, "A Heinz est� fazendo progressos, mas ainda h� espa�o para melhorias em termos de emiss�es de carbono."
	    		, "A empresa poderia ampliar seus esfor�os em filantropia social."
	    		, "A Heinz demonstrou melhorias em governan�a, mas precisa continuar avan�ando."
	    		, "Os relat�rios ESG da Heinz s�o informativos, mas aprofundamentos adicionais seriam bem-vindos."
	    		, "A empresa Heinz poderia se envolver mais ativamente em quest�es ambientais."
	    		, "A Heinz precisa melhorar significativamente suas pol�ticas ambientais para reduzir o uso de pl�sticos."
	    		, "A empresa parece se concentrar mais no lucro do que em quest�es sociais e ambientais."
	    		, "A governan�a da Heinz pode ser opaca em algumas �reas."
	    		, "A empresa tem sido criticada por pr�ticas de trabalho n�o ideais em algumas de suas f�bricas."
	    		, "A Heinz precisa trabalhar mais em sua responsabilidade social corporativa para ser uma l�der em ESG."};
	    
	    int[] ddd = {11,21
	    		,31
	    		,61
	    		,51
	    		,71
	    		,81
	    		,85
	    		,41
	    		,48};
	    
	    String[] array_end_cep = {"01030-020", "01007-030", "01028-030", "01030-010", "01049-030",
	    		"22430-080", "22430-120", "22441-050", "22430-180", "22430-030",
	    		"31270-430", "31270-480", "31270-650", "31270-380", "31270-660",
	    		"71693-701", "71693-710", "71693-711", "71693-712", "71693-713",
	    		"91787-166", "91796-716", "91780-061", "91796-730", "91780-063",
	    		"41900-505", "41900-015", "41900-440", "41900-847", "41900-441",
	    		"50690-709", "50731-271", "50731-111", "50670-391", "50670-021",
	    		"60346-164", "60346-180", "60346-256", "60346-305", "60346-165",
	    		"81260-060", "81290-230", "81260-400", "81260-380", "81260-548",
	    		"88085-330", "88085-340", "88085-355", "88085-350", "88085-260"};
	    
	    String[] array_rua = {"Beco da F�brica",
	    		"Galeria Prestes Maia",
	    		"Jardim Itu",
	    		"Ladeira Constitui��o",
	    		"Ladeira da Mem�ria",
	    		"Pra�a Milton Campos",
	    		"Pra�a Ministro Romeiro Neto",
	    		"Pra�a Nossa Senhora Auxiliadora",
	    		"Pra�a Padre Serafim Leite",
	    		"Pra�a Poeta Gibraim",
	    		"Rua Aur�lio Pires",
	    		"Rua L�der",
	    		"Rua Noraldino Lima",
	    		"Rua Professor Jerson Martins",
	    		"Rua Professor Nelson de Sena",
	    		"Residencial Vit�ria Rua 1",
	    		"Residencial Vit�ria Rua 10",
	    		"Residencial Vit�ria Rua 11",
	    		"Residencial Vit�ria Rua 12",
	    		"Residencial Vit�ria Rua 13",
	    		"Rua Dois",
	    		"Rua Doze",
	    		"Rua E",
	    		"Rua Esmeralda",
	    		"Rua G",
	    		"1� Travessa Crist�v�o Ferreira",
	    		"1� Travessa da Fonte",
	    		"2� Avenida Adelm�rio Pinheiro",
	    		"2� Travessa 19 de Setembro",
	    		"2� Travessa Adelm�rio Pinheiro",
	    		"1� Travessa Bom Jesus",
	    		"1� Travessa Cordisl�ndia",
	    		"1� Travessa Coronel Fernando Furtado",
	    		"1� Travessa Jo�o Sales de Menezes",
	    		"1� Travessa Manoel Azevedo",
	    		"Avenida Coronel Carvalho",
	    		"Avenida Hildebrando Melo",
	    		"Avenida Independ�ncia",
	    		"Rua Altaneira",
	    		"Rua Ant�nio Arruda",
	    		"Estrada da Col�nia Augusta",
	    		"Rua Albino Evaldo M�ller",
	    		"Rua Albino Pavelski",
	    		"Rua Ang�lica Pavelski",
	    		"Rua Antonieta da Costa Montanari",
	    		"Avenida Pl�cido de Castro",
	    		"Rua Antenor Morais",
	    		"Rua Ant�nio Filomeno",
	    		"Rua Eduardo Nader",
	    		"Rua Fernando Ferreira de Mello"};
	    
	    String[] array_bairro = {"Centro", "Centro", "Centro", "Centro", "Leblon","Leblon","Leblon","Leblon","Leblon",
	    		"Aeroporto", "Aeroporto", "Aeroporto", "Aeroporto", "Aeroporto",
	    		"Residencial Vit�ria (S�o Sebasti�o)", "Residencial Vit�ria (S�o Sebasti�o)", "Residencial Vit�ria (S�o Sebasti�o)", "Residencial Vit�ria (S�o Sebasti�o)", "Residencial Vit�ria (S�o Sebasti�o)",
	    		"Lageado", "Lageado", "Lageado", "Lageado", "Lageado",
	    		"Amaralina", "Amaralina", "Amaralina", "Amaralina", "Amaralina",
	    		"Iputinga", "Iputinga", "Iputinga", "Iputinga", "Iputinga",
	    		"Jardim Guanabara", "Jardim Guanabara", "Jardim Guanabara", "Jardim Guanabara", "Jardim Guanabara",
	    		"Augusta", "Augusta", "Augusta", "Augusta", "Augusta",
	    		"Bom Abrigo", "Bom Abrigo", "Bom Abrigo", "Bom Abrigo", "Bom Abrigo"};
	    
	    String[] array_cidade = {"S�o Paulo","S�o Paulo","S�o Paulo","S�o Paulo","Rio de Janeiro","Rio de Janeiro","Rio de Janeiro","Rio de Janeiro","Rio de Janeiro",
	    		"Belo Horizonte","Belo Horizonte","Belo Horizonte","Belo Horizonte","Belo Horizonte","Bras�lia","Bras�lia","Bras�lia","Bras�lia","Bras�lia",
	    		"Porto Alegre","Porto Alegre","Porto Alegre","Porto Alegre","Porto Alegre","Salvador","Salvador","Salvador","Salvador","Salvador","Recife","Recife",
	    		"Recife","Recife","Recife","Fortaleza","Fortaleza","Fortaleza","Fortaleza","Fortaleza","Curitiba","Curitiba","Curitiba","Curitiba","Curitiba",
	    		"Florian�polis","Florian�polis","Florian�polis","Florian�polis","Florian�polis"};
	    
	    String[] array_estado = {"SP","SP","SP","SP","RJ","RJ","RJ","RJ","RJ","MG","MG","MG","MG","MG","DF","DF","DF","DF","DF","RS","RS",
	    		"RS","RS","RS","BA","BA","BA","BA","BA","PE","PE","PE","PE","PE","CE","CE","CE","CE","CE","PR","PR","PR","PR","PR","SC","SC","SC","SC","SC"};
	    
		
	    for (int i=0; i<3000; i++) {
	    	int auxDDDEnderecos = random.nextInt(9);
	    	//inicio gti_enderecos
	    	int auxSwitch = 0; 
	    	switch (auxDDDEnderecos) {
	    		case 0: 
	    			auxSwitch = random.nextInt(5);
	    			break;
	    		case 1: 
	    			auxSwitch = random.nextInt(5)+5;
	    			break;
	    		case 2: 
	    			auxSwitch = random.nextInt(5)+10;
	    			break;
	    		case 3: 
	    			auxSwitch = random.nextInt(5)+15;
	    			break;
	    		case 4: 
	    			auxSwitch = random.nextInt(5)+20;
	    			break;
	    		case 5: 
	    			auxSwitch = random.nextInt(5)+25;
	    			break;
	    		case 6: 
	    			auxSwitch = random.nextInt(5)+30;
	    			break;
	    		case 7: 
	    			auxSwitch = random.nextInt(5)+35;
	    			break;
	    		case 8: 
	    			auxSwitch = random.nextInt(5)+40;
	    			break;
	    		case 9: 
	    			auxSwitch = random.nextInt(5)+45;
	    			break;
	    	}
	    	
	    	cep = array_end_cep[auxSwitch];
	    	
	    	rua = array_rua[auxSwitch];
	    	 
	    	bairro = array_bairro[auxSwitch];
	    	 
	    	estado = array_estado[auxSwitch];
	    	 
	    	cidade = array_cidade[auxSwitch];
	    	
	    	 String auxEndFinal = "insert into gti_enderecos values ('"+cep+"', '"+rua+"' , '"+bairro+"' , '"+estado+"' , '"+cidade+"')";
	    	//fim gti_enderecos
	    	
	    	//inicio gti_clientes
	    	int auxCli4 = random.nextInt(32);
	    	int auxCli5 = random.nextInt(19);
	    	String auxCli6 = "";
	    	String auxCli7 = "";
	    	
	    	auxCli6 = nomesAleatorios[auxCli4];
	    	auxCli7 = sobrenomesAleatorios[auxCli5];
	    	
	    	email = auxCli6+auxCli7+"@gmail.com";
	    	
	    	int auxCli9 = random.nextInt(9)+1;
	    	int auxCli10 = random.nextInt(10);
	    	int auxCli11 = random.nextInt(10);
	    	int auxCli12 = random.nextInt(10);
	    	int auxCli13 = random.nextInt(10);
	    	int auxCli14 = random.nextInt(10);
	    	int auxCli15 = random.nextInt(10);
	    	int auxCli16 = random.nextInt(10);
	    	int auxCli17 = random.nextInt(10);
	    	telefone = "("+ddd[auxDDDEnderecos]+")9"+auxCli9+auxCli10+auxCli11+auxCli12+auxCli13+auxCli14+auxCli15+auxCli16+auxCli17;
	    	
	    	int aux1=0, aux2=0, aux3=0;
	    	aux1 = random.nextInt(31)+1;
	    	aux2 = random.nextInt(13)+1;
	    	aux3 = random.nextInt(70)+1940;
	    	data_nascimento = aux1+"/"+aux2+"/"+aux3;
	    	
	    	String auxCliFinal = "insert into gti_clientes values ("+email+","+telefone+","+data_nascimento+","+cep+");";
	    	//fim gti_client
	    	
	    	//inicio gti_colaboracoes
	    	id_protocolo = random.nextInt(10000)+1000;
	    	
	    	int auxColab1=0, auxColab2=0, auxColab3=0;
	    	auxColab1 = random.nextInt(31)+1;
	    	auxColab2 = random.nextInt(13)+1;
	    	auxColab3 = 2023;
	    	data_colaboracao = auxColab1+"/"+auxColab2+"/"+auxColab3;
	    	
	    	int auxColab4 = random.nextInt(3)+1;
	    	if (auxColab4 == 1) {
	    		tema_colaboracao = "Sustentabilidade";
	    	} else if (auxColab4 == 2) {
	    		tema_colaboracao = "Governanca";
	    	} else if (auxColab4 == 3) {
	    		tema_colaboracao = "Social";
	    	}
	    	
	    	int auxColab5 = random.nextInt(20);
	    	texto_colaboracao = textos[auxColab5];
	    	if (auxColab5<10) {
	    		nota_avaliacao = random.nextInt(3)+8;
	    	} else if (auxColab5>9 && auxColab5<15) {
	    		nota_avaliacao = random.nextInt(3)+5;
	    	}  else if (auxColab5>14) {
	    		nota_avaliacao = random.nextInt(5);
	    	}
	    	
	    	String auxFinal = "insert into gti values ('"+email+"', '"+telefone+"', '"+data_nascimento+"', "+id_protocolo+", '"+data_colaboracao+"', "+nota_avaliacao+", '"+tema_colaboracao+"', '"+texto_colaboracao+"', '"+cep+"', '"+rua+"', '"+bairro+"', '"+estado+"', '"+cidade+"');";
	    	//fim gti_colaboracoes
	    	
	    	System.out.println(auxFinal);
	    }
	    
	}

}
