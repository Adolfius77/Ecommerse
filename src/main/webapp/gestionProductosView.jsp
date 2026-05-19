<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administración - Inventario de productos</title>
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
                            <h2>Inventario de productos</h2>
                            <p>Crear, editar y eliminar productos.</p>
                            <c:if test="${not empty mensaje}">
                                <p style="color: green;">${mensaje}</p>
                            </c:if>
                            <c:if test="${not empty error}">
                                <p style="color: red;">${error}</p>
                            </c:if>
                        </div>
                    </div>

                    <div class="panel-card">
                        <h3>Alta o edición de producto</h3>
                        <p style="color:#5f6368;font-size:14px;margin-bottom:16px;">Campos alineados con el modelo Producto</p>
                        <form method="POST" action="${pageContext.request.contextPath}/admin/gestionProductos">
                            <div class="form-grid-panel">
                                <c:if test="${not empty producto}">
                                    <input type="hidden" name="id" value="${producto.id}">
                                </c:if>
                                <c:if test="${empty producto}">
                                    <input type="hidden" name="id" value="">
                                </c:if>
                                <input type="hidden" name="accion" value="guardar">
                                <div class="campo-form-panel">
                                    <label for="prodNombre">Nombre</label>
                                    <input type="text" id="prodNombre" name="nombre" placeholder="Nombre del producto" value="${not empty producto ? producto.nombre : ''}" required>
                                </div>
                                <div class="campo-form-panel">
                                    <label for="prodPrecio">Precio</label>
                                    <input type="number" id="prodPrecio" name="precio" step="0.01" placeholder="0.00" value="${not empty producto ? producto.precio : ''}" required>
                                </div>
                                <div class="campo-form-panel">
                                    <label for="prodStock">Stock</label>
                                    <input type="number" id="prodStock" name="stock" min="0" placeholder="0" value="${not empty producto ? producto.stock : ''}" required>
                                </div>
                                <div class="campo-form-panel">
                                    <label for="prodCategoria">Categoría</label>
                                    <input type="text" id="prodCategoria" name="categoria" placeholder="Ej. Tecnología" value="${not empty producto ? producto.categoria : ''}" required>
                                </div>
                                <div class="campo-form-panel campo-form-panel-full">
                                    <label for="prodImagen">URL de imagen</label>
                                    <input type="url" id="prodImagen" name="imagenProducto" placeholder="https://..." value="${not empty producto ? producto.imagenProducto : ''}">
                                </div>
                                <div class="campo-form-panel campo-form-panel-full">
                                    <label for="prodDesc">Descripción</label>
                                    <textarea id="prodDesc" name="descripcion" placeholder="Descripción del producto">${not empty producto ? producto.descripcion : ''}</textarea>
                                </div>
                            </div>
                            <div class="toolbar" style="margin-top:18px;">
                                <button type="submit" class="btn-primario">Guardar</button>
                                <button type="reset" class="btn-secundario">Limpiar formulario</button>
                            </div>
                        </form>
                    </div>

                    <div class="table-wrap">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Imagen</th>
                                    <th>Nombre</th>
                                    <th>Categoría</th>
                                    <th>Precio</th>
                                    <th>Stock</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty productos}">
                                    <tr>
                                        <td colspan="6" style="text-align: center; padding: 20px;">No hay productos</td>
                                    </tr>
                                </c:if>
                                <c:forEach var="producto" items="${productos}">
                                    <tr>
                                        <td><div class="thumb-placeholder"><img src="${producto.imagenProducto}" alt="${producto.nombre}" style="max-height: 40px; max-width: 40px; object-fit: contain;" onerror="this.src='styles/img/placeholder.png'"></div></td>
                                        <td>${producto.nombre}</td>
                                        <td>${producto.categoria}</td>
                                        <td>$${producto.precio}</td>
                                        <td>${producto.stock}</td>
                                        <td class="acciones-celda">
                                            <a href="${pageContext.request.contextPath}/admin/gestionProductos?accion=editar&id=${producto.id}" class="btn-icono" title="Editar"><i class="fa-solid fa-pen"></i></a>
                                            <form method="POST" action="${pageContext.request.contextPath}/admin/gestionProductos" style="display: inline;" onsubmit="return confirm('¿Eliminar este producto?')">
                                                <input type="hidden" name="accion" value="eliminar">
                                                <input type="hidden" name="id" value="${producto.id}">
                                                <button type="submit" class="btn-peligro" title="Eliminar"><i class="fa-solid fa-trash"></i></button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
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
