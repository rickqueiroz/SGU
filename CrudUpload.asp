<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>

<!--#include file="upload.lib.asp"-->
<!--#include file ="lib/Conexao.asp"-->
<%

op = request("op") 
Dim Form : Set Form = New ASPForm
Server.ScriptTimeout = 1440222 'Limite de 24 minutos de execu??o de c?digo, o upload deve acontecer dentro deste tempo ou ent?o ocorre erro de limite de tempo.
'Const MaxFileSize = 10240000 'Bytes. Aqui est? configurado o limite de 100 MB por upload (inclui todos os tamanhos de arquivos e conte?dos dos formul?rios).
Const MaxFileSize = 300000000
if op = 1 then
	'id = request("id")
    'desativar(id)
	
if Form.State = 0 Then
	

        For each Key in Form.Texts.Keys
            if Key = "txtTitulo" then   
                titulo = Form.Texts.Item(Key)	
            elseIf Key = "txtDescricao" Then
                desc = Form.Texts.Item(Key)
			elseIf Key = "cpf" Then
                cpf = Form.Texts.Item(Key)
			elseIf Key = "codprograma" Then
                codprograma = Form.Texts.Item(Key)
            else
                end if

            'Response.Write "Elemento: " & Key & " = " & Form.Texts.Item(Key) & "<br />"
        Next
        For each Field in Form.Files.Items
            ' # Field.Filename : Nome do Arquivo que chegou.
            ' # Field.ByteArray : Dados bin?rios do arquivo, ?til para subir em blobstore (MySQL).
            
			
			'Field.SaveAs Server.MapPath(".") & "\upload\" & Field.FileName
			call abreConexao
			sql = "SELECT ISNULL(MAX(QuantArquivo), 0) + 1 AS Quantidade  FROM  GU_NumeroArquivo"
			set rs = conn.execute(sql)
			NumeroArquivo = rs("Quantidade")&"."&Split(Field.FileName,".")(1)
			
			Field.SaveAs Server.MapPath(".") & "\upload\" & NumeroArquivo
            
			
            sql = "INSERT INTO GU_Arquivos (Titulo, Descricao, cpf, CodPrograma ,Arquivo, status, DataArquivo) VALUES ('"&titulo&"','"&desc&"', '"&cpf&"', '"&codprograma&"' ,'.\upload\"&NumeroArquivo&"', 1, getdate())"  
			conn.Execute(sql)
			sql = "Update GU_NumeroArquivo set QuantArquivo='"&rs("Quantidade")&"'"
			conn.execute(sql)
            rs.Close
            Set rs = Nothing
            call fechaConexao					
			response.redirect("CadUpload.asp?resp=1")
          
        Next
else
response.redirect("CadUpload.asp?resp=2")
end if 
else
id = request("id")
desativar(id)
end if 
function desativar(id)
    on error resume next
	call abreConexao
    sql = "UPDATE GU_arquivos SET status = 0 WHERE id ='"&id&"'"
    Set rs = conn.Execute(sql)
    %>
        <script>
        window.location.assign('CadUpload.asp');
        </script>
    <%
    rs.close
    Set rs = Nothing
	call fechaConexao
end function 
%>