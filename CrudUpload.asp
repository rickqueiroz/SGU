<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="upload.lib.asp"-->
<!--#include file ="lib/Conexao.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="pt-br">
<%

Response.Charset = "ISO-8859-1"
op = request("op") 
Dim Form : Set Form = New ASPForm
Server.ScriptTimeout = 1440 'Limite de 24 minutos de execu��o de c�digo, o upload deve acontecer dentro deste tempo ou ent�o ocorre erro de limite de tempo.
Const MaxFileSize = 10240000 'Bytes. Aqui est� configurado o limite de 100 MB por upload (inclui todos os tamanhos de arquivos e conte�dos dos formul�rios).
if op = 1 then
	id = request("id")
    desativar(id)
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
            ' # Field.ByteArray : Dados bin�rios do arquivo, �til para subir em blobstore (MySQL).
            Field.SaveAs Server.MapPath(".") & "\upload\" & Field.FileName
            on error resume next
			call abreConexao
			
            sql = "INSERT INTO GU_Arquivos (Titulo, Descricao, cpf, CodPrograma ,Arquivo, status, DataArquivo) VALUES ('"&titulo&"','"&desc&"', '"&cpf&"', '"&codprograma&"' ,'.\upload\"&Field.FileName&"', 1, getdate())"  

            Set rs = conn.Execute(sql)
                response.redirect("CadUpload.asp?resp=1")
            rs.Close
            Set rs = Nothing	
        Next
		call fechaConexao
End If
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