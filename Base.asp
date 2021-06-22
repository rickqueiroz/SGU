<%IF  Session("CPF_Usu") <> "" THEN%>

<!DOCTYPE html>
<html lang"pt-br"
    <head>
        <title>SGA</title>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
    <meta charset="iso-8859-1">
</head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand" href="index.asp">SGA</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
             <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
                <div class="input-group">
                    
                </div>
            </form>
            <!-- Navbar-->
           <div class="btn-group">
  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Sair
  </button>
  <div class="dropdown-menu">
    <a class="dropdown-item" href="Logoff.asp">Sair</a>   
  </div>
</div>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <a class="nav-link" href="index.asp">
                                <div class="sb-nav-link-icon"><i class="fa fa-home" aria-hidden="true"></i></div>
                                Inicio
                            </a>
							<%if session("idPerfil") = "Tecnico" then%>
                            <a class="nav-link" href="CadUpload.asp">
                                <div class="sb-nav-link-icon"><i class="fa fa-paperclip" aria-hidden="true"></i></div>
                                Anexar Documentos
                            </a>
						    <%end if%>
                            <a class="nav-link" href="BuscarProgramas.asp">
                                <div class="sb-nav-link-icon"><i class="fa fa-search" aria-hidden="true"></i></div>
                                Buscar Documentos
                            </a>
							<%if session("idPerfil") = "Administrador" then%>
                            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fa fa-lock" aria-hidden="true"></i></div>
                                Administrador
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="CadPessoaUp.asp">Cadastro de Usuario</a>
                                    <a class="nav-link" href="CadUpload.asp"> Anexar Documentos</a>
                                    <a class="nav-link" href="CadProgramas.asp"> Cadastro de Programas</a>
                                </nav>
                            </div>
						   <%end if%>	
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                       
                       
                
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        
    </body>
	
	
</html>
<%ELSE
response.redirect("http://intranet.adapec.to.gov.br/intranet")
end if%>