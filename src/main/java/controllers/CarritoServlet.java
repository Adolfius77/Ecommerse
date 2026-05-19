package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import model.ItemCarrito;
import model.Producto;
import negocio.ProductoBO;
import negocio.interfaces.IProductoBO;
import org.bson.types.ObjectId;

/**
 * Servlet para gestionar el carrito de compras
 */
@WebServlet(name = "CarritoServlet", urlPatterns = {"/carrito"})
public class CarritoServlet extends HttpServlet {
    
    private IProductoBO productoBO;
    private static final String CARRITO_SESION = "carrito";
    
    public CarritoServlet() {
        this.productoBO = new ProductoBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            accion = "ver";
        }
        
        switch(accion) {
            case "agregar":
                agregarProducto(request, response);
                break;
            case "eliminar":
                eliminarProducto(request, response);
                break;
            case "actualizar":
                actualizarCantidad(request, response);
                break;
            case "ver":
            default:
                verCarrito(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void agregarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productoIdStr = request.getParameter("productoId");
        String cantidadStr = request.getParameter("cantidad");
        
        if (productoIdStr == null || cantidadStr == null) {
            request.setAttribute("error", "Parámetros inválidos");
            verCarrito(request, response);
            return;
        }
        
        try {
            ObjectId productoId = new ObjectId(productoIdStr);
            int cantidad = Integer.parseInt(cantidadStr);
            
            Optional<Producto> productoOpt = productoBO.obtenerPorId(productoId);
            
            if (!productoOpt.isPresent()) {
                request.setAttribute("error", "Producto no encontrado");
                verCarrito(request, response);
                return;
            }
            
            Producto producto = productoOpt.get();
            
            if (producto.getStock() < cantidad) {
                request.setAttribute("error", "Stock insuficiente");
                verCarrito(request, response);
                return;
            }
            
            HttpSession sesion = request.getSession();
            List<ItemCarrito> carrito = obtenerCarritoDelaSesion(sesion);
            
            ItemCarrito itemExistente = carrito.stream()
                    .filter(item -> item.getProductoId().equals(productoId))
                    .findFirst()
                    .orElse(null);
            
            if (itemExistente != null) {
                int nuevaCantidad = itemExistente.getCantidad() + cantidad;
                if (producto.getStock() < nuevaCantidad) {
                    request.setAttribute("error", "Stock insuficiente para la cantidad solicitada");
                    verCarrito(request, response);
                    return;
                }
                itemExistente.setCantidad(nuevaCantidad);
            } else {
                ItemCarrito nuevoItem = new ItemCarrito(
                    productoId, 
                    producto.getNombre(), 
                    producto.getPrecio(), 
                    cantidad, 
                    producto.getImagenProducto()
                );
                carrito.add(nuevoItem);
            }
            
            sesion.setAttribute(CARRITO_SESION, carrito);
            request.setAttribute("mensaje", "Producto agregado al carrito");
            
        } catch (Exception e) {
            request.setAttribute("error", "Error al agregar producto: " + e.getMessage());
        }
        
        verCarrito(request, response);
    }
    
    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productoIdStr = request.getParameter("productoId");
        
        if (productoIdStr == null) {
            request.setAttribute("error", "ID de producto inválido");
            verCarrito(request, response);
            return;
        }
        
        try {
            ObjectId productoId = new ObjectId(productoIdStr);
            HttpSession sesion = request.getSession();
            List<ItemCarrito> carrito = obtenerCarritoDelaSesion(sesion);
            
            carrito.removeIf(item -> item.getProductoId().equals(productoId));
            sesion.setAttribute(CARRITO_SESION, carrito);
            request.setAttribute("mensaje", "Producto eliminado del carrito");
            
        } catch (Exception e) {
            request.setAttribute("error", "Error al eliminar producto: " + e.getMessage());
        }
        
        verCarrito(request, response);
    }
    
    private void actualizarCantidad(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productoIdStr = request.getParameter("productoId");
        String cantidadStr = request.getParameter("cantidad");
        
        if (productoIdStr == null || cantidadStr == null) {
            request.setAttribute("error", "Parámetros inválidos");
            verCarrito(request, response);
            return;
        }
        
        try {
            ObjectId productoId = new ObjectId(productoIdStr);
            int cantidad = Integer.parseInt(cantidadStr);
            
            if (cantidad <= 0) {
                eliminarProducto(request, response);
                return;
            }
            
            Optional<Producto> productoOpt = productoBO.obtenerPorId(productoId);
            
            if (!productoOpt.isPresent()) {
                request.setAttribute("error", "Producto no encontrado");
                verCarrito(request, response);
                return;
            }
            
            Producto producto = productoOpt.get();
            
            if (producto.getStock() < cantidad) {
                request.setAttribute("error", "Stock insuficiente");
                verCarrito(request, response);
                return;
            }
            
            HttpSession sesion = request.getSession();
            List<ItemCarrito> carrito = obtenerCarritoDelaSesion(sesion);
            
            ItemCarrito item = carrito.stream()
                    .filter(i -> i.getProductoId().equals(productoId))
                    .findFirst()
                    .orElse(null);
            
            if (item != null) {
                item.setCantidad(cantidad);
                sesion.setAttribute(CARRITO_SESION, carrito);
                request.setAttribute("mensaje", "Cantidad actualizada");
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error al actualizar cantidad: " + e.getMessage());
        }
        
        verCarrito(request, response);
    }
    
    private void verCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        List<ItemCarrito> carrito = obtenerCarritoDelaSesion(sesion);
        
        double subtotal = carrito.stream()
                .mapToDouble(ItemCarrito::getSubtotal)
                .sum();
        
        request.setAttribute("carrito", carrito);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("total", subtotal);
        request.getRequestDispatcher("/carritoView.jsp").forward(request, response);
    }
    
    private List<ItemCarrito> obtenerCarritoDelaSesion(HttpSession sesion) {
        List<ItemCarrito> carrito = (List<ItemCarrito>) sesion.getAttribute(CARRITO_SESION);
        if (carrito == null) {
            carrito = new ArrayList<>();
        }
        return carrito;
    }
}
