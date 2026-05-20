<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Proyecto ECommerce - Inicio</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/estiloIndex.css">
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
                    <section class="hero-inicio">
                        <div class="hero-texto">
                            <p class="hero-etiqueta">Aplicaciones Web · Unidad 4</p>
                            <h1 class="titulo-principal">Proyecto ECommerce</h1>
                            <p class="subtitulo-principal">
                                Página de presentación del equipo y del sistema desarrollado para la materia.
                                Usa el menú lateral para navegar por la tienda.
                            </p>
                            <ul class="hero-features">
                                <li><i class="fa-solid fa-check"></i> Carrito y checkout</li>
                                <li><i class="fa-solid fa-check"></i> Gestión de pedidos y pagos</li>
                                <li><i class="fa-solid fa-check"></i> Panel administrativo</li>
                            </ul>
                        </div>
                    </section>

                    <section class="equipo">
                         <div class="equipo-info">
                            <h2 class="seccion-titulo">Equipo de desarrollo</h2>
                            <p class="seccion-subtitulo">Proyecto académico ECommerce</p>

                            <div class="equipo-desarrollo equipo-desarrollo-centrado">
                                <div class="tarjeta-desarrollador">
                                    <div class="icono-dev" aria-hidden="true">
                                         <i class="fa-solid fa-code"></i>
                                    </div>
                                    <div class="info-dev">
                                        <p class="nombre-dev">Jose Adolfo Ortega Ruiz</p>
                                        <p class="id-dev">ID: 00000252882</p>
                                     </div>
                                </div>

                                <div class="tarjeta-desarrollador">
                                     <div class="icono-dev" aria-hidden="true">
                                        <i class="fa-solid fa-code"></i>
                                    </div>
                                    <div class="info-dev">
                                        <p class="nombre-dev">Angel Gabriel Beltran Duarte</p>
                                         <p class="id-dev">ID: 00000244865</p>
                                    </div>
                                </div>
                             </div>

                            <div class="info-proyecto">
                                <h3><i class="fa-solid fa-circle-info"></i> Sobre este proyecto</h3>
                                <p>
                                    Aplicación web con Jakarta EE, MongoDB y capas DAO/BO.
                                </p>
                            </div>
                        </div>
                    </section>
                </main>

                <footer class="footer">
                    <p>Aplicaciones Web – Unidad 4</p>
                </footer>
            </div>
        </div>

    </body>
</html>