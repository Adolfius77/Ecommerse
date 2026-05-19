<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Proyecto ECommerce - Checkout</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/estiloCheckout.css">
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
                    <div class="checkout-header">
                        <h2>Checkout: pago y envío</h2>
                        <p>Selecciona la dirección, método de envío y pago.</p>
                        <c:if test="${not empty error}">
                            <p style="color: red;">${error}</p>
                        </c:if>
                    </div>

                    <div class="checkout-grid">
                        <section class="checkout-form">
                            <form method="POST" action="${pageContext.request.contextPath}/confirmarPedido" id="formCheckout">
                                <div class="form-section">
                                    <h3>Dirección de envío</h3>
                                    <div class="form-row">
                                        <div class="campo-form">
                                            <label for="nombre">Nombre</label>
                                            <input type="text" id="nombre" name="nombre" placeholder="Nombre" required>
                                        </div>
                                        <div class="campo-form">
                                            <label for="apellido">Apellido</label>
                                            <input type="text" id="apellido" name="apellido" placeholder="Apellido" required>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="campo-form">
                                            <label for="email">Correo</label>
                                            <input type="email" id="email" name="email" placeholder="correo@ejemplo.com" required>
                                        </div>
                                        <div class="campo-form">
                                            <label for="telefono">Teléfono</label>
                                            <input type="tel" id="telefono" name="telefono" placeholder="+52 555 000 000" required>
                                        </div>
                                    </div>
                                    <div class="campo-form">
                                        <label for="direccion">Dirección</label>
                                        <input type="text" id="direccion" name="direccion" placeholder="Calle, número, colonia" required>
                                    </div>
                                    <div class="form-row">
                                        <div class="campo-form">
                                            <label for="ciudad">Ciudad</label>
                                            <input type="text" id="ciudad" name="ciudad" placeholder="Ciudad" required>
                                        </div>
                                        <div class="campo-form">
                                            <label for="cp">Código postal</label>
                                            <input type="text" id="cp" name="codigoPostal" placeholder="00000" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-section">
                                    <h3>Método de envío</h3>
                                    <label class="opcion-radio"><input type="radio" name="metodoEnvio" value="standar" checked required> Estándar (2-4 días) - $8.00</label>
                                    <label class="opcion-radio"><input type="radio" name="metodoEnvio" value="express" required> Express (24h) - $15.00</label>
                                </div>

                                <div class="form-section">
                                    <h3>Método de pago</h3>
                                    <label class="opcion-radio"><input type="radio" name="metodoPago" value="tarjeta" checked required> Tarjeta de crédito/débito</label>
                                    <div class="form-row">
                                        <div class="campo-form">
                                            <label for="tarjeta">Número de tarjeta</label>
                                            <input type="text" id="tarjeta" name="numeroTarjeta" placeholder="0000 0000 0000 0000">
                                        </div>
                                        <div class="campo-form">
                                            <label for="titular">Titular</label>
                                            <input type="text" id="titular" name="titularTarjeta" placeholder="Nombre en la tarjeta">
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="campo-form">
                                            <label for="expira">Fecha de expiración</label>
                                            <input type="text" id="expira" name="fechaExpiracion" placeholder="MM/AA">
                                        </div>
                                        <div class="campo-form">
                                            <label for="cvv">CVV</label>
                                            <input type="password" id="cvv" name="cvv" placeholder="***">
                                        </div>
                                    </div>
                                    <label class="opcion-radio"><input type="radio" name="metodoPago" value="transferencia" required> Transferencia bancaria</label>
                                    <label class="opcion-radio"><input type="radio" name="metodoPago" value="contraentrega" required> Pago contra entrega</label>
                                </div>

                                <button type="submit" class="btn-primario" style="width: 100%; padding: 12px;">Confirmar pedido</button>
                            </form>
                        </section>

                        <aside class="resumen-card">
                            <h3>Resumen del pedido</h3>
                            <c:if test="${not empty carrito}">
                                <c:forEach var="item" items="${carrito}">
                                    <div style="padding: 8px 0; border-bottom: 1px solid #ddd;">
                                        <div>${item.nombre}</div>
                                        <div style="font-size: 0.9em; color: #666;">Cant: ${item.cantidad} x $${item.precioUnitario}</div>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <div class="resumen-linea">
                                <span>Subtotal</span>
                                <span>$${subtotal}</span>
                            </div>
                            <div class="resumen-linea">
                                <span>Envío</span>
                                <span>$<span id="costoEnvio">8.00</span></span>
                            </div>
                            <div class="resumen-linea total">
                                <span>Total</span>
                                <span>$<span id="totalPrecio">${subtotal + 8}</span></span>
                            </div>
                            <p class="nota-resumen">Al confirmar aceptas los términos y condiciones.</p>
                        </aside>
                    </div>
                </main>

                <!-- Pie de pagina -->
                <footer class="footer">
                    <p>Aplicaciones Web – Unidad 4</p>
                </footer>

            </div>
        </div>

        <script>
            function actualizarCamposTarjeta() {
                const esTarjeta = document.querySelector('input[name="metodoPago"]:checked')?.value === 'tarjeta';
                ['tarjeta', 'titular', 'expira', 'cvv'].forEach(id => {
                    const el = document.getElementById(id);
                    if (el) el.required = esTarjeta;
                });
            }
            document.querySelectorAll('input[name="metodoPago"]').forEach(radio => {
                radio.addEventListener('change', actualizarCamposTarjeta);
            });
            actualizarCamposTarjeta();

            document.querySelectorAll('input[name="metodoEnvio"]').forEach(radio => {
                radio.addEventListener('change', function () {
                    let costo = this.value === 'express' ? 15 : 8;
                    document.getElementById('costoEnvio').textContent = costo.toFixed(2);
                    let subtotal = parseFloat('${subtotal}');
                    document.getElementById('totalPrecio').textContent = (subtotal + costo).toFixed(2);
                });
            });
        </script>

    </body>
</html>
