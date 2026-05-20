package Filtros;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(filterName = "autentificacionFilter", urlPatterns = {"/*"})
public class autentificacionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession sesion = httpRequest.getSession(false);

        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        boolean esRecursoEstatico = path.startsWith("/styles/") || path.startsWith("/assets/") || path.startsWith("/img/");

        boolean esPaginaPublica = path.equals("/") || 
                                  path.equals("/index.jsp") || 
                                  path.equals("/loginView.jsp") || 
                                  path.equals("/registroView.jsp") || 
                                  path.equals("/login") || 
                                  path.equals("/Registro") || 
                                  path.equals("/catalogo") || 
                                  path.equals("/catalogoView.jsp") || 
                                  path.equals("/DetalleProducto") || 
                                  path.equals("/productoDetalleView.jsp");

        boolean esRutaAdmin = path.startsWith("/admin/") || 
                              path.equals("/adminDashboard.jsp") || 
                              path.equals("/GestionUsuarios") || 
                              path.equals("/gestionUsuariosView.jsp") ||
                              path.equals("/GestionProductos") || 
                              path.equals("/gestionProductosView.jsp") ||
                              path.equals("/GestionCategorias") ||
                              path.equals("/gestionCategoriasView.jsp") ||
                              path.equals("/GestionPedidos") ||
                              path.equals("/gestionPedidosPagosView.jsp");

        boolean estaLogueado = (sesion != null && sesion.getAttribute("usuario") != null);
        boolean esAdmin = (sesion != null && sesion.getAttribute("esAdmin") != null && (Boolean) sesion.getAttribute("esAdmin"));

        if (esRecursoEstatico || esPaginaPublica) {
            chain.doFilter(request, response);
        } else if (estaLogueado) {
            if (esRutaAdmin && !esAdmin) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/catalogo?error=acceso_denegado");
            } else {
                chain.doFilter(request, response);
            }
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/loginView.jsp?error=sesion_requerida");
        }
    }

    @Override
    public void destroy() {
    }

    @Override
    public void init(FilterConfig filterConfig) {
    }
}