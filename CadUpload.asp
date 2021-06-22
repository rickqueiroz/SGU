<!doctype html>
<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file ="lib/Conexao.asp"-->
<!--#include file="upload.lib.asp"-->
<!--#include file ="Base.asp"-->
<%
call abreConexao
 sql =  "SELECT * FROM GU_Arquivos WHERE id = '"&request("id")&"'"
  Set rs = conn.Execute(sql)
call fechaConexao 

%>
<html>
<head>
<meta http-equiv="Content-Language" content="pt-br">
<title>Cadastro de Upload</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

<script type="text/javascript">

var url_string = window.location.href;
var url = new URL(url_string);
var resp = url.searchParams.get("resp");


function cadastrar(){
    if(validar() == false)
    return false;
	document.frmUpload.Operacao.value = 1;
	document.frmUpload.action = "CrudUpload.asp?op=1";
	document.frmUpload.submit();
}
function desativar(id)
{
	Swal.fire({
    title: 'Deseja continuar',
    text: "O Arquivo sera desativado e nao sera mais listado no sistema!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',    
    cancelButtonText: 'Cancelar',
    confirmButtonText: 'Sim, prosseguir!'
  }).then((result) => {
    if (result.value) {
       window.location="CrudUpload.asp?id="+id+"&op=2"
    }
  })
}
mensagem(resp)
function mensagem(resp){
if(resp == 1){
	Swal.fire(
  'Otimo',
  'Arquivo Cadastrado com Sucesso!',
  'success'
)
}
else
if(resp == 2){
	Swal.fire(
  'Erro',
  'Tamanho do Arquivo!',
  'error'
)
}

}



</script>
<script src="javascript/Mascara.js"></script>
<meta charset="iso-8859-1">
</head>
<body>
  <div class="col-lg-10 mt-4">
    <div class="card mb-6">
      <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
        <h5 class="m-0 font-weight-bold text-primary">Cadastrar Documentos</h5>
      </div>
  <div class="card-body">
<form name="frmUpload" enctype="multipart/form-data" method="post" action="CrudUpload.asp?op=1">
<input type="hidden" name="Operacao" id="Operacao">
<input type="text" name="idArquivo" id="idArquivo" value="<%=request("id")%>" hidden="hidden">
<div class="form-group row g-3">
<div class="col-4">
<label for="txtTitulo" class="col-form-label col-form-label-sm" >Titulo</label>
<input type="text" class="form-control col-form-sm" id="txtTitulo" name="txtTitulo" onkeyup="maiuscula(this)" required="required">
</div>
 <div class="col">
<label for="txtDescricao" class="col-form-label col-form-label-sm" >Descri&ccedil;&atilde;o</label>
<input type="text" class="form-control col-form-sm" id="txtDescricao" name="txtDescricao" onkeyup="maiuscula(this)" required="required">
</div>
<%if session("idPerfil") = "Administrador" then%>
 <div class="col-3">
<% 
call abreConexao 
 sql = "SELECT * FROM GU_Programas WHERE status = 1 order by Sigla"
set rs1 = conn.execute(sql) 
%>
<label for="programas" class="col-form-label col-form-label-sm" >Pastas</label>
<select name="codprograma" id="codprograma" class="select2-single form-control col-form-label-sm" required="required" >
			<option value="">Selecionar</option>
				<%do while not rs1.eof%>
			<option value="<%=rs1("id")%>" <%if rs1("id") = CodPrograma then%>selected<%end if%>><%=rs1("Sigla")&"-"&rs1("Programas")%>
			</option>
<% rs1.movenext 
			loop 
call fechaConexao
%>
</select>   
          </div>
<%else%>
<input type="text" name="codprograma" id="codprograma" value="<%=session("CodPrograma")%>" hidden="hidden">
<%end if%>
</div>

<input type="text" name="cpf" id="cpf" value="<%=Session("CPF_Usu")%>" hidden="hidden">
<div class="form-group row g-3">
<div class="col-4">
<input type="file" class="class""form-control-file"  name="upload"  accept="application/msword, application/vnd.ms-excel, application/pdf" required="required"><br>
</div>
</div>
<input type="submit" class="btn btn-primary" name="btnCadastrar" value="Cadastrar">

        <div class="form-group row g-3">
        <div class="col-3">
          </div>
           <div class="col-3">
           </div>
          </div>
        <div class="form-group">
        </div>
          <span class="icon text-white-50">
            <i class="fas fa-arrow-right"></i>
          </span>
          <span class="text"></span>
     </div>
    </div>
  </div>

</form>
<%
   call abreConexao
   sql = "SELECT GU_Arquivos.id, GU_Arquivos.Titulo, GU_Arquivos.Descricao, GU_CadPessoasUp.Nome, GU_Arquivos.Arquivo , Convert(DateTime, DataArquivo,103) as data, GU_Arquivos.status FROM GU_CadPessoasUp INNER JOIN GU_Arquivos ON GU_Arquivos.cpf = GU_CadPessoasUp.CPF and GU_Arquivos.cpf = '"&Session("CPF_Usu")&"'  WHERE GU_Arquivos.status = 1 ORDER BY titulo;"
   set rs = conn.execute(sql)
%>
<div class="col-lg-12 mt-4">
    <div class="card mb-6">
    <!-- Select2 -->
    <div class="card mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <h5 class="m-0 font-weight-bold text-primary">Listas de Arquivos por Pasta</h5>
        </div>
         <div class="table-responsive p-3">
        <table class="table align-items-center table-flush table-sm" id="dataTable" >
        <thead class="thead-light">
         <%if rs.eof then%>
  <tr><td>N&atilde;o Existe Nenhum Registro na base de Dados!</td></tr>
  <%else%>
  <tr>
  <th>Titulo</th>
  <th>Descri&ccedil;&atilde;o</th>
  <th>Usuario Cadastro</th>
  <th>Arquivo</th>
  <th>Data</th>
  <th>A&ccedil;&otilde;es</th>
  </tr>
  <%do while not rs.eof
  cont =cont+1%>
  <tr>
  <td ><%=rs("titulo")%></td>
  <td ><%=rs("Descricao")%></td>
  <td ><%=rs("Nome")%></td>
  <td ><a href="<%=rs("Arquivo")%>"><%=mid(rs("Arquivo"),10,100)&""%></a></td>
  <td ><%=rs("data")%></td>
  <td ><a href="#" onclick="desativar(<%=rs("id")%>)"><img src="Imagens\lixeira.png" width="30"></a></td>
  </tr>
  <%
     rs.movenext
	 loop
  %>
  <%end if%>
</table>
<%call fechaConexao%>
</body>						
</html>

<footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="card-body text-center">
                            <div class="text-muted">Todos os Direitos Reservados a TI/ADAPEC 2021</div>
                        </div>
						</footer>
