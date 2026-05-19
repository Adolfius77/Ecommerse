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
        <title>Proyecto ECommerce - Registro</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="./styles/estiloRegistro.css">
    </head>
    <body>

        <div class="layout-container">
            <!-- Menu Lateral -->
            <aside class="sidebar">
                <nav>
                    <ul>
                         <li><a href="index.jsp"><i class="fa-solid fa-house"></i> Inicio</a></li>
                        <li><a href="loginView.jsp"><i class="fa-solid fa-right-to-bracket"></i> Iniciar sesión</a></li>
                    </ul>
                </nav>
            </aside>

            <!-- Panel principal (Derecha) -->
            <div class="main-panel">

                <!-- Barra Superior -->
                <header class="topbar">
                    <div class="topbar-links">              
                    </div>
                </header>

                <!-- Contenido -->
                <main class="content">
                    <div class="registro-card">
                        <div class="registro-header">
                            <h2>Crea tu cuenta</h2>
                            <p>Completa los datos para registrarte en el sistema.</p>
                        </div>
                        <div class="registro-header">
                            <h2>Crea tu cuenta</h2>
                            <p>Completa los datos para registrarte en el sistema.</p>
                        </div>
                        
                        <% if (request.getAttribute("exito") != null) { %>
                            <div style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 15px; border-radius: 5px; text-align: center; border: 1px solid #c3e6cb;">
                                <%= request.getAttribute("exito") %>
                            </div>
                            <script>
                                
                                setTimeout(function() {
                                    window.location.href = '<%= request.getAttribute("urlDestino") %>';
                                }, 2000); 
                            </script>
                        <% } %>

                        <% if (request.getAttribute("error") != null) { %>
                            <div style="background-color: #f8d7da; color: #721c24; padding: 10px; margin-bottom: 15px; border-radius: 5px; text-align: center; border: 1px solid #f5c6cb;">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        
                        <form  class="registro-form" action="${pageContext.request.contextPath}/Registro" method="POST">
                            <div class="form-grid">
                                <div class="campo-form">
                                    <label for="nombre">Nombre</label>
                                    <input type="text" id="nombre" name="nombre" required>
                                </div>
                                <div class="campo-form">
                                    <label for="apellido">Apellido</label>
                                    <input type="text" id="apellido" name="apellido" required>
                                </div>
                            </div>
                            <div class="form-grid">
                                <div class="campo-form">
                                    <label for="email">Correo electrónico</label>
                                    <input type="email" id="email" name="email" required>
                                </div>
                                <div class="campo-form">
                                    <label for="telefono">Teléfono</label>
                                    <input type="tel" id="telefono" name="telefono" required>
                                </div>
                            </div>
                            <div class="form-grid">
                                <div class="campo-form">
                                    <label for="password">Contraseña</label>
                                    <input type="password" id="password" name="password" required>
                                </div>
                                <div class="campo-form">
                                    <label for="confirmar">Confirmar contraseña</label>
                                    <input type="password" id="confirmar" name="confirmar" required>
                                </div>
                            </div>
                            <div class="campo-form">
                                <label for="direccion">Dirección</label>
                                <input type="text" id="direccion" name="direccion" placeholder="Calle, número, ciudad">
                            </div>
                            <div class="terminos">
                                <label><input type="checkbox" required> Acepto los términos y condiciones</label>
                            </div>
                            <div class="botones-form">
                                <button type="submit" class="btn-primario">Crear cuenta</button>
                                <a class="btn-secundario" href="loginView.jsp">¿Ya tienes cuenta? Inicia sesión</a>
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
