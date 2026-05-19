<%-- Gestión de pedidos y pagos (vista administrador) --%>
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
                            <h2>Pedidos y pagos</h2>
                            <p>Consulta las compras de los clientes y actualiza el estado del pedido </p>
                        </div>
                    </div>

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
                                <tr>
                                    <td>#PED-1001</td>
                                    <td>María López</td>
                                    <td>2026-05-10</td>
                                    <td>$238.00</td>
                                    <td><span class="badge-estado badge-pendiente">Pendiente</span></td>
                                    <td><span class="badge-estado badge-pago">Por confirmar</span></td>
                                    <td>
                                        <select class="estado-select" aria-label="Cambiar estado del pedido">
                                            <option value="PENDIENTE" selected>Pendiente</option>
                                            <option value="ENVIADO">Enviado</option>
                                            <option value="ENTREGADO">Entregado</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>#PED-1002</td>
                                    <td>Juan Pérez</td>
                                    <td>2026-05-09</td>
                                    <td>$89.00</td>
                                    <td><span class="badge-estado badge-enviado">Enviado</span></td>
                                    <td><span class="badge-estado badge-pago">Pagado</span></td>
                                    <td>
                                        <select class="estado-select" aria-label="Cambiar estado del pedido">
                                            <option value="PENDIENTE">Pendiente</option>
                                            <option value="ENVIADO" selected>Enviado</option>
                                            <option value="ENTREGADO">Entregado</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>#PED-1003</td>
                                    <td>Ana Ruiz</td>
                                    <td>2026-05-08</td>
                                    <td>$312.50</td>
                                    <td><span class="badge-estado badge-entregado">Entregado</span></td>
                                    <td><span class="badge-estado badge-pago">Pagado</span></td>
                                    <td>
                                        <select class="estado-select" aria-label="Cambiar estado del pedido">
                                            <option value="PENDIENTE">Pendiente</option>
                                            <option value="ENVIADO">Enviado</option>
                                            <option value="ENTREGADO" selected>Entregado</option>
                                        </select>
                                    </td>
                                </tr>
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
