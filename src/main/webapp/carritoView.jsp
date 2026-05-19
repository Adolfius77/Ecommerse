<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proyecto ECommerce - Carrito</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="./styles/estiloCarrito.css">
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
                <div class="carrito-header">
                    <h2>Carrito de compras</h2>
                    <p>Revisa tus artículos, ajusta cantidades o elimina productos.</p>
                    <c:if test="${not empty mensaje}">
                        <p style="color: green;">${mensaje}</p>
                    </c:if>
                    <c:if test="${not empty error}">
                        <p style="color: red;">${error}</p>
                    </c:if>
                </div>

                <c:if test="${empty carrito}">
                    <div class="carrito-vacio" style="text-align: center; padding: 45px;">
                        <p style="margin-bottom: 30px; font-size: 18px;">Tu carrito está vacío</p>
                        <a class="btn-primario" href="${pageContext.request.contextPath}/catalogo">Ir al catálogo</a>
                    </div>
                </c:if>

                <c:if test="${not empty carrito}">
                <div class="carrito-grid">
                    <section class="carrito-lista">
                        <c:forEach var="item" items="${carrito}">
                        <article class="carrito-item">
                            <div class="item-img" style="display: flex; justify-content: center; align-items: center; height: 100px; background: #f8f9fa;">
                                <img src="${item.imagenProducto}" alt="${item.nombre}" style="max-height: 100%; max-width: 100%; object-fit: contain;" onerror="this.src='styles/img/placeholder.png'">
                            </div>
                            <div class="item-info">
                                <h4>${item.nombre}</h4>
                                <span class="item-precio">$${item.precioUnitario}</span>
                            </div>
                            <div class="item-controles">
                                <form method="POST" action="${pageContext.request.contextPath}/carrito" style="display: flex; align-items: center; gap: 10px;">
                                    <input type="hidden" name="accion" value="actualizar">
                                    <input type="hidden" name="productoId" value="${item.productoId}">
                                    <button type="submit" name="cantidad" value="${item.cantidad - 1}" class="btn-cantidad" ${item.cantidad <= 1 ? 'disabled' : ''}>-</button>
                                    <span>${item.cantidad}</span>
                                    <button type="submit" name="cantidad" value="${item.cantidad + 1}" class="btn-cantidad">+</button>
                                </form>
                                <form method="POST" action="${pageContext.request.contextPath}/carrito" style="display: inline;">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="productoId" value="${item.productoId}">
                                    <button type="submit" class="btn-eliminar"><i class="fa-solid fa-trash"></i></button>
                                </form>
                            </div>
                        </article>
                        </c:forEach>
                    </section>

                    <aside class="resumen-card">
                        <h3>Resumen</h3>
                        <div class="resumen-linea">
                            <span>Subtotal</span>
                            <span>$${subtotal}</span>
                        </div>
                        <div class="resumen-linea">
                            <span>Envío</span>
                            <span>$12.00</span>
                        </div>
                        <div class="resumen-linea total">
                            <span>Total</span>
                            <span>$${total}</span>
                        </div>
                        <a class="btn-primario" href="${pageContext.request.contextPath}/checkout" style="display: block; text-align: center; padding: 10px;">Ir a checkout</a>
                        <a class="btn-secundario" href="${pageContext.request.contextPath}/catalogo">Seguir comprando</a>
                    </aside>
                </div>
                </c:if>
            </main>

            <!-- Pie de pagina -->
            <footer class="footer">
                <p>Aplicaciones Web – Unidad 4</p>
            </footer>

        </div>
    </div>

</body>
</html>
