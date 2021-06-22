<!--#include file ="lib/Conexao.asp"-->
<%
  Session.Abandon()
  response.redirect("http://intranet.adapec.to.gov.br/intranet")
%>