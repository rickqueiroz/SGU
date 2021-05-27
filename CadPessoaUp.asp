<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<!--#include file ="lib/Conexao.asp"-->
<!--#include file ="Base.asp"-->
<% 
dim resposta
resposta = 0
IF REQUEST("OPERACAO") = 1 THEN 'CADASTRAR
	call abreConexao
 		sql="INSERT INTO GU_CadPessoasUp(CPF, Nome, idPerfil, CodPrograma, status, DataCadUsuario, cpfCad) VALUES('"&replace(replace(replace(request.form("txtCPF"),".",""),".", ""),"-","")&"', '"&request.form("txtNome")&"','"&request.form("perfil")&"', '"&request.form("programas")&"' , 1 , getdate(),'"&request.form("cpf")&"')"
	conn.execute(sql)
	resposta = 1 
	Session("CPF_Usu") = replace(replace(request.form("txtCPF"),".",""),"-","")
	session("idPerfil") = request.form("perfil")
	session("CodPrograma") = request.form("programas")
	'response.Redirect("CadPessoaUp.asp?cpf="&Session("CPF_Usu")&"")
	call fechaConexao 
	
ELSEIF REQUEST("Operacao") = 2 THEN 'VISUALIZAR
	call abreConexao
	sql = "SELECT CPF, Nome, idPerfil, CodPrograma, status FROM GU_CadPessoasUp WHERE CPF = '"&replace(replace(request("CpfVisualizar"),".",""),"-","")&"'"
	set rs = conn.execute(sql)
	if not rs.eof then
	CPF = left(rs("CPF"),3)&"."&mid(rs("CPF"),4,3)&"."&mid(rs("CPF"),7,3)&"-"&right(rs("CPF"),2)
	Nome = rs("Nome")
	idPerfil = rs("idPerfil")
	CodPrograma = rs("CodPrograma")
	StatusUsuario = rs("status")
	Existe = 1
	else
	CPF = request.form("CpfVisualizar")
	Existe = 0 
	end if
	call fechaConexao
ELSEIF REQUEST("Operacao") = 3 THEN 'ALTERAR
	call abreConexao
	sql = "UPDATE GU_CadPessoasUp SET Nome = '"&request.Form("txtNome")&"', idPerfil = '"&request.form("perfil")&"', CodPrograma = '"&request.Form("programas")&"', status = '"&request.Form("status")&"' WHERE CPF = '"&replace(replace(replace(request.form("txtCPF"),".",""),".",""),"-","")&"'"
	conn.execute(sql)
	resposta = 2
	call fechaConexao
	'response.Redirect("CadPessoaUp.asp")
END IF

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cadastro</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.all.min.js"></script>
<script src="javascript/Mascara.js"></script>
<script type="text/javascript">	
 
function validar() {
	if(document.frmCadastro.txtCPF.value == ""){
   			Swal.fire({
 		    icon: 'error',
  			title: 'Oops...',
  			text: 'Obrigatorio Digitar o CPF!',
  
})
   		document.frmCadastro.txtCPF.focus();
		return false;
	}
	if(document.frmCadastro.txtNome.value == ""){
         Swal.fire({
 		    icon: 'error',
  			title: 'Oops...',
  			text: 'Obrigatorio Digitar o Nome!',
			
		 })
         document.frmCadastro.txtNome.focus();
         return false;
     }
	 if (document.frmCadastro.perfil.value == ""){
		 Swal.fire({
 		    icon: 'error',
  			title: 'Oops...',
  			text: 'Obrigatorio Selecionar o perfil!',
			
		 })
		 document.frmCadastro.perfil.focus()
		 return false;
		 }
		 if (document.frmCadastro.programas.value == ""){
		 Swal.fire({
 		    icon: 'error',
  			title: 'Oops...',
  			text: 'Obrigatorio Selecionar a Pasta!',
			
		 })
		 document.frmCadastro.programas.focus()
		 return false;
		 }
     return true;
}
function cadastrar(){
    if(validar() == false)
    return false;

	document.frmCadastro.Operacao.value = 1;
	document.frmCadastro.action = "CadPessoaUp.asp";
	document.frmCadastro.submit();
}
function visualizar(cpf)
{	
	document.frmCadastro.Operacao.value = 2;
	document.frmCadastro.CpfVisualizar.value = cpf;
	document.frmCadastro.action = "CadPessoaUp.asp";
	document.frmCadastro.submit();
}
function verificar_cadastro()
{
	document.frmCadastro.Operacao.value = 2;
	document.frmCadastro.CpfVisualizar.value = document.frmCadastro.txtCPF.value;
	document.frmCadastro.action = "CadPessoaUp.asp";
	document.frmCadastro.submit();
}

