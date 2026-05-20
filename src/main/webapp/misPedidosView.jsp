<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html lang="es">

    <head>

        <meta charset="UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Proyecto ECommerce - Mis Pedidos</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/estiloCarrito.css">

        <style>

            .pedidos-header h2 {

                color: #333;

                margin-bottom: 10px;

            }

            .pedidos-lista {

                display: grid;

                gap: 20px;

            }

            .pedido-card {

                border: 1px solid #ddd;

                border-radius: 8px;

                padding: 20px;

                background: white;

                box-shadow: 0 2px 4px rgba(0,0,0,0.1);

            }

            .pedido-header {

                display: flex;

                justify-content: space-between;

                margin-bottom: 15px;

                padding-bottom: 15px;

                border-bottom: 1px solid #eee;

            }

            .pedido-header h4 {

                margin: 0 0 5px 0;

                color: #667eea;

            }

            .pedido-fecha {

                margin: 0;

                color: #666;

                font-size: 0.9em;

            }

            .pedido-estado {

                text-align: right;

            }

            .estado {

                display: inline-block;

                padding: 6px 12px;

                border-radius: 20px;

                font-size: 0.85em;

                font-weight: bold;

                margin-bottom: 10px;

            }

            .estado.PENDIENTE {

                background: #fff3cd;

                color: #856404;

            }

            .estado.ENVIADO {

                background: #cfe2ff;

                color: #084298;

            }

            .estado.ENTREGADO {

                background: #d1e7dd;

                color: #0f5132;

            }

            .pedido-total {

                margin: 0;

                font-size: 1.1em;

                font-weight: bold;

                color: #333;

            }

            .pedido-items {

                margin: 15px 0;

                padding: 15px 0;

            }

            .item-resumen {

                display: flex;

                justify-content: space-between;

                padding: 8px 0;

                border-bottom: 1px solid #f0f0f0;

            }

            .pedido-acciones {

                display: flex;

                gap: 10px;

                margin-top: 15px;

                flex-wrap: wrap;

            }

            .btn-secundario {

                display: inline-block;

                padding: 8px 16px;

                background: #6c757d;

                color: white;

                border: none;

                border-radius: 4px;

                cursor: pointer;

                font-size: 0.9em;

                text-decoration: none;

            }

            .btn-secundario:hover {

                background: #5a6268;

                color: white;

            }

            .btn-secundario:disabled {

                opacity: 0.6;

                cursor: not-allowed;

            }

            .detalle-meta {

                display: grid;

                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));

                gap: 12px;

                margin: 16px 0;

            }

            .detalle-meta p {

                margin: 0;

                color: #444;

            }

            .detalle-tabla {

                width: 100%;

                border-collapse: collapse;

                margin-top: 12px;

            }

            .detalle-tabla th,

            .detalle-tabla td {

                padding: 10px;

                border-bottom: 1px solid #eee;

                text-align: left;

                color: #000;

            }

            .detalle-tabla th {

                background: #f8f9fa;

                color: #000;

            }

            .volver-link {

                display: inline-block;

                margin-bottom: 16px;

                color: #667eea;

                text-decoration: none;

            }

            .volver-link:hover {

                text-decoration: underline;

            }

        </style>

    </head>

    <body>



        <div class="layout-container">

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



            <div class="main-panel">



                <header class="topbar">

                    <div class="topbar-links">

                        <a href="${pageContext.request.contextPath}/Perfil"><i class="fas fa-user"></i> Perfil</a>

                        <a href="${pageContext.request.contextPath}/Logout"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</a>

                    </div>

                </header>



                <main class="content">

                    <c:choose>

                        <c:when test="${not empty pedidoDetalle}">

                            <a class="volver-link" href="${pageContext.request.contextPath}/misPedidos">

                                <i class="fa-solid fa-arrow-left"></i> Volver a mis pedidos

                            </a>

                            <div class="pedidos-header">

                                <h2>Detalle del pedido</h2>

                                <p>Número: <strong>${numeroPedido}</strong></p>

                            </div>



                            <article class="pedido-card">

                                <div class="pedido-header">

                                    <div>

                                        <h4>${numeroPedido}</h4>

                                        <p class="pedido-fecha">Fecha: <fmt:formatDate value="${pedidoDetalle.fecha}" pattern="dd/MM/yyyy HH:mm" /></p>

                                    </div>

                                    <div class="pedido-estado">

                                        <span class="estado ${pedidoDetalle.estado}">${pedidoDetalle.estado}</span>

                                        <p class="pedido-total">Total: $<fmt:formatNumber value="${pedidoDetalle.total}" type="number" minFractionDigits="2"/></p>

                                    </div>

                                </div>



                                <div class="detalle-meta">

                                    <p><strong>Estado de pago:</strong> ${pedidoDetalle.estadoPago}</p>

                                    <c:if test="${not empty pedidoDetalle.metodoPago}">

                                        <p><strong>Método de pago:</strong> ${pedidoDetalle.metodoPago}</p>

                                    </c:if>

                                    <c:if test="${not empty pedidoDetalle.direccionEnvio}">

                                        <p><strong>Envío:</strong> ${pedidoDetalle.direccionEnvio}</p>

                                    </c:if>

                                </div>



                                <h4 style="margin-top: 20px;">Productos</h4>

                                <table class="detalle-tabla">

                                    <thead>

                                        <tr>

                                            <th>Producto</th>

                                            <th>Cantidad</th>

                                            <th>Precio unit.</th>

                                            <th>Subtotal</th>

                                        </tr>

                                    </thead>

                                    <tbody>

                                        <c:forEach var="producto" items="${pedidoDetalle.productos}">

                                            <tr>

                                                <td>${producto.nombreProducto}</td>

                                                <td>${producto.cantidad}</td>

                                                <td>$<fmt:formatNumber value="${producto.precioUnitario}" type="number" minFractionDigits="2"/></td>

                                                <td>$<fmt:formatNumber value="${producto.subtotal}" type="number" minFractionDigits="2"/></td>

                                            </tr>

                                        </c:forEach>

                                        <c:if test="${empty pedidoDetalle.productos}">

                                            <tr>

                                                <td colspan="4">Sin líneas de producto registradas.</td>

                                            </tr>

                                        </c:if>

                                    </tbody>

                                </table>

                            </article>

                        </c:when>

                        <c:otherwise>

                            <div class="pedidos-header">

                                <h2>Mis Pedidos</h2>

                                <p>Historial y estado de tus pedidos.</p>

                                <c:if test="${not empty error}">

                                    <p style="color: red;">${error}</p>

                                </c:if>

                            </div>



                            <c:if test="${empty pedidos}">

                                <div style="text-align: center; padding: 40px;">

                                    <p style="margin-bottom: 30px; font-size: 18px">No tienes pedidos aún</p>

                                    <a class="btn-primario" href="${pageContext.request.contextPath}/catalogo">Ir al catálogo</a>

                                </div>

                            </c:if>



                            <c:if test="${not empty pedidos}">

                                <div class="pedidos-lista">

                                    <c:forEach var="pedido" items="${pedidos}">

                                        <c:set var="pid" value="${pedido.id}"/>

                                        <article class="pedido-card">

                                            <div class="pedido-header">

                                                <div>

                                                    <h4>

                                                        Pedido

                                                        <c:choose>

                                                            <c:when test="${numerosPedido[pid] != null}">${numerosPedido[pid]}</c:when>

                                                            <c:when test="${not empty pedido.numeroPedido}">${pedido.numeroPedido}</c:when>

                                                            <c:otherwise>#${pedido.id}</c:otherwise>

                                                        </c:choose>

                                                    </h4>

                                                    <p class="pedido-fecha">Fecha: <fmt:formatDate value="${pedido.fecha}" pattern="dd/MM/yyyy HH:mm" /></p>

                                                </div>

                                                <div class="pedido-estado">

                                                    <span class="estado ${pedido.estado}">${pedido.estado}</span>

                                                    <p class="pedido-total">Total: $<fmt:formatNumber value="${pedido.total}" type="number" minFractionDigits="2"/></p>

                                                </div>

                                            </div>



                                            <div class="pedido-items">

                                                <c:forEach var="producto" items="${pedido.productos}">

                                                    <div class="item-resumen">

                                                        <span>${producto.nombreProducto} x ${producto.cantidad}</span>

                                                        <span>$<fmt:formatNumber value="${producto.subtotal}" type="number" minFractionDigits="2"/></span>

                                                    </div>

                                                </c:forEach>

                                            </div>



                                            <div class="pedido-acciones">

                                                <a class="btn-secundario" href="${pageContext.request.contextPath}/misPedidos?pedidoId=${pedido.id}">Ver detalles</a>

                                                <button type="button" class="btn-secundario" disabled title="Próximamente">Descargar recibo</button>

                                            </div>

                                        </article>

                                    </c:forEach>

                                </div>

                            </c:if>

                        </c:otherwise>

                    </c:choose>

                </main>



                <footer class="footer">

                    <p>Aplicaciones Web – Unidad 4</p>

                </footer>



            </div>

        </div>



    </body>

</html>

