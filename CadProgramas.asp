<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<!--#include file ="Base.asp"-->
<%

resposta = 0
IF REQUEST("Operacao") = 1 THEN
call abreConexao
sql = "INSERT INTO GU_Programas(Sigla, Programas, status) VALUES('"&request.form("txtSigla")&"', '"&request.form("txtNome")&"', 1)"
conn.execute(sql)
resposta = 1
call fechaConexao
ELSEIF REQUEST("Operacao") = 2 THEN
call abreConexao
sql = "SELECT id, Sigla, Programas, status FROM GU_Programas WHERE id = '"&request("idVisualizar")&"'"
set rs = conn.execute(sql)
	if not rs.eof then
	id = rs("id")
	Sigla = rs("Sigla")
	programas = rs("Programas")
	statusPrograma = rs("status")
	Existe = 1

	end if
call fechaConexao
ELSEIF REQUEST("Operacao") = 3 THEN
call abreConexao
sql = "SELECT COUNT(*) as ExisteCad FROM GU_Arquivos where CodPrograma = '"&request.form("id")&"' and status = 1"
set rs = conn.execute(sql)

if rs("ExisteCad") = 0 then
sql = "UPDATE GU_Programas SET Sigla = '"&request.form("txtSigla")&"', Programas = '"&request.form("txtNome")&"', status = '"&request.Form("status")&"' WHERE id = '"&request.form("id")&"'"
conn.execute(sql)
resposta = 2
else
resposta = 3 'EXISTE CADASTRO
end if
call fechaConexao

END IF
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cadastrar Pastas</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.all.min.js"></script>
<script src="javascript/Mascara.js"></script>
<script type="text/javascript">
function validar() {
if(document.frmProgramas.txtSigla.value == ""){
   			Swal.fire({
 		    icon: 'error',
  			title: 'Oops...',
  			text: 'Obrigatorio Digitar a Sigla!',
  
})
   		document.frmProgramas.txtSigla.focus();
		return false;
	}
	if(document.frmProgramas.txtNome.value == ""){
   			Swal.fire({
 		    icon: 'error',
  			title: 'Oops...',
  			text: 'Obrigatorio Digitar o Nome da Sigla!',
  
})
   		document.frmProgramas.txtNome.focus();
		return false;
	}
}

function cadastrar(){
    if(validar() == false)
    return false;

	document.frmProgramas.Operacao.value = 1;
	document.frmProgramas.action = "CadProgramas.asp";
	document.frmProgramas.submit();
}
function verificar_cadastro()
{
	document.frmProgramas.Operacao.value = 2;
	document.frmProgramas.idVisualizar.value = document.frmProgramas.id.value;
	document.frmProgramas.action = "CadProgramas.asp";
	document.frmProgramas.submit();
}
function visualizar(id)
{	
	document.frmProgramas.Operacao.value = 2;
	document.frmProgramas.idVisualizar.value = id;
	document.frmProgramas.action = "CadProgramas.asp";
	document.frmProgramas.submit();
}
function alterar()
{
	if(validar() == false)
	return false;

	document.frmProgramas.Operacao.value = 3;
	document.frmProgramas.action = "CadProgramas.asp";
	document.frmProgramas.submit();
}
function mensagem(resp) {
if(resp == 1){
	Swal.fire({
      title: "Ótimo!!!",
      text: "Programa Cadastrado com Sucesso!",
      icon: "success",
      button: "Ok!",
      });
      return false;
}
else
if(resp == 2){
	 Swal.fire({
      title: "Ótimo!!!",
      text: "Programa Alterado com Sucesso!",
      icon: "success",
      button: "Ok!",
      });
      return false;
}
else	
if(resp == 3){
     Swal.fire({
      title: "Ops!!!",
      text: "Já Consta arquivos Cadastrados nesta pasta!",
      icon: "error",
      button: "Ok!",
      });
      return false;
}
}

</script>
</head>
<body>
<%if resposta = 3 or resposta = 1 or resposta = 2 then%>
<script>
  var resp = <%=resposta%>
  mensagem(resp)
