<%-- Gestión de usuarios: activar o desactivar cuentas (vista administrador) --%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administración - Usuarios</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/estiloGestionPanel.css">
    </head>
    <body>
        <div class="layout-container">
            <aside class="sidebar">
                <nav>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa-solid fa-house"></i> DashBoard</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/gestionProductos"><i class="fa-solid fa-warehouse"></i> Inventario</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/gestionCategorias"><i class="fa-solid fa-tags"></i> Categorías</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/gestionUsuarios" class="active"><i class="fa-solid fa-users"></i> Usuarios</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/gestionPedidos"><i class="fa-solid fa-receipt"></i> Pedidos y pagos</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/moderacionResenas"><i class="fa-solid fa-star-half-stroke"></i> Moderación reseñas</a></li>
                        <li><a href="loginView.jsp"><i class="fa-solid fa-right-to-bracket"></i> Iniciar sesión</a></li>
                    </ul>
                </nav>
            </aside>
            <div class="main-panel">
                <header class="topbar">
                    <div class="topbar-links">
                        <a href="${pageContext.request.contextPath}/Perfil"><i class="fas fa-user"></i> Perfil</a>
                        <a href="${pageContext.request.contextPath}/Logout"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</a>
                    </div>
                </header>
                <main class="content">
                    <div class="page-header">
                        <div>
                            <h2>Gestión de usuarios</h2>
                            <p>Activa o desactiva cuentas.</p>
                        </div>
                    </div>

                    <!-- Mensajes de éxito/error -->
                    <c:if test="${not empty mensaje}">
                        <div style="background: #e6f4ea; color: #137333; padding: 15px; border-radius: 4px; margin-bottom: 20px; border-left: 4px solid #137333;">
                            <i class="fa-solid fa-check-circle"></i> ${mensaje}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div style="background: #fce8e6; color: #d93025; padding: 15px; border-radius: 4px; margin-bottom: 20px; border-left: 4px solid #d93025;">
                            <i class="fa-solid fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>

                    <div class="table-wrap">
                        <c:choose>
                            <c:when test="${empty usuarios}">
                                <p style="text-align: center; padding: 20px;">No hay usuarios registrados.</p>
                            </c:when>
                            <c:otherwise>
                                <table class="data-table" style="color: black">
                                    <thead>
                                        <tr>
                                            <th>Correo</th>
                                            <th>Rol</th>
                                            <th>Teléfono</th>
                                            <th>Estado de cuenta</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="usuario" items="${usuarios}">
                                            <tr>
                                                <td>${usuario.correo}</td>
                                                <td><span style="background: #3498db; color: white; padding: 4px 8px; border-radius: 4px; font-size: 0.9em;">${usuario.rol}</span></td>
                                                <td>${usuario.telefono}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${usuario.activo}">
                                                            <span class="badge-estado badge-activo">Activo</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge-estado badge-inactivo">Inactivo</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="acciones-celda">
                                                    <form method="POST" action="${pageContext.request.contextPath}/admin/gestionUsuarios" style="display: inline;">
                                                        <input type="hidden" name="usuarioId" value="${usuario.id}">
                                                        <c:choose>
                                                            <c:when test="${usuario.activo}">
                                                                <input type="hidden" name="accion" value="desactivar">
                                                                <button type="submit" class="btn-secundario" style="background: #d93025; color: white; padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer;">
                                                                    <i class="fa-solid fa-ban"></i> Desactivar
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <input type="hidden" name="accion" value="activar">
                                                                <button type="submit" class="btn-primario" style="background: #137333; color: white; padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer;">
                                                                    <i class="fa-solid fa-check-circle"></i> Activar
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </main>
                <footer class="footer">
                    <p>Aplicaciones Web – Unidad 4</p>
                </footer>
            </div>
        </div>
    </body>
</html>
