<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Proyecto ECommerce - ${producto.nombre}</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/estiloDetalleProducto.css">
    </head>
    <body>

        <div class="layout-container">
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

            <div class="main-panel">
                <header class="topbar">
                    <div class="topbar-links">
                        <a href="${pageContext.request.contextPath}/Perfil"><i class="fas fa-user"></i> Perfil</a>
                        <a href="${pageContext.request.contextPath}/Logout"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</a>
                    </div>
                </header>

                <main class="content">
                    <c:if test="${not empty mensaje}">
                        <p style="color: green; margin-bottom: 1rem;">${mensaje}</p>
                    </c:if>
                    <c:if test="${not empty error}">
                        <p style="color: red; margin-bottom: 1rem;">${error}</p>
                    </c:if>

                    <div class="detalle-header">
                        <a class="link-volver" href="${pageContext.request.contextPath}/catalogo"><i class="fa-solid fa-arrow-left"></i> Volver al catálogo</a>
                    </div>

                    <div class="detalle-producto">
                        <div class="detalle-galeria">
                            <c:choose>
                                <c:when test="${not empty producto.imagenProducto}">
                                    <div class="galeria-principal">
                                        <img src="${producto.imagenProducto}" alt="${producto.nombre}" style="max-width:100%; max-height:100%; object-fit:contain;">
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="galeria-principal">Sin imagen</div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="detalle-info">
                            <h2>${producto.nombre}</h2>
                            <p class="detalle-categoria">${producto.categoria}</p>
                            <div class="detalle-rating">
                                <span class="estrellas">
                                    <fmt:formatNumber value="${promedioCalificacion}" maxFractionDigits="1" minFractionDigits="1"/>
                                </span>
                                <span class="rating-text">
                                    <c:choose>
                                        <c:when test="${totalResenas > 0}">
                                            ${promedioCalificacion} (${totalResenas} reseñas)
                                        </c:when>
                                        <c:otherwise>Sin reseñas aún</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <p class="detalle-precio">$<fmt:formatNumber value="${producto.precio}" type="number" minFractionDigits="2"/></p>
                            <p class="detalle-descripcion">${producto.descripcion}</p>
                            <p><strong>Stock disponible:</strong> ${producto.stock}</p>

                            <c:if test="${producto.stock > 0}">
                                <form method="GET" action="${pageContext.request.contextPath}/carrito" class="detalle-acciones" style="display:flex; flex-wrap:wrap; gap:12px; align-items:center;">
                                    <input type="hidden" name="accion" value="agregar">
                                    <input type="hidden" name="productoId" value="${producto.id}">
                                    <div class="selector-cantidad">
                                        <label for="cantidad">Cantidad:</label>
                                        <input type="number" id="cantidad" name="cantidad" value="1" min="1" max="${producto.stock}" required style="width:60px;">
                                    </div>
                                    <button type="submit" class="btn-primario"><i class="fa-solid fa-cart-plus"></i> Agregar al carrito</button>
                                </form>
                            </c:if>
                            <c:if test="${producto.stock <= 0}">
                                <p style="color:#c00;">Producto agotado</p>
                            </c:if>

                            <div class="detalle-extra">
                                <span><i class="fa-solid fa-truck"></i> Envío 24-48h</span>
                                <span><i class="fa-solid fa-shield"></i> Garantía 1 año</span>
                            </div>
                        </div>
                    </div>

                    <section class="seccion-resenas" style="margin-top:2rem;">
                        <h3>Reseñas</h3>
                        <c:if test="${empty resenas}">
                            <p>No hay reseñas aprobadas para este producto.</p>
                        </c:if>
                        <c:forEach var="r" items="${resenas}">
                            <article style="border-bottom:1px solid #ddd; padding:12px 0;">
                                <strong>${r.nombreUsuario}</strong>
                                — ${r.calificacion}/5
                                <fmt:formatDate value="${r.fecha}" pattern="dd/MM/yyyy"/>
                                <p>${r.comentario}</p>
                            </article>
                        </c:forEach>

                        <c:if test="${not empty usuarioLogueado}">
                            <h4 style="margin-top:1.5rem;">Escribir una reseña</h4>
                            <form method="POST" action="${pageContext.request.contextPath}/resena">
                                <input type="hidden" name="productoId" value="${producto.id}">
                                <div class="campo-form" style="margin-bottom:8px;">
                                    <label for="calificacion">Calificación (1-5)</label>
                                    <select id="calificacion" name="calificacion" required>
                                        <option value="5">5 - Excelente</option>
                                        <option value="4">4 - Muy bueno</option>
                                        <option value="3">3 - Bueno</option>
                                        <option value="2">2 - Regular</option>
                                        <option value="1">1 - Malo</option>
                                    </select>
                                </div>
                                <div class="campo-form" style="margin-bottom:8px;">
                                    <label for="comentario">Comentario</label>
                                    <textarea id="comentario" name="comentario" rows="3" required minlength="5" maxlength="500" placeholder="Comparte tu experiencia con el producto"></textarea>
                                </div>
                                <button type="submit" class="btn-primario">Enviar reseña</button>
                            </form>
                        </c:if>
                        <c:if test="${empty usuarioLogueado}">
                            <p style="margin-top:1rem;"><a href="loginView.jsp?redirigir=DetalleProducto&amp;id=${producto.id}">Inicia sesión</a> para dejar una reseña.</p>
                        </c:if>
                    </section>
                </main>

                <footer class="footer">
                    <p>Aplicaciones Web – Unidad 4</p>
                </footer>
            </div>
        </div>

    </body>
</html>
