<%
	dim conn
sub abreConexao

	'Criando a conex�o com o BD
	strcon =  "Provider=SQLNCLI11;Server=localhost;Database=Teste;Uid=sa;Pwd=123;"
	set conn = Server.CreateObject("ADODB.Connection")
	conn.open(strcon)	
end sub


sub fechaConexao
	'Fechando a conex�o com o BD
	conn.Close()
	Set conn = Nothing
end sub
%>