<%@ LANGUAGE="VBSCRIPT" CODEPAGE="1252" ENABLESESSIONSTATE="FALSE" LCID="1046" %>
<!--#include file="upload.lib.asp"-->
<% Response.Charset = "ISO-8859-1"

Dim Form : Set Form = New ASPForm
Server.ScriptTimeout = 1440 ' Limite de 24 minutos de execução de código, o upload deve acontecer dentro deste tempo ou então ocorre erro de limite de tempo.
Const MaxFileSize = 10240000 ' Bytes. Aqui está configurado o limite de 100 MB por upload (inclui todos os tamanhos de arquivos e conteúdos dos formulários).
If Form.State = 0 Then

	For each Key in Form.Texts.Keys
		Response.Write "Elemento: " & Key & " = " & Form.Texts.Item(Key) & "<br />"
	Next

	For each Field in Form.Files.Items
		' # Field.Filename : Nome do Arquivo que chegou.
		' # Field.ByteArray : Dados binários do arquivo, útil para subir em blobstore (MySQL).
		Field.SaveAs Server.MapPath(".") & "\upload\" & Field.FileName
		Response.Write "Arquivo: " & Field.FileName & " foi salvo com sucesso. <br />"
	Next
End If
%>
