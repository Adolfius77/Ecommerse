<%-- 
    Document   : catalogoView.jsp
    Catálogo de productos con filtros y búsqueda
--%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Proyecto ECommerce - Catálogo</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/estiloCatalogo.css">
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
                    <div class="catalogo-header">
                        <div>
                            <h2>Catálogo de productos</h2>
                            <p>Encuentra productos usando filtros y barra de búsqueda.</p>
                            <c:if test="${not empty error}">
                                <p style="color: red;">${error}</p>
                            </c:if>
                        </div>
                        <form method="GET" action="${pageContext.request.contextPath}/catalogo" class="search-bar">
                            <input type="text" name="nombre" placeholder="Buscar productos, marcas o categorías" value="${nombreBusqueda}">
                            <button type="submit" class="btn-primario"><i class="fa-solid fa-magnifying-glass"></i> Buscar</button>
                        </form>
                    </div>

                    <div class="catalogo-grid">
                        <aside class="filtros">
                            <h3>Filtros</h3>
                            <form method="GET" action="${pageContext.request.contextPath}/catalogo" id="filtrosForm">
                                <!-- Campo oculto para preservar la búsqueda por nombre -->
                                <input type="hidden" name="nombre" value="${nombreBusqueda}">
                                
                                <div class="filtro-grupo">
                                    <label>Categorías</label>
                                    <div class="filtro-opciones">
                                        <label><input type="radio" name="categoria" value="" ${empty categoriaBusqueda ? 'checked' : ''}> Todas</label>
                                        <label><input type="radio" name="categoria" value="Tecnología" ${categoriaBusqueda == 'Tecnología' ? 'checked' : ''}> Tecnología</label>
                                        <label><input type="radio" name="categoria" value="Hogar" ${categoriaBusqueda == 'Hogar' ? 'checked' : ''}> Hogar</label>
                                        <label><input type="radio" name="categoria" value="Accesorios" ${categoriaBusqueda == 'Accesorios' ? 'checked' : ''}> Accesorios</label>
                                        <label><input type="radio" name="categoria" value="Moda" ${categoriaBusqueda == 'Moda' ? 'checked' : ''}> Moda</label>
                                    </div>
                                </div>
                                
                                <div class="filtro-grupo">
                                    <label>Rango de precio</label>
                                    <div class="filtro-opciones">
                                        <label><input type="radio" name="rango" value="" ${empty param.rango ? 'checked' : ''}> Todos los precios</label>
                                        <label><input type="radio" name="rango" value="0-50" ${param.rango == '0-50' ? 'checked' : ''}> $0 - $50</label>
                                        <label><input type="radio" name="rango" value="51-150" ${param.rango == '51-150' ? 'checked' : ''}> $51 - $150</label>
                                        <label><input type="radio" name="rango" value="151-300" ${param.rango == '151-300' ? 'checked' : ''}> $151 - $300</label>
                                        <label><input type="radio" name="rango" value="300-99999" ${param.rango == '300-99999' ? 'checked' : ''}> $300+</label>
                                    </div>
                                </div>
                                
                                <input type="hidden" name="precioMin" id="precioMin">
                                <input type="hidden" name="precioMax" id="precioMax">
                                
                                <button type="submit" class="btn-primario" style="width: 100%; margin-bottom: 10px;">Aplicar filtros</button>
                            </form>
                            
                            <c:if test="${filtroAplicado}">
                                <a href="${pageContext.request.contextPath}/catalogo" class="btn-secundario" style="display: block; text-align: center;">Limpiar filtros</a>
                            </c:if>
                        </aside>

                        <section class="productos-grid">
                            <c:if test="${empty productos}">
                                <div style="grid-column: 1 / -1; text-align: center; padding: 20px;">
                                    <p>No hay productos disponibles en este momento.</p>
                                </div>
                            </c:if>

                            <c:forEach var="producto" items="${productos}">
                                <article class="producto-card">
                                    <div class="producto-img" style="display: flex; justify-content: center; align-items: center; height: 150px; overflow: hidden; background: #f8f9fa;">
                                        <img src="${producto.imagenProducto}" alt="${producto.nombre}" style="max-height: 100%; max-width: 100%; object-fit: contain;" onerror="this.src='styles/img/placeholder.png'">
                                    </div>

                                    <h4 style="margin: 10px 0 5px 0; font-size: 1.1em;">${producto.nombre}</h4>
                                    <p class="producto-marca" style="color: #666; font-size: 0.9em; margin: 0;">${producto.categoria}</p>
                                    <p class="producto-precio" style="font-weight: bold; font-size: 1.2em; color: #2c3e50; margin: 10px 0;">$${producto.precio}</p>

                                    <div style="font-size: 12px; margin-bottom: 15px;">
                                        <c:choose>
                                            <c:when test="${producto.stock > 10}">
                                                <span style="color: #137333; background: #e6f4ea; padding: 2px 6px; border-radius: 4px;">En stock</span>
                                            </c:when>
                                            <c:when test="${producto.stock > 0 && producto.stock <= 10}">
                                                <span style="color: #b06000; background: #feefe3; padding: 2px 6px; border-radius: 4px;">Últimos ${producto.stock}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #d93025; background: #fce8e6; padding: 2px 6px; border-radius: 4px;">Agotado</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="producto-acciones">
                                        <a class="btn-secundario" href="${pageContext.request.contextPath}/DetalleProducto?id=${producto.id}">Ver detalle</a>
                                        <form method="GET" action="${pageContext.request.contextPath}/carrito" style="display: inline;">
                                            <input type="hidden" name="accion" value="agregar">
                                            <input type="hidden" name="productoId" value="${producto.id}">
                                            <input type="hidden" name="cantidad" value="1">
                                            <button type="submit" class="btn-primario" ${producto.stock == 0 ? 'disabled' : ''}>Agregar</button>
                                        </form>
                                    </div>
                                </article>
                            </c:forEach>
                        </section>
                    </div>
                </main>

                <footer class="footer">
                    <p>Aplicaciones Web – Unidad 4</p>
                </footer>

            </div>
        </div>

    </body>
    
    <script>
        
        document.querySelectorAll('input[name="rango"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const rango = this.value;
                const precioMinInput = document.getElementById('precioMin');
                const precioMaxInput = document.getElementById('precioMax');
                
                if (rango === '0-50') {
                    precioMinInput.value = '0';
                    precioMaxInput.value = '50';
                } else if (rango === '51-150') {
                    precioMinInput.value = '51';
                    precioMaxInput.value = '150';
                } else if (rango === '151-300') {
                    precioMinInput.value = '151';
                    precioMaxInput.value = '300';
                } else if (rango === '300-99999') {
                    precioMinInput.value = '300';
                    precioMaxInput.value = '99999';
                } else {
                    precioMinInput.value = '';
                    precioMaxInput.value = '';
                }
            });
        });
        
        
        const rangoSeleccionado = document.querySelector('input[name="rango"]:checked');
        if (rangoSeleccionado && rangoSeleccionado.value !== '') {
            rangoSeleccionado.dispatchEvent(new Event('change'));
        }
    </script>
</html>