<%-- 
    Document   : newjsp
    Created on : May 12, 2026, 7:34:43 PM
    Author     : adolfo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Aplicaciones Web - Unidad 2</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="./styles/estiloLogin.css">
    </head>
    <body>

        <div class="layout-container">
            <!-- Menu Lateral -->
            <aside class="sidebar">
                <nav>
                    <ul>
                        <li><a href="index.jsp"><i class="fa-solid fa-house"></i> Inicio</a></li>
                        <li><a href="${pageContext.request.contextPath}/catalogo"><i class="fa-solid fa-box-open"></i> Catálogo de productos</a></li>
                        <li><a href="${pageContext.request.contextPath}/carrito"><i class="fa-solid fa-shopping-cart"></i> Carrito de compras</a></li>
                        <li><a href="${pageContext.request.contextPath}/misPedidos" class="active"><i class="fa-solid fa-clock-rotate-left"></i> Mis pedidos</a></li>
                        <li><a href="${pageContext.request.contextPath}/Perfil"><i class="fa-solid fa-user"></i> Mi perfil</a></li>
                        <li><a href="loginView.jsp"><i class="fa-solid fa-right-to-bracket"></i> Iniciar sesión</a></li>
                    </ul>
                </nav>
            </aside>

            <!-- Panel principal (Derecha) -->
            <div class="main-panel">

                <!-- Barra Superior -->
                <header class="topbar">
                    <div class="topbar-links">
                        <a href="${pageContext.request.contextPath}/Perfil"><i class="fas fa-user"></i> Perfil</a>
                        <a href="${pageContext.request.contextPath}/Logout"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</a>               
                    </div>
                </header>

                <!-- Contenido -->
                <main class="content">
                    <div class="contenedor-login">
                        <div class ="cabecera-login">
                            <h2>Bienvenido al sistema</h2>
                            <p>Ingrese sus credenciales</p>
                        </div>
                        <% if (request.getAttribute("exito") != null) {%>
                        <div style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 15px; border-radius: 5px; text-align: center; border: 1px solid #c3e6cb;">
                            <%= request.getAttribute("exito")%>
                        </div>
                        <script>

                            setTimeout(function () {
                                window.location.href = '<%= request.getAttribute("urlDestino")%>';
                            }, 2000);
                        </script>
                        <% } %>

                        <% if (request.getAttribute("error") != null) {%>
                        <div style="background-color: #f8d7da; color: #721c24; padding: 10px; margin-bottom: 15px; border-radius: 5px; text-align: center; border: 1px solid #f5c6cb;">
                            <%= request.getAttribute("error")%>
                        </div>
                        <% }%>

                        <form id = "loginForm" class = "formulario-login" action="${pageContext.request.contextPath}/login" method="POST">
                            <input type="hidden" name="accion" value="loginAdmin">
                            <div class="campo-form">
                                <label for="email">Correo electronico:</label>
                                <input type="email" id="email" name="email" required>
                            </div>
                            <div class="campo-form">
                                <label for="password">Contraseña:</label>
                                <input type="password" id="password" name="password" required>
                            </div>
                            <div class="contrasena-olvidada">
                                <p><a href="#recuperar">¿Olvidaste tu contraseña?</a></p>
                            </div>
                            <div class = "boton-login">
                                <button type="submit">Iniciar sesión</button>
                            </div>

                            <div class = "pie-login">
                                <hr>
                                <p>¿No tienes una cuenta? <a href="registroView.jsp">Regístrate aquí</a></p>
                            </div>

                            <div class="btn-regresar">
                                <button type="button" onclick="window.history.back();"><i class="fa-solid fa-arrow-left"></i> Regresar</button>                       
                            </div>
                        </form>
                    </div>
                </main>

                <!-- Pie de pagina -->
                <footer class="footer">
                    <p>Aplicaciones Web – Unidad 4</p>
                </footer>

            </div>
        </div>



    </body>
</html>