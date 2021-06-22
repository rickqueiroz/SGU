<%
	dim conn
sub abreConexao

	'Criando a conexão com o BD
	strcon =  "Provider=SQLOLEDB.1;Password=YjfpFt8eB3;Persist Security Info=True;User ID=adapec;Initial Catalog=Adapec;Data Source=10.48.209.87"
	set conn = Server.CreateObject("ADODB.Connection")
	conn.open(strcon)	
end sub


sub fechaConexao
	'Fechando a conexão com o BD
	conn.Close()
	Set conn = Nothing
end sub
%>