<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<!--#include file="upload.lib.asp"-->
<!--#include file ="Base.asp"-->
<%
call abreConexao
 sql =  "SELECT * FROM GU_Arquivos WHERE id = '"&request("id")&"'"
  Set rs = conn.Execute(sql)
call fechaConexao 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="pt-br">
<title>Cadastro de Upload</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript">

var url_string = window.location.href;
var url = new URL(url_string);
var resp = url.searchParams.get("resp");

function validar() {
	if(document.frmUpload.txtTitulo.value == ""){
   		alert("Obrigatorio digitar o Titulo!");
   		document.frmUpload.txtTitulo.focus();
		return false;
	}
	if(document.frmUpload.txtDescricao.value == ""){
         alert("Obrigatório digitar o Nome!");
         document.frmUpload.txtDescricao.focus();
         return false;
     }
     return true;
}
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
    title: 'Deseja continuar?',
    text: "O Arquivo será desativado e não será mais listado no sistema!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',    
    cancelButtonText: 'Cancelar',
    confirmButtonText: 'Sim, prosseguir!'
  }).then((result) => {
    if (result.value) {
       window.location="CrudUpload.asp?id="+id+"&op=1"
    }
  })
}
mensagem(resp)
function mensagem(resp){
if(resp == 1){
	Swal.fire(
  'Ótimo',
  'Arquivo Cadastrado com Sucesso!',
  'success'
)
}
}
</script>
</head>
<body>
  <div class="col-lg-10 mt-4">
    <div class="card mb-6">
      <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
        <h5 class="m-0 font-weight-bold text-primary">Cadastrar Documentos</h5>
      </div>
  <div class="card-body">
<form name="frmUpload" enctype="multipart/form-data" method="POST" action="CrudUpload.asp?op=1">
<input type="hidden" name="Operacao" id="Operacao" />
<input type="text" name="idArquivo" id="idArquivo" value="<%=request("id")%>" hidden/>
<div class="form-group row g-3">
<div class="col-4">
<label for="txtTitulo" class="col-form-label col-form-label-sm" >Titulo</label>
<input type="text" class="form-control col-form-sm" id="txtTitulo" name="txtTitulo" required/>
</div>
 <div class="col">
<label for="txtDescricao" class="col-form-label col-form-label-sm" >Descrição</label>
<input type="text" class="form-control col-form-sm" id="txtDescricao" name="txtDescricao" required />
</div>
</div>

<input type="text" name="cpf" id="cpf" value="<%=Session("CPF_Usu")%>" hidden/>
<input type="text" name="codprograma" id="codprograma" value="<%=session("CodPrograma")%>" hidden/>
<div class="form-group row g-3">
<div class="col-4">
<input type="file" class"form-control-file"  name="upload"  accept="application/pdf" required><br />
</div>
</div>
<input type="submit" class="btn btn-primary" name="btnCadastrar" value="Cadastrar" />

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

</body>

<%
   call abreConexao
   sql = "SELECT GU_Arquivos.id, GU_Arquivos.Titulo, GU_Arquivos.Descricao, GU_CadPessoasUp.Nome, GU_Arquivos.Arquivo , FORMAT (dataArquivo, 'dd/MM/yyyy ') as data, GU_Arquivos.status FROM GU_CadPessoasUp INNER JOIN GU_Arquivos ON GU_Arquivos.cpf = GU_CadPessoasUp.CPF WHERE GU_Arquivos.status = 1 ORDER BY titulo;"
   set rs = conn.execute(sql)
%>
<div class="col-lg-12 mt-4">
    <div class="card mb-6">
    <!-- Select2 -->
    <div class="card mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <h5 class="m-0 font-weight-bold text-primary">Tabela de Cadastros</h5>
        </div>
         <div class="table-responsive p-3">
        <table class="table align-items-center table-flush table-sm" id="dataTable" >
        <thead class="thead-light">
         <%if rs.eof then%>
  <tr><td>Não Existe Nenhum Registro na base de Dados!</td></tr>
  <%else%>
  <tr>
  <th>Titulo</th>
  <th>Descrição</th>
  <th>Nome Completo</th>
  <th>Arquivo</th>
  <th>Data</th>
  <th>Ações</th>
  </tr>
  <%do while not rs.eof
  cont =cont+1%>
  <tr>
  <td ><%=rs("titulo")%></td>
  <td ><%=rs("Descricao")%></td>
  <td ><%=rs("Nome")%></td>
  <td ><a href="<%=rs("Arquivo")%>"><%=mid(rs("Arquivo"),10,100)&""%></a></td>
  <td ><%=rs("data")%></td>
  <td ><a href="#" onClick="desativar(<%=rs("id")%>)"><img src="Imagens\lixeira.png" width="30"/></a></td>
  </tr>
  <%
     rs.movenext
	 loop
  %>
  <%end if%>
</table>
<%call fechaConexao%>

  <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="card-body text-center">
                            <div class="text-muted">Todos os Direitos Reservados a TI/ADAPEC 2021</div>
                        </div>
</html>
