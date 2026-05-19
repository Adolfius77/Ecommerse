<%-- Moderación de reseñas (vista administrador) --%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administración - Moderación de reseñas</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/estiloGestionPanel.css">
    </head>
    <body>
        <div class="layout-container">
            <aside class="sidebar">
                <nav>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa-solid fa-house"></i> DashBoard</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/gestionProductos" class="active"><i class="fa-solid fa-warehouse"></i> Inventario</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/gestionCategorias"><i class="fa-solid fa-tags"></i> Categorías</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/gestionUsuarios"><i class="fa-solid fa-users"></i> Usuarios</a></li>
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
                            <h2>Moderación de reseñas</h2>
                            <p>${tituloFiltro != null ? tituloFiltro : 'Todas las reseñas'}</p>
                            <p>
                                <a href="${pageContext.request.contextPath}/admin/moderacionResenas">Todas</a> |
                                <a href="${pageContext.request.contextPath}/admin/moderacionResenas?filtro=pendientes">Pendientes</a> |
                                <a href="${pageContext.request.contextPath}/admin/moderacionResenas?filtro=aprobadas">Aprobadas</a>
                            </p>
                        </div>
                    </div>

                    <c:if test="${not empty mensaje}">
                        <p style="color: green;">${mensaje}</p>
                    </c:if>
                    <c:if test="${not empty error}">
                        <p style="color: red;">${error}</p>
                    </c:if>

                    <div class="table-wrap">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Producto</th>
                                    <th>Usuario</th>
                                    <th>Calificación</th>
                                    <th>Comentario</th>
                                    <th>Fecha</th>
                                    <th>Estado</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="r" items="${resenas}">
                                    <tr>
                                        <td>
                                            <c:set var="rid" value="${r.id}"/>
                                            ${nombrePorResena[rid] != null ? nombrePorResena[rid] : '—'}
                                        </td>
                                        <td>${r.nombreUsuario}</td>
                                        <td>${r.calificacion} / 5</td>
                                        <td class="comentario-celda" title="${r.comentario}">${r.comentario}</td>
                                        <td><fmt:formatDate value="${r.fecha}" pattern="yyyy-MM-dd"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${r.aprobada}">Aprobada</c:when>
                                                <c:otherwise>Pendiente</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="acciones-celda">
                                            <c:if test="${!r.aprobada}">
                                                <form method="POST" action="${pageContext.request.contextPath}/admin/moderacionResenas" style="display:inline;">
                                                    <input type="hidden" name="accion" value="aprobar">
                                                    <input type="hidden" name="resenaId" value="${r.id}">
                                                    <button type="submit" class="btn-primario" title="Aprobar reseña"><i class="fa-solid fa-check"></i> Aprobar</button>
                                                </form>
                                            </c:if>
                                            <form method="POST" action="${pageContext.request.contextPath}/admin/moderacionResenas" style="display:inline;">
                                                <input type="hidden" name="accion" value="rechazar">
                                                <input type="hidden" name="resenaId" value="${r.id}">
                                                <button type="submit" class="btn-peligro" title="Eliminar reseña"><i class="fa-solid fa-trash"></i> Eliminar</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty resenas}">
                                    <tr>
                                        <td colspan="7">No hay reseñas para mostrar.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </main>
                <footer class="footer">
                    <p>Aplicaciones Web – Unidad 4</p>
                </footer>
            </div>
        </div>
    </body>
</html>