function alterar()
{
	if(validar() == false)
	return false;
	
	document.frmCadastro.Operacao.value = 3;
	document.frmCadastro.action = "CadPessoaUp.asp";
	document.frmCadastro.submit();
}
function novo()
{
	document.frmCadastro.Operacao.value = 0;
	document.frmCadastro.txtCPF.value = '';
	document.frmCadastro.action = "CadPessoaUp.asp";
	document.frmCadastro.submit();
}
function upload(cpf)
{
	document.frmCadastro.Operacao.value = 5;
	document.frmCadastro.action = "CadUpload.asp?cpf="+cpf;
	document.frmCadastro.submit();
}
function mensagem(resp){
if(resp == 1){
	Swal.fire({
      title: "Ótimo!!!",
      text: "Usuário Cadastrado com Sucesso!",
      icon: "success",
      button: "Ok!",
      });
      return false;
}
else
if(resp == 2){
	 Swal.fire({
      title: "Ótimo!!!",
      text: "Usuário Alterado com Sucesso!",
      icon: "success",
      button: "Ok!",
      });
      return false;
}
}
</script>
 </head>
<body>
<%if resposta = 1 or resposta = 2 then%>
<script>
  var resp = <%=resposta%>
  mensagem(resp)
</script>
<%end if%>
<div class="col-lg-10 mt-4">
    <div class="card mb-6">
      <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
        <h5 class="m-0 font-weight-bold text-primary">Cadastrar Documentos</h5>
      </div>
      <div class="card-body">
        <form name="frmCadastro" name="frmCadastro" method="post" >
        <input type="hidden" name="Operacao" id="Operacao">
		<input type="hidden" name="CpfVisualizar" id="CpfVisualizar">
          <div class="form-group">
        </div>
        <div class="form-group row">
        <div class="col-4">
          <label for="txtCPF" class="col-form-label col-form-label-sm" >CPF</label>
          <input type="text" class="form-control col-form-sm" onKeyPress="MascaraCPF(txtCPF)"  name="txtCPF" id="txtCPF"  value="<%IF Existe = 1 THEN Response.Write(CPF) ELSE Response.Write(Request("txtCPF")) END IF%>" maxlength="14" onChange="MascaraCPF(txtCPF);verificar_cadastro();"<%IF REQUEST ("Operacao") = 2 AND Existe = 1 THEN%> readonly<%END IF%>/>
        </div>
            <div class="col">
            <label for="txtNome" class="col-form-label col-form-label-sm" >Nome Completo</label>
            <input type="text" class="form-control col-form-sm" id="txtNome" name="txtNome" size="60"  value="<%=Nome%>"/>
          </div>
        </div>

        <div class="form-group row g-3">
        <div class="col-3">
        
        <% 
call abreConexao 
 sql="SELECT idPerfil, Perfil FROM GU_Perfil order by Perfil"
set rs=conn.execute(sql) 
%>
<label for="perfil" class="col-form-label col-form-label-sm" >Perfil</label>
<select name="perfil" id="perfil"  class="select2-single form-control col-form-label-sm" >
<option value="">Selecionar</option>
<%do while not rs.eof%>
<option value="<%=rs("idPerfil")%>" <%if rs("idPerfil") = CodPrograma then%>selected<%end if%>><%=rs("Perfil")%>
</option>
<% rs.movenext 
			loop 
