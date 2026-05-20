<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Proyecto ECommerce - Confirmación de Pedido</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/estiloCheckout.css">
        <style>
            .confirmacion-header {
                text-align: center;
                padding: 2rem 0;
                border-bottom: 2px solid #e0e0e0;
                margin-bottom: 2rem;
            }
            .confirmacion-header h2 {
                color: #137333;
                font-size: 2rem;
                margin: 0 0 0.5rem 0;
            }
            .confirmacion-header .success-badge {
                display: inline-block;
                background: #e6f4ea;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                color: #137333;
                font-weight: 600;
                margin-top: 1rem;
            }
            .numero-pedido {
                background: #f8f9fa;
                padding: 1.5rem;
                border-radius: 8px;
                text-align: center;
                margin-bottom: 2rem;
                border-left: 4px solid #137333;
            }
            .numero-pedido h3 {
                margin: 0 0 0.5rem 0;
                color: #666;
                font-size: 0.95rem;
            }
            .numero-pedido .pedido-number {
                font-size: 2rem;
                color: #137333;
                font-weight: bold;
                font-family: monospace;
            }
            .confirmacion-grid {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 2rem;
                margin-bottom: 2rem;
            }
            .confirmacion-section {
                background: white;
                padding: 1.5rem;
                border-radius: 8px;
                border: 1px solid #e0e0e0;
            }
            .confirmacion-section h3 {
                margin: 0 0 1rem 0;
                color: #2c3e50;
                border-bottom: 2px solid #f0f0f0;
                padding-bottom: 0.5rem;
            }
            .detalles-pedido table {
                width: 100%;
                border-collapse: collapse;
            }
            .detalles-pedido th {
                background: #f8f9fa;
                padding: 0.75rem;
                text-align: left;
                font-weight: 600;
                border-bottom: 2px solid #e0e0e0;
            }
            .detalles-pedido td {
                padding: 0.75rem;
                border-bottom: 1px solid #f0f0f0;
            }
            .resumen-col {
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }
            .resumen-item {
                padding: 1rem;
                background: #f8f9fa;
                border-radius: 6px;
            }
            .resumen-item strong {
                display: block;
                color: #666;
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
            }
            .resumen-item span {
                font-size: 1.1rem;
                color: #2c3e50;
                font-weight: 600;
            }
            .total-final {
                background: linear-gradient(135deg, #137333 0%, #0f5c2b 100%);
                color: white;
                padding: 1.5rem;
                border-radius: 8px;
                text-align: center;
            }
            .total-final .label {
                font-size: 0.9rem;
                opacity: 0.9;
                margin-bottom: 0.5rem;
            }
            .total-final .amount {
                font-size: 2rem;
                font-weight: bold;
            }
            .acciones-confirmacion {
                display: flex;
                gap: 1rem;
                margin-top: 2rem;
                padding-top: 2rem;
                border-top: 2px solid #e0e0e0;
            }
            .btn-confirmacion {
                flex: 1;
                padding: 1rem;
                border: none;
                border-radius: 6px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                text-decoration: none;
                text-align: center;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }
            .btn-confirmacion.primary {
                background: #137333;
                color: white;
            }
            .btn-confirmacion.primary:hover {
                background: #0f5c2b;
                transform: translateY(-2px);
            }
            .btn-confirmacion.secondary {
                background: #f0f0f0;
                color: #2c3e50;
            }
            .btn-confirmacion.secondary:hover {
                background: #e0e0e0;
            }
            .alert {
                padding: 1rem;
                border-radius: 6px;
                margin-bottom: 1.5rem;
            }
            .alert.success {
                background: #e6f4ea;
                color: #137333;
                border-left: 4px solid #137333;
            }
            .alert.warning {
                background: #feefe3;
                color: #b06000;
                border-left: 4px solid #b06000;
            }
            .alert.danger {
                background: #fce8e6;
                color: #d93025;
                border-left: 4px solid #d93025;
            }
            @media (max-width: 768px) {
                .confirmacion-grid {
                    grid-template-columns: 1fr;
                }
                .acciones-confirmacion {
                    flex-direction: column;
                }
            }
        </style>
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
                        <li><a href="${pageContext.request.contextPath}/misPedidos"><i class="fa-solid fa-clock-rotate-left"></i> Mis pedidos</a></li>
                        <li><a href="${pageContext.request.contextPath}/Perfil"><i class="fa-solid fa-user"></i> Mi perfil</a></li>
                        <li><a href="loginView.jsp"><i class="fa-solid fa-right-to-bracket"></i> Iniciar sesión</a></li>
                    </ul>
                </nav>
            </aside>

            <!-- Panel principal -->
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

                    <div class="confirmacion-header">
                        <h2><i class="fa-solid fa-circle-check"></i> ¡Pedido Confirmado!</h2>
                        <div class="success-badge">Compra procesada exitosamente</div>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert danger">
                            <i class="fa-solid fa-circle-exclamation"></i> ${error}
                        </div>
                    </c:if>

                    <c:if test="${avisoEmail != null}">
                        <div class="alert warning">
                            <i class="fa-solid fa-triangle-exclamation"></i> ${avisoEmail}
                        </div>
                    </c:if>

                    <c:if test="${emailEnviado}">
                        <div class="alert success">
                            <i class="fa-solid fa-envelope"></i> Se envió un correo de confirmación a su bandeja de entrada.
                        </div>
                    </c:if>

                    <c:if test="${numeroPedido != null}">
                        <div class="numero-pedido">
                            <h3>Tu número de pedido:</h3>
                            <div class="pedido-number">${numeroPedido}</div>
                        </div>
                    </c:if>

                    <div class="confirmacion-grid">
                        <!-- Detalles del Pedido -->
                        <div class="confirmacion-section">
                            <h3><i class="fa-solid fa-box"></i> Detalles del Pedido</h3>
                            <table class="detalles-pedido" style="color: black">
                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <th style="text-align: center;">Cantidad</th>
                                        <th style="text-align: right;">Precio</th>
                                        <th style="text-align: right;">Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="producto" items="${pedido.productos}">
                                        <tr>
                                            <td>${producto.nombreProducto}</td>
                                            <td style="text-align: center;">${producto.cantidad}</td>
                                            <td style="text-align: right;">$<fmt:formatNumber value="${producto.precioUnitario}" type="number" minFractionDigits="2"/></td>
                                            <td style="text-align: right;">$<fmt:formatNumber value="${producto.subtotal}" type="number" minFractionDigits="2"/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Resumen -->
                        <div class="resumen-col">
                            <div class="confirmacion-section">
                                <h3><i class="fa-solid fa-receipt"></i> Resumen</h3>
                                <div class="resumen-item">
                                    <strong>Fecha:</strong>
                                    <span><fmt:formatDate value="${pedido.fecha}" pattern="dd/MM/yyyy HH:mm"/></span>
                                </div>
                                <div class="resumen-item">
                                    <strong>Método de Pago:</strong>
                                    <span>${metodoPago}</span>
                                </div>
                                <div class="resumen-item">
                                    <strong>Estado:</strong>
                                    <span style="color: #137333; background: #e6f4ea; padding: 0.25rem 0.5rem; border-radius: 4px; display: inline-block;">${pedido.estado}</span>
                                </div>
                            </div>

                            <div class="confirmacion-section">
                                <h3><i class="fa-solid fa-truck"></i> Envío</h3>
                                <div class="resumen-item">
                                    <strong>Dirección:</strong>
                                    <span>${pedido.direccionEnvio}<br>${pedido.ciudad}, ${pedido.codigoPostal}</span>
                                </div>
                                <div class="resumen-item">
                                    <strong>País:</strong>
                                    <span>${pedido.pais}</span>
                                </div>
                            </div>

                            <div class="total-final">
                                <div class="label">TOTAL</div>
                                <div class="amount">$<fmt:formatNumber value="${pedido.total}" type="number" minFractionDigits="2"/></div>
                            </div>
                        </div>
                    </div>

                    <!-- Acciones -->
                    <div class="acciones-confirmacion">
                        <a href="${pageContext.request.contextPath}/misPedidos" class="btn-confirmacion primary">
                            <i class="fa-solid fa-clock-rotate-left"></i> Ver Mis Pedidos
                        </a>
                        <a href="${pageContext.request.contextPath}/catalogo" class="btn-confirmacion secondary">
                            <i class="fa-solid fa-shopping-cart"></i> Continuar Comprando
                        </a>
                    </div>

                </main>

                <!-- Footer -->
                <footer class="footer">
                    <p>Aplicaciones Web – Unidad 4</p>
                </footer>

            </div>
        </div>

    </body>
</html>