</script>
<%end if%>
<div class="col-lg-10 mt-4">
    <div class="card mb-6">
      <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
        <h5 class="m-0 font-weight-bold text-primary">Cadastrar Programas</h5>
      </div>
      <div class="card-body">
        <form name="frmProgramas" id="frmProgramas" method="post">
<input type="hidden" name="Operacao" id="Operacao" />
<input type="hidden" name="idVisualizar" id="idVisualizar" />
<input type="text" name="id" id="id" value="<%=id%>" hidden/>
          <div class="form-group">
        </div>
        <div class="form-group row">
        <div class="col-4">
        
          <label for="txtSigla" class="col-form-label col-form-label-sm" >Sigla</label>
          <input type="text" class="form-control col-form-sm" id="txtSigla" name="txtSigla"  value="<%=Sigla%>"/>
        </div>
            <div class="col">
            
            <label for="txtNome" class="col-form-label col-form-label-sm" >Nome da Sigla</label>
            <input type="text" class="form-control col-form-sm" name="txtNome" id="txtNome"  value="<%=programas%>"/>
          </div>
        </div>
			
        <div class="form-group row">
        <div class="col-3">
        <div class="form-group row g-3">
           <%IF EXISTE = 1 THEN%>
<label for="status" class="col-form-label col-form-label-sm" >Status</label>
<select name="status" id="status" class="select2-single form-control col-form-label-sm">
<option value="1" <%if StatusPrograma = true then%> selected <%end if%>> Ativo </option>
<option value="0" <%if StatusPrograma = false then%> selected <%end if%>> Inativo </option>
</select>
<%END IF%>
    </div> 
       

           </div>
          </div>
        <div class="form-group">
         
        </div>
          <span class="icon text-white-50">
            <i class="fas fa-arrow-right"></i>
          </span>
          <span class="text"></span>

<input type="submit"  class="btn btn-primary" name="btnCadastrar" value="<%IF Existe = 1 THEN%>Alterar<%ELSE%>Cadastrar<%END IF%>" onClick="return <%IF Existe = 1 THEN%>alterar();mensagem();<%ELSE%>cadastrar();<%END IF%>" />
       
        
      </div>
    </div>
  </div>
  </form>
</body>
<%
   call abreConexao
   sql = "SELECT * FROM GU_Programas ORDER BY id"
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
  <th>Sigla</th>
  <th>Nome Sigla</th>
  <th>Status</th>
  <th>Operação</th>
  </tr>        
  </thead>
        
            <%
	   		Do while not rs.EOF 
				cont =cont+1
	        %>
                    
                    
         <tbody>   
         <tr>
  <td ><%=rs("Sigla")%></td>
  <td ><%=rs("Programas")%></td>
  <td ><%IF  rs("status") = TRUE THEN%>
  <font color="#009933"> ATIVO </font>
  <%ELSE%>
  <font color="#FF0000"> DESATIVO </font>
  <%END IF%></td>
                   <td align="center"><a href="#" onClick="visualizar(<%=rs("id")%>)"><img src="Imagens\editar.png" width="30"/></a></td>
             </td>
            </tr>
            <% 
                rs.Movenext()
                loop 
                call fechaConexao
				  end if
			%>
        </tbody>
        </table>
                </div>
              </div>
            </div>

</html>
<script>
    $(document).ready(function () {
       $('#dataTable').DataTable( {
        "ordering": false,
        "language": {
            "lengthMenu": "Exibindo _MENU_ registros por página",
            "zeroRecords": "Nenhum dado encontrado",
            "info": "Página _PAGE_ de _PAGES_",
            "infoEmpty": "Nenhum registro encontrado",
            "infoFiltered": "(_MAX_ rotas filtradas)",
            "search": "Buscar:",
            "paginate":{
              "previous": "Anterior",
              "next": "Próximo"
            }
        }
    } );
    });
  </script>
  <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="card-body text-center">
                            <div class="text-muted">Todos os Direitos Reservados a TI/ADAPEC 2021</div>
                        </div>