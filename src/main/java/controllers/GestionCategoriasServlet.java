package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;
import model.Categoria;
import negocio.CategoriaBO;
import negocio.interfaces.ICategoriaBO;
import org.bson.types.ObjectId;

/**
 * Servlet para gestión de categorías por admin
 */
@WebServlet(name = "GestionCategoriasServlet", urlPatterns = {"/admin/gestionCategorias"})
public class GestionCategoriasServlet extends HttpServlet {
    
    private ICategoriaBO categoriaBO;
    
    public GestionCategoriasServlet() {
        this.categoriaBO = new CategoriaBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!esAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        String accion = request.getParameter("accion");
        String id = request.getParameter("id");
        
        try {
            if ("editar".equals(accion) && id != null && !id.isEmpty()) {
         
                Optional<Categoria> categoria = categoriaBO.obtenerPorId(new ObjectId(id));
                List<Categoria> categorias = categoriaBO.listarCategorias();
                request.setAttribute("categoria", categoria);
                request.setAttribute("categorias", categorias);
            } else {
                
                List<Categoria> categorias = categoriaBO.listarCategorias();
                request.setAttribute("categorias", categorias);
            }
            request.getRequestDispatcher("/gestionCategoriasView.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al procesar categorías: " + e.getMessage());
            try {
                List<Categoria> categorias = categoriaBO.listarCategorias();
                request.setAttribute("categorias", categorias);
            } catch (Exception ex) {}
            request.getRequestDispatcher("/gestionCategoriasView.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!esAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String id = request.getParameter("id");
        
        try {
            if ("crear".equals(accion)) {
                Categoria categoria = new Categoria();
                categoria.setNombre(nombre);
                categoria.setDescripcion(descripcion);
                categoriaBO.crearCategoria(categoria);
                request.setAttribute("mensaje", "Categoría creada correctamente");
            } else if ("actualizar".equals(accion)) {
                if (id != null && !id.isEmpty()) {
                    Categoria categoria = new Categoria();
                    categoria.setId(new ObjectId(id));
                    categoria.setNombre(nombre);
                    categoria.setDescripcion(descripcion);
                    categoriaBO.actualizarCategoria(categoria);
                    request.setAttribute("mensaje", "Categoría actualizada correctamente");
                } else {
                    request.setAttribute("error", "ID de categoría requerido para actualizar");
                }
            } else if ("eliminar".equals(accion)) {
                if (id != null && !id.isEmpty()) {
                    categoriaBO.eliminarCategoria(new ObjectId(id));
                    request.setAttribute("mensaje", "Categoría eliminada correctamente");
                } else {
                    request.setAttribute("error", "ID de categoría requerido para eliminar");
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error al procesar categoría: " + e.getMessage());
        }
        
        doGet(request, response);
    }
    
    private boolean esAdmin(HttpServletRequest request) {
        HttpSession sesion = request.getSession(false);
        return sesion != null && sesion.getAttribute("usuario") != null;
    }
}
