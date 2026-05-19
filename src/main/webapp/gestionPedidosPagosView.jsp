<%-- Gestión de pedidos y pagos (vista administrador) --%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administración - Pedidos y pagos</title>
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
                        <li><a href="${pageContext.request.contextPath}/admin/gestionUsuarios"><i class="fa-solid fa-users"></i> Usuarios</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/gestionPedidos" class="active"><i class="fa-solid fa-receipt"></i> Pedidos y pagos</a></li>
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
                            <h2>Pedidos y pagos</h2>
                            <p>Consulta las compras de los clientes y actualiza el estado del pedido y del pago.</p>
                        </div>
                    </div>

                    <c:if test="${not empty mensaje}">
                        <p style="color: #2d5248; margin-bottom: 1rem;">${mensaje}</p>
                    </c:if>
                    <c:if test="${not empty error}">
                        <p style="color: #8b3a3a; margin-bottom: 1rem;">${error}</p>
                    </c:if>

                    <div class="table-wrap">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Pedido</th>
                                    <th>Cliente</th>
                                    <th>Fecha</th>
                                    <th>Total</th>
                                    <th>Estado pedido</th>
                                    <th>Pago</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${pedidos}">
                                    <c:set var="pid" value="${p.id}"/>
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${numerosPedido[pid] != null}">${numerosPedido[pid]}</c:when>
                                                <c:otherwise>#${p.id}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${p.nombreCliente}</td>
                                        <td><fmt:formatDate value="${p.fecha}" pattern="yyyy-MM-dd"/></td>
                                        <td>$<fmt:formatNumber value="${p.total}" type="number" minFractionDigits="2"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.estado == 'PENDIENTE'}"><span class="badge-estado badge-pendiente">Pendiente</span></c:when>
                                                <c:when test="${p.estado == 'ENVIADO'}"><span class="badge-estado badge-enviado">Enviado</span></c:when>
                                                <c:when test="${p.estado == 'ENTREGADO'}"><span class="badge-estado badge-entregado">Entregado</span></c:when>
                                                <c:otherwise><span class="badge-estado">${p.estado}</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.estadoPago == 'PAGADO'}"><span class="badge-estado badge-pago">Pagado</span></c:when>
                                                <c:when test="${p.estadoPago == 'POR_CONFIRMAR'}"><span class="badge-estado badge-pendiente">Por confirmar</span></c:when>
                                                <c:when test="${p.estadoPago == 'RECHAZADO'}"><span class="badge-estado badge-inactivo">Rechazado</span></c:when>
                                                <c:otherwise><span class="badge-estado badge-pendiente">${p.estadoPago}</span></c:otherwise>
                                            </c:choose>
                                            <c:if test="${not empty p.metodoPago}">
                                                <br><small style="color:#5c6570;">${p.metodoPago}</small>
                                            </c:if>
                                        </td>
                                        <td class="acciones-celda" style="min-width: 220px;">
                                            <form method="POST" action="${pageContext.request.contextPath}/admin/gestionPedidos" style="margin-bottom: 8px;">
                                                <input type="hidden" name="accion" value="cambiarEstado">
                                                <input type="hidden" name="pedidoId" value="${p.id}">
                                                <label class="sr-only" for="estado-${pid}">Estado del pedido</label>
                                                <select id="estado-${pid}" name="nuevoEstado" class="estado-select" aria-label="Cambiar estado del pedido" onchange="this.form.submit()">
                                                    <option value="PENDIENTE" <c:if test="${p.estado == 'PENDIENTE'}">selected</c:if>>Pendiente</option>
                                                    <option value="ENVIADO" <c:if test="${p.estado == 'ENVIADO'}">selected</c:if>>Enviado</option>
                                                    <option value="ENTREGADO" <c:if test="${p.estado == 'ENTREGADO'}">selected</c:if>>Entregado</option>
                                                </select>
                                            </form>
                                            <form method="POST" action="${pageContext.request.contextPath}/admin/gestionPedidos">
                                                <input type="hidden" name="accion" value="cambiarEstadoPago">
                                                <input type="hidden" name="pedidoId" value="${p.id}">
                                                <label class="sr-only" for="pago-${pid}">Estado de pago</label>
                                                <select id="pago-${pid}" name="nuevoEstadoPago" class="estado-select" aria-label="Cambiar estado de pago" onchange="this.form.submit()">
                                                    <option value="PENDIENTE" <c:if test="${p.estadoPago == 'PENDIENTE'}">selected</c:if>>Pendiente</option>
                                                    <option value="POR_CONFIRMAR" <c:if test="${p.estadoPago == 'POR_CONFIRMAR'}">selected</c:if>>Por confirmar</option>
                                                    <option value="PAGADO" <c:if test="${p.estadoPago == 'PAGADO'}">selected</c:if>>Pagado</option>
                                                    <option value="RECHAZADO" <c:if test="${p.estadoPago == 'RECHAZADO'}">selected</c:if>>Rechazado</option>
                                                </select>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty pedidos}">
                                    <tr>
                                        <td colspan="7">No hay pedidos registrados.</td>
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
