<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file ="lib/Conexao.asp"-->
<!--#include file ="Base.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Buscar Programas</title>
<script type="text/javascript">
function visualizar()
{
	if(document.frmBusca.programas.value != ""){
	
	document.frmBusca.Operacao.value = 2;
	document.frmBusca.action = "BuscarProgramas.asp";
	document.frmBusca.submit();
	
	}

}
</script>
</head>
<body>
<!-- End Navbar -->
      <div class="content">
        <div class="row">
        
   <div class="col-lg-10 mt-4">
    <div class="card mb-6">     
  <!-- Dropdown Basics -->
  <div class="card mb-4">
      <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
      <h5 class="m-0 font-weight-bold text-primary">Buscar Documentos</h5>
      
    </div>
    </div>
        <div class="card-body text-center">
<form name="frmBusca" id="frmBusca" method="post">
<input type="hidden" name="Operacao" id="Operacao" />
<% 
call abreConexao 
 sql = "SELECT * FROM GU_Programas order by Sigla"
set rs1 = conn.execute(sql) 
%>
<div class="form-group row">
    <label for="inputEmail3" class="col-sm-1 col-form-label">Pastas</label>
    <div class="col-sm-5">
      <select name="programas" id="programas" required class="select2-single form-control col-form-label-sm">
      <option value="">Selecionar</option>
      <%do while not rs1.eof%>
<option value="<%=rs1("id")%>"<%IF clng(rs1("id")) = clng(request.form("programas")) THEN%>selected<%END IF%>><%=rs1("Sigla")&"-"&rs1("Programas")%>
</option>
<% rs1.movenext 
			loop 
call fechaConexao
%>
	  </select>
	 </div>
	 <button class="btn btn-primary btn-icon-split" type="submit" onClick="visualizar();">
          <span class="icon text-white-100">
          </span>
          <span class="text">Pesquisar</span>
        </button> 
  </div>
 
  </form>
</div>
</div>
</div>
</body>
<div class="col-lg-12 mt-4">
    <div class="card mb-6">     
  <!-- Dropdown Basics -->
  <div class="card mb-6">

<%
existe = 0
IF REQUEST("Operacao") = 2 THEN

call abreConexao
sql = "SELECT GU_Arquivos.Titulo, GU_Arquivos.Descricao, GU_CadPessoasUp.Nome, GU_Arquivos.Arquivo , Convert(DateTime, DataArquivo,103) as data, GU_Programas.id, GU_Programas.Programas FROM GU_CadPessoasUp INNER JOIN GU_Arquivos ON GU_Arquivos.cpf = GU_CadPessoasUp.CPF INNER JOIN GU_Programas ON GU_Programas.id = GU_Arquivos.CodPrograma WHERE GU_Programas.id ='"&request.form("programas")&"' AND GU_Arquivos.status = 1"

set rs = conn.execute(sql)
	if not rs.eof then
	CodPrograma = rs("id")
	existe = 1
	
	end if 
END IF


%>
<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <h5 class="m-0 font-weight-bold text-primary">Lista de Documentos Cadastrados</h5>
        </div>
         <div class="table-responsive p-3">
        <table class="table align-items-center table-flush table-sm" id="dataTable" >
        <thead class="thead-light">
 <%if existe= 0 then%>
  <tr><td>N&atilde;o Existe Nenhum Registro na base de Dados!</td></tr>
  <%else%>
  <tr>
  <th>Titulo</th>
  <th>Descri&ccedil;&atilde;o</th>
  <th>Nome Completo</th>
  <th>Arquivo</th>
  <th>Data</th>
  <th>A&ccedil;&otilde;es</th>
  </tr>
  <%do while not rs.eof%>
  <tr>
  <td ><%=rs("titulo")%></td>
  <td ><%=rs("Descricao")%></td>
  <td ><%=rs("Nome")%></td>
  <td ><a href="<%=rs("Arquivo")%>"><%=mid(rs("Arquivo"),10,100)&""%></a></td>
  <td ><%=rs("data")%></td>
  <td align="center"><a href="<%=rs("Arquivo")%>" download><img src="Imagens\download.png" width="30"/></a></td>
  </tr>
  <%
     rs.movenext
	 loop
  %>
  <%call fechaConexao%>
 <%end if%>

</table>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
</html>
<footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="card-body text-center">
                            <div class="text-muted">Todos os Direitos Reservados a TI/ADAPEC 2021</div>
                            <div>
                            </div>
                        </div>
                    </div>
                </footer>

