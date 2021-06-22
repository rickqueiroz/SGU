<!--#include file ="lib/Conexao.asp"-->
<%
  call abreConexao
  sql = "SELECT  GU_CadPessoasUp.CPF,GU_CadPessoasUp.CodPrograma, GU_CadPessoasUp.Nome, GU_Perfil.Perfil, GU_Programas.Programas FROM   GU_CadPessoasUp INNER JOIN  GU_Programas ON GU_CadPessoasUp.CodPrograma = GU_Programas.id AND GU_Programas.status = 1 INNER JOIN  GU_Perfil ON GU_CadPessoasUp.idPerfil = GU_Perfil.idPerfil INNER JOIN CadFunc ON GU_CadPessoasUp.CPF = REPLACE(REPLACE(CadFunc.CPF, '.', ''), '-', '') AND CadFunc.Matricula = '"&request("idUsu")&"' WHERE (GU_CadPessoasUp.status = 1)"  
  set rs = conn.execute(sql)
  
  if not rs.eof then
    Session("CPF_Usu") = rs("CPF")
	session("idPerfil") = rs("Perfil")
	session("CodPrograma") = rs("CodPrograma")
	Session("Nome") = rs("Nome")
  else
    sql = "SELECT   REPLACE(REPLACE(CPF, '.', ''), '-', '') AS CPF, Nome FROM   CadFunc WHERE  Matricula  = '"&Request("idUsu")&"'"
    set rs = conn.execute(sql)
	Session("CPF_Usu") = rs("CPF")
	session("idPerfil") = "Consulta"
	session("CodPrograma") = "0"
	Session("Nome") = rs("Nome")
  end if
  response.redirect("index.asp")
%>