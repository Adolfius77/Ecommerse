<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Administrativo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-page: #eceff2;
            --bg-surface: #ffffff;
            --bg-nav: #1c2128;
            --text-primary: #1c2128;
            --text-secondary: #5c6570;
            --text-muted: #8b939c;
            --border: #d8dde3;
            --accent: #3d4f5f;
            --accent-hover: #2f3d4a;
            --danger: #8b3a3a;
            --danger-hover: #723030;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: var(--bg-page);
            min-height: 100vh;
            padding: 20px 0;
            font-family: 'IBM Plex Sans', system-ui, -apple-system, sans-serif;
            font-size: 0.9375rem;
            line-height: 1.5;
            color: var(--text-primary);
            -webkit-font-smoothing: antialiased;
        }

        .navbar {
            background-color: var(--bg-nav) !important;
            box-shadow: 0 1px 0 rgba(0, 0, 0, 0.12);
            border-bottom: 1px solid #2d333b;
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 1.125rem;
            letter-spacing: -0.02em;
            color: #f0f2f4 !important;
        }

        .navbar .btn-danger {
            background-color: var(--danger);
            border-color: var(--danger);
            font-weight: 500;
            font-size: 0.8125rem;
        }

        .navbar .btn-danger:hover {
            background-color: var(--danger-hover);
            border-color: var(--danger-hover);
        }

        .welcome-section {
            color: var(--text-primary);
            text-align: center;
            margin: 40px 0 30px;
            font-size: 1rem;
        }

        .welcome-section h2 {
            font-size: 1.75rem;
            font-weight: 600;
            letter-spacing: -0.03em;
            margin-bottom: 8px;
            color: var(--text-primary);
        }

        .welcome-section p {
            color: var(--text-secondary);
            font-weight: 400;
        }

        .admin-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto 40px;
            padding: 0 20px;
        }

        .admin-card {
            background: var(--bg-surface);
            border-radius: 6px;
            border: 1px solid var(--border);
            overflow: hidden;
            box-shadow: 0 1px 2px rgba(28, 33, 40, 0.04);
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
            cursor: pointer;
            text-decoration: none !important;
            color: inherit !important;
            display: flex;
            flex-direction: column;
        }

        .admin-card:hover {
            border-color: #b8c0c8;
            box-shadow: 0 4px 12px rgba(28, 33, 40, 0.08);
            color: inherit !important;
        }

        .admin-card-header {
            padding: 20px 22px;
            color: var(--text-primary);
            background: #f6f7f9;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            min-height: 88px;
        }

        .admin-card-header h3 {
            font-weight: 600;
            letter-spacing: -0.02em;
        }

        .admin-card-icon {
            font-size: 1.5rem;
            color: var(--accent);
            opacity: 0.85;
        }

        .admin-card-body {
            padding: 20px 22px;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .admin-card-title {
            font-size: 1.0625rem;
            font-weight: 600;
            letter-spacing: -0.02em;
            margin-bottom: 8px;
            color: var(--text-primary);
        }

        .admin-card-description {
            color: var(--text-secondary);
            font-size: 0.875rem;
            margin-bottom: 16px;
            flex: 1;
            line-height: 1.55;
        }

        .admin-card-button {
            display: inline-block;
            background: var(--accent);
            color: #f5f6f7;
            padding: 9px 18px;
            border-radius: 4px;
            text-decoration: none !important;
            text-align: center;
            font-weight: 500;
            font-size: 0.8125rem;
            letter-spacing: 0.01em;
            transition: background-color 0.2s ease;
            cursor: pointer;
            border: none;
        }

        .admin-card-button:hover {
            background: var(--accent-hover);
            color: #f5f6f7 !important;
            text-decoration: none !important;
        }

        .card-usuarios .admin-card-header { border-left: 3px solid #4a5568; }
        .card-productos .admin-card-header { border-left: 3px solid #5a4e4e; }
        .card-categorias .admin-card-header { border-left: 3px solid #5c5344; }
        .card-pedidos .admin-card-header { border-left: 3px solid #3d5248; }
        .card-pagos .admin-card-header { border-left: 3px solid #3d4a52; }
        .card-resenas .admin-card-header { border-left: 3px solid #454a5c; }

        .card-usuarios .admin-card-header h3,
        .card-productos .admin-card-header h3,
        .card-categorias .admin-card-header h3,
        .card-pedidos .admin-card-header h3,
        .card-pagos .admin-card-header h3,
        .card-resenas .admin-card-header h3 {
            color: var(--text-primary) !important;
        }

        .logout-section {
            text-align: center;
            margin: 40px 0;
        }

        .btn-logout {
            background: var(--bg-surface);
            color: var(--danger);
            padding: 10px 32px;
            font-weight: 500;
            font-size: 0.875rem;
            border-radius: 4px;
            text-decoration: none !important;
            transition: background-color 0.2s ease, border-color 0.2s ease, color 0.2s ease;
            display: inline-block;
            border: 1px solid #c9b4b4;
            cursor: pointer;
        }

        .btn-logout:hover {
            background: #faf5f5;
            color: var(--danger-hover) !important;
            border-color: #b89a9a;
            text-decoration: none !important;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <span class="navbar-brand">
                <i class="fas fa-crown"></i> Panel Administrativo
            </span>
            <div class="ms-auto text-white">
                <span class="me-3">
                    <i class="fas fa-user"></i> ${sessionScope.usuario}
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">
                    <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                </a>
            </div>
        </div>
    </nav>

    <!-- Welcome Message -->
    <div class="welcome-section">
        <h2>¡Bienvenido, Administrador!</h2>
        <p>Selecciona una opción para gestionar la plataforma</p>
    </div>

    <!-- Admin Cards Grid -->
    <div class="admin-grid">
        
        <!-- Gestión de Usuarios -->
        <a href="${pageContext.request.contextPath}/admin/gestionUsuarios" class="admin-card card-usuarios">
            <div class="admin-card-header">
                <div>
                    <h3 style="margin: 0; font-size: 1.2rem; color: white;">Usuarios</h3>
                </div>
                <div class="admin-card-icon">
                    <i class="fas fa-users"></i>
                </div>
            </div>
            <div class="admin-card-body">
                <div class="admin-card-title">Gestión de Usuarios</div>
                <div class="admin-card-description">
                    Administra cuentas de usuarios, cambia roles (CLIENTE/ADMIN), activa/desactiva.
                </div>
                <span class="admin-card-button">Ir a Usuarios</span>
            </div>
        </a>

        <!-- Gestión de Productos -->
        <a href="${pageContext.request.contextPath}/admin/gestionProductos" class="admin-card card-productos">
            <div class="admin-card-header">
                <div>
                    <h3 style="margin: 0; font-size: 1.2rem; color: white;">Productos</h3>
                </div>
                <div class="admin-card-icon">
                    <i class="fas fa-box"></i>
                </div>
            </div>
            <div class="admin-card-body">
                <div class="admin-card-title">Gestión de Productos</div>
                <div class="admin-card-description">
                    Crea, edita y elimina productos. Administra precios y disponibilidad.
                </div>
                <span class="admin-card-button">Ir a Productos</span>
            </div>
        </a>

        <!-- Gestión de Categorías -->
        <a href="${pageContext.request.contextPath}/admin/gestionCategorias" class="admin-card card-categorias">
            <div class="admin-card-header">
                <div>
                    <h3 style="margin: 0; font-size: 1.2rem; color: white;">Categorías</h3>
                </div>
                <div class="admin-card-icon">
                    <i class="fas fa-tags"></i>
                </div>
            </div>
            <div class="admin-card-body">
                <div class="admin-card-title">Gestión de Categorías</div>
                <div class="admin-card-description">
                    Organiza los productos. Crea, edita y elimina categorías.
                </div>
                <span class="admin-card-button">Ir a Categorías</span>
            </div>
        </a>

        <!-- Gestión de Pedidos -->
        <a href="${pageContext.request.contextPath}/admin/gestionPedidos" class="admin-card card-pedidos">
            <div class="admin-card-header">
                <div>
                    <h3 style="margin: 0; font-size: 1.2rem; color: white;">Pedidos</h3>
                </div>
                <div class="admin-card-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
            </div>
            <div class="admin-card-body">
                <div class="admin-card-title">Gestión de Pedidos</div>
                <div class="admin-card-description">
                    Visualiza todos los pedidos, actualiza estados.
                </div>
                <span class="admin-card-button">Ir a Pedidos</span>
            </div>
        </a>

        <!-- Gestión de Pagos -->
        <a href="${pageContext.request.contextPath}/admin/gestionPedidos" class="admin-card card-pagos">
            <div class="admin-card-header">
                <div>
                    <h3 style="margin: 0; font-size: 1.2rem; color: white;">Pagos</h3>
                </div>
                <div class="admin-card-icon">
                    <i class="fas fa-credit-card"></i>
                </div>
            </div>
            <div class="admin-card-body">
                <div class="admin-card-title">Historial de Pagos</div>
                <div class="admin-card-description">
                    Revisa transacciones, métodos de pago y montos.
                </div>
                <span class="admin-card-button">Ir a Pagos</span>
            </div>
        </a>

        <!-- Moderación de Reseñas -->
        <a href="${pageContext.request.contextPath}/admin/moderacionResenas" class="admin-card card-resenas">
            <div class="admin-card-header">
                <div>
                    <h3 style="margin: 0; font-size: 1.2rem; color: white;">Reseñas</h3>
                </div>
                <div class="admin-card-icon">
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <div class="admin-card-body">
                <div class="admin-card-title">Moderación de Reseñas</div>
                <div class="admin-card-description">
                    Aprueba o rechaza reseñas. Elimina contenido inapropiado.
                </div>
                <span class="admin-card-button">Ir a Reseñas</span>
            </div>
        </a>

    </div>

    <!-- Logout Section -->
    <div class="logout-section">
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
            <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
        </a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
