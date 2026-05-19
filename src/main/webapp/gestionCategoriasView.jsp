<%-- Gestión de categorías del catálogo (vista administrador) --%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administración - Categorías</title>
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
                        <li><a href="${pageContext.request.contextPath}/admin/gestionCategorias" class="active"><i class="fa-solid fa-tags"></i> Categorías</a></li>
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
                            <h2>Gestión de categorías</h2>
                            <p>Organiza el catálogo.</p>
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

                    <div class="panel-card">
                        <h3>Nueva o editar categoría</h3>
                        <form method="POST" action="${pageContext.request.contextPath}/admin/gestionCategorias">
                            <div class="form-grid-panel">
                                <c:if test="${not empty categoria}">
                                    <input type="hidden" name="id" value="${categoria.id}">
                                    <input type="hidden" name="accion" value="actualizar">
                                </c:if>
                                <c:if test="${empty categoria}">
                                    <input type="hidden" name="accion" value="crear">
                                </c:if>
                                
                                <div class="campo-form-panel">
                                    <label for="catNombre">Nombre</label>
                                    <input type="text" id="catNombre" name="nombre" placeholder="Nombre de la categoría" value="${not empty categoria ? categoria.nombre : ''}" required>
                                </div>
                                <div class="campo-form-panel campo-form-panel-full">
                                    <label for="catDesc">Descripción (opcional)</label>
                                    <textarea id="catDesc" name="descripcion" placeholder="Descripción breve">${not empty categoria ? categoria.descripcion : ''}</textarea>
                                </div>
                            </div>
                            <div class="toolbar" style="margin-top:18px;">
                                <button type="submit" class="btn-primario">Guardar categoría</button>
                                <c:if test="${not empty categoria}">
                                    <a href="${pageContext.request.contextPath}/admin/gestionCategorias" class="btn-secundario" style="text-decoration: none; display: inline-block; padding: 10px 16px;">Cancelar</a>
                                </c:if>
                            </div>
                        </form>
                    </div>

                    <div class="table-wrap">
                        <c:choose>
                            <c:when test="${empty categorias}">
                                <p style="text-align: center; padding: 20px;">No hay categorías registradas.</p>
                            </c:when>
                            <c:otherwise>
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Nombre</th>
                                            <th>Descripción</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cat" items="${categorias}">
                                            <tr>
                                                <td>${cat.nombre}</td>
                                                <td>${cat.descripcion}</td>
                                                <td class="acciones-celda">
                                                    <a href="${pageContext.request.contextPath}/admin/gestionCategorias?accion=editar&id=${cat.id}" class="btn-icono" title="Editar"><i class="fa-solid fa-pen"></i></a>
                                                    <form method="POST" action="${pageContext.request.contextPath}/admin/gestionCategorias" style="display: inline;" onsubmit="return confirm('¿Eliminar esta categoría?')">
                                                        <input type="hidden" name="accion" value="eliminar">
                                                        <input type="hidden" name="id" value="${cat.id}">
                                                        <button type="submit" class="btn-peligro" title="Eliminar"><i class="fa-solid fa-trash"></i></button>
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
