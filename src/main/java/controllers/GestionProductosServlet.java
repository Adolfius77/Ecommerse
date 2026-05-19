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
import model.Producto;
import negocio.ProductoBO;
import negocio.interfaces.IProductoBO;
import org.bson.types.ObjectId;

/**
 * Servlet para CRUD de productos por admin
 */
@WebServlet(name = "GestionProductosServlet", urlPatterns = {"/admin/gestionProductos"})
public class GestionProductosServlet extends HttpServlet {
    
    private IProductoBO productoBO;
    
    public GestionProductosServlet() {
        this.productoBO = new ProductoBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!esAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        String accion = request.getParameter("accion");
        
        if ("editar".equals(accion)) {
            mostrarFormularioEdicion(request, response);
        } else if ("nuevo".equals(accion)) {
            mostrarFormularioNuevo(request, response);
        } else {
            listarProductos(request, response);
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
        
        if ("guardar".equals(accion)) {
            guardarProducto(request, response);
        } else if ("eliminar".equals(accion)) {
            eliminarProducto(request, response);
        } else {
            doGet(request, response);
        }
    }
    
    private void listarProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Producto> productos = productoBO.listarProductos();
            request.setAttribute("productos", productos);
            request.getRequestDispatcher("/gestionProductosView.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al listar productos: " + e.getMessage());
            request.getRequestDispatcher("/gestionProductosView.jsp").forward(request, response);
        }
    }
    
    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("producto", null);
        request.setAttribute("modo", "nuevo");
        request.getRequestDispatcher("/formularioProductoView.jsp").forward(request, response);
    }
    
    private void mostrarFormularioEdicion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productoIdStr = request.getParameter("id");
        
        if (productoIdStr == null || productoIdStr.trim().isEmpty()) {
            request.setAttribute("error", "ID de producto inválido");
            listarProductos(request, response);
            return;
        }
        
        try {
            ObjectId productoId = new ObjectId(productoIdStr);
            Optional<Producto> productoOpt = productoBO.obtenerPorId(productoId);
            
            if (!productoOpt.isPresent()) {
                request.setAttribute("error", "Producto no encontrado");
                listarProductos(request, response);
                return;
            }
            
            List<Producto> productos = productoBO.listarProductos();
            request.setAttribute("productos", productos);
            request.setAttribute("producto", productoOpt.get());
            request.setAttribute("modo", "editar");
            request.getRequestDispatcher("/gestionProductosView.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al obtener producto: " + e.getMessage());
            listarProductos(request, response);
        }
    }
    
    private void guardarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productoIdStr = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String precio = request.getParameter("precio");
        String descripcion = request.getParameter("descripcion");
        String imagenProducto = request.getParameter("imagenProducto");
        String stock = request.getParameter("stock");
        String categoria = request.getParameter("categoria");
        
        try {
            Producto producto = new Producto();
            
            if (productoIdStr != null && !productoIdStr.trim().isEmpty()) {
                producto.setId(new ObjectId(productoIdStr));
            } else {
                producto.setId(new ObjectId());
            }
            
            producto.setNombre(nombre);
            producto.setPrecio(Double.parseDouble(precio));
            producto.setDescripcion(descripcion);
            producto.setImagenProducto(imagenProducto);
            producto.setStock(Integer.parseInt(stock));
            producto.setCategoria(categoria);
            
            if (productoIdStr != null && !productoIdStr.trim().isEmpty()) {
                productoBO.actualizarProducto(producto);
                request.setAttribute("mensaje", "Producto actualizado correctamente");
            } else {
                productoBO.registrarProducto(producto);
                request.setAttribute("mensaje", "Producto creado correctamente");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Valores numéricos inválidos: " + e.getMessage());
        } catch (Exception e) {
            request.setAttribute("error", "Error al guardar producto: " + e.getMessage());
        }
        
        listarProductos(request, response);
    }
    
    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productoIdStr = request.getParameter("id");
        
        if (productoIdStr == null || productoIdStr.trim().isEmpty()) {
            request.setAttribute("error", "ID de producto inválido");
            listarProductos(request, response);
            return;
        }
        
        try {
            ObjectId productoId = new ObjectId(productoIdStr);
            productoBO.eliminarProducto(productoId);
            request.setAttribute("mensaje", "Producto eliminado correctamente");
        } catch (Exception e) {
            request.setAttribute("error", "Error al eliminar producto: " + e.getMessage());
        }
        
        listarProductos(request, response);
    }
    
    private boolean esAdmin(HttpServletRequest request) {
        HttpSession sesion = request.getSession(false);
        if (sesion == null) {
            return false;
        }
        return sesion.getAttribute("usuario") != null;
    }
}