call fechaConexao
%>
</select>
      </div>
      
          <div class="col-3">
<% 
call abreConexao 
 sql = "SELECT id, Programas FROM GU_Programas order by Programas"
set rs1 = conn.execute(sql) 
%>
<label for="programas" class="col-form-label col-form-label-sm" >Pastas</label>
<select name="programas" id="programas" class="select2-single form-control col-form-label-sm" >
			<option value="">Selecionar</option>
				<%do while not rs1.eof%>
			<option value="<%=rs1("id")%>" <%if rs1("id") = CodPrograma then%>selected<%end if%>><%=rs1("Programas")%>
			</option>
<% rs1.movenext 
			loop 
call fechaConexao
%>
</select>   
          </div>
           <div class="col-3">
           <%IF EXISTE = 1 THEN%>
<label for="status" class="col-form-label col-form-label-sm" >Status</label>
<select name="status" id="status" class="select2-single form-control col-form-label-sm">
<option value="1" <%if StatusUsuario = true then%> selected <%end if%>> Ativo </option>
<option value="0" <%if StatusUsuario = false then%> selected <%end if%>> Inativo </option>
</select>
<%END IF%>
<input type="text" name="cpf" id="cpf" value="<%=Session("CPF_Usu")%>" hidden/>
           </div>
          </div>
        <div class="form-group">
         
        </div>
          <span class="icon text-white-50">
            <i class="fas fa-arrow-right"></i>
          </span>
          <span class="text"></span>

<input type="submit" class="btn btn-primary" name="btnCadastro" value="<%IF Existe = 1 THEN%>Alterar<%ELSE%>Cadastrar<%END IF%>" onClick="return <%IF Existe = 1 THEN%>alterar();<%ELSE%>cadastrar();<%END IF%>" />
<%IF Existe = 1 THEN%>
<input type="button" class="btn btn-primary" name="btnNovo" value="Novo" onClick="return novo();" />

<%END IF%>
        </button>
     </div>
    </div>
  </div>

</form>
</body>
<%
   call abreConexao
   sql = "SELECT GU_CadPessoasUp.CPF, GU_CadPessoasUp.Nome, GU_Perfil.Perfil, GU_Programas.Programas, FORMAT (DataCadUsuario, 'dd/MM/yyyy ') as DataCadUsuario,GU_CadPessoasUp.status AS statusUsuario FROM GU_CadPessoasUp INNER JOIN GU_Perfil ON GU_Perfil.idPerfil = GU_CadPessoasUp.idPerfil INNER JOIN GU_Programas ON GU_Programas.id = GU_CadPessoasUp.CodPrograma ORDER BY Nome;"
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
            <th >Cpf</th>
            <th >Nome Completo</th>
            <th >Perfil</th>
            <th >Pastas</th>
             <th >Data</th>
            <th >Status</th>
            <th >Ações</th>
            </tr>
        </thead>
        
            <%
	   		Do while not rs.EOF 
				cont =cont+1
	        %>
                    
                    
         <tbody>   
                  <tr>
  <td ><%=rs("CPF")%></td>
  <td ><%=rs("Nome")%></td>
  <td ><%=rs("Perfil")%></td>
  <td ><%=rs("Programas")%></td>
  <td ><%=rs("DataCadUsuario")%></td>
  <td ><%IF  rs("statusUsuario") = TRUE THEN%>
                          <font color="#009933"> ATIVO </font>
                          <%ELSE%>
  						  <font color="#FF0000"> INATIVO </font>
                          <%end if%></td>               
                <td>
                   <a href="#" onClick="visualizar(<%=rs("CPF")%>)"><img src="Imagens\editar.png" width="30"/></a>
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