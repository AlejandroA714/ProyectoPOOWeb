 <%
     //Para evitar el acceso no authorizado
     
     HttpSession sesion = request.getSession();
     
     if(sesion.getAttribute("Programador") == null){
         response.sendRedirect("../index.jsp?Error=Debe iniciar sesion");
         return;
     }
     //Codigo para obtener las cookies
         Cookie[] cookies = null;
        
         cookies = request.getCookies();
         
         String idEmpleado = (String) cookies[1].getValue();
         String NombreUser = (String) cookies[2].getValue();
         int idDepartamento = Integer.parseInt(cookies[3].getValue());
         String NombreDepartamento = (String) cookies[4].getValue();     
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
        <link href="../css/bootstrap.css" rel="stylesheet">
        <link href="../css/mdb.css" rel="stylesheet">
        <link href="../css/style.css" rel="stylesheet">
        <style>
            .map-container{
                overflow:hidden;
                padding-bottom:56.25%;
                position:relative;
                height:0;
            }
            .map-container iframe{
                left:0;
                top:0;
                height:100%;
                width:100%;
                position:absolute;
            }
            </style>
    </head>
  <body class="grey lighten-3">
    <!-- Sidebar -->
    <div class="sidebar-fixed position-fixed">

      <a class="logo-wrapper waves-effect">
        <img src="https://mdbootstrap.com/img/logo/mdb-email.png" class="img-fluid" alt="">
      </a>
        <div class="list-group list-group-flush">
        <a href="index.jsp" class="list-group-item list-group-item-action waves-effect">
          <i class="fas fa-chart-pie mr-3"></i>Dashboard
        </a>
        <a href="bitacora.jsp" class="list-group-item active  waves-effect">
          <i class="fas fa-book mr-3"></i>Bitacora</a>
          <a href="#" class="list-group-item list-group-item-action waves-effect">
          <i class="fas fa-lock mr-3"></i>Cambiar Contraseña</a>
           <a href="../Servicios/cerrarsesion.jsp" class="list-group-item red-text list-group-item-action waves-effect">
          <i class="fas fa-sign-out-alt mr-3"></i>Cerrar Sesion</a>
      </div>

    </div>
    <!-- Sidebar -->

  <!--Main layout-->
  <main class="pt-5 mx-lg-5">
    <div class="container-fluid">
   <!--WorkArea-->
    <div class="row wow fadeIn">

        <!--Grid column-->
        <div class="col-lg-6 col-md-6 mb-4">

          <!--Card-->
            <div class="card">

                <!-- Card header -->
                <div class="card-header text-center">
                    Actualizar Bitacora
                </div>

                <!--Card content-->
                <div class="card-body">

                    <a href="ActualizarBit.jsp" class="btn btn-success">Actualizar bitacora</a>

                </div>

            </div>
          <!--/.Card-->

        </div>
        <!--Grid column-->
    </div>
   
            <div class="bg-white p-3 ">
             <h4 class="grey-text pt-3">Actualizar Bitacora</h4>
             
             <div>
                <%@page import="Datos.Conexion" %>
                <%@page import="java.sql.*" %>
                <%
                   int id = Integer.parseInt(request.getParameter("id"));
                   Connection conn = Conexion.Conectarse();
                   if(conn == null){
                       out.print("<p class='alert alert-danger'>Ocurrio un error</p>");
                       return;
                   }
                    CallableStatement proc = conn.prepareCall("{call  mostrar_bitacoras (?)}");
                    proc.setInt(1, idDepartamento);
                    ResultSet bitacora = proc.executeQuery();
                    bitacora.beforeFirst();
                    while(bitacora.next()){
                        if(bitacora.getInt(1) == id){
                    
                %>
                <form class="pl-5 pr-5 pt-3" action="Actualizar.jsp" method="POST">
                        <input type="hidden" value="<%=bitacora.getString(4)%>" name="id" >
                      <div class="form-group">
                        <label for="exampleInputPassword1">Descripcion</label>
                        <textarea  class="form-control" disabled><%= bitacora.getString(2) %>
                        </textarea>
                      </div>
                      <div class="form-group">
                        <label for="exampleInputEmail1">Porcentaje:</label>
                        <input type="text" class="form-control" value="<%= bitacora.getString(3) %>" disabled>
                        <small id="emailHelp" class="form-text text-muted"></small>
                      </div>
                      <div class="form-group">
                        <label for="exampleInputPassword1">Observaciones</label>
                        <textarea  class="form-control" disabled><%= bitacora.getString(5) %>
                        </textarea>
                      </div>
                        <%
                            if(request.getParameter("Error") != null){
                        %>
                        <p class="alert alert-danger mb-0"><%= request.getParameter("Error") %></p>
                        <%}%>
                      <button type="submit" class="btn btn-primary">Actualizar</button>
                   </form>
              </div>
           </div>
   <!--WorkArea-->
    </div>
  </main>
  <!--Main layout-->

                    <!-- SCRIPTS -->
        <script type="text/javascript" src="../js/jquery.js"></script>
        <script type="text/javascript" src="../js/popper.js"></script>
        <script type="text/javascript" src="../js/bootstrap.js"></script>
        <script type="text/javascript" src="../js/mdb.js"></script>
        <script type="text/javascript">
              new WOW().init();
        </script>
    </body>
</html>

