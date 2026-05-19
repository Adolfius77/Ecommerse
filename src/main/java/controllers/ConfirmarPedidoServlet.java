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
import java.util.Date;
import model.ItemCarrito;
import model.Usuario;
import model.Pedido;
import model.detallePedido;
import model.estadoPedido;
import negocio.UsuarioBO;
import negocio.PedidoBO;
import negocio.ProductoBO;
import negocio.interfaces.IUsuarioBO;
import negocio.interfaces.IPedidoBO;
import negocio.interfaces.IProductoBO;
import org.bson.types.ObjectId;
import util.EmailService;
import util.PagoValidator;

/**
 * Servlet para confirmar y crear un pedido
 */
@WebServlet(name = "ConfirmarPedidoServlet", urlPatterns = {"/confirmarPedido"})
public class ConfirmarPedidoServlet extends HttpServlet {
    
    private IUsuarioBO usuarioBO;
    private IPedidoBO pedidoBO;
    private IProductoBO productoBO;
    private static final String CARRITO_SESION = "carrito";
    
    public ConfirmarPedidoServlet() {
        this.usuarioBO = new UsuarioBO();
        this.pedidoBO = new PedidoBO();
        this.productoBO = new ProductoBO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession sesion = request.getSession(false);
        
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/loginView.jsp");
            return;
        }
        
        List<ItemCarrito> carrito = (List<ItemCarrito>) sesion.getAttribute(CARRITO_SESION);
        
        if (carrito == null || carrito.isEmpty()) {
            request.setAttribute("error", "El carrito está vacío");
            request.getRequestDispatcher("/carritoView.jsp").forward(request, response);
            return;
        }
        
        String correo = (String) sesion.getAttribute("usuario");
        Optional<Usuario> usuarioOpt = usuarioBO.obtenerUsuarioPorCorreo(correo);
        
        if (!usuarioOpt.isPresent()) {
            request.setAttribute("error", "Usuario no encontrado");
            request.getRequestDispatcher("/checkoutView.jsp").forward(request, response);
            return;
        }
        
        Usuario usuario = usuarioOpt.get();
        
        String metodoPago = request.getParameter("metodoPago");
        String direccionEnvio = PagoValidator.construirDireccionEnvio(request);

        java.util.Optional<String> errorPago = PagoValidator.validar(request);
        if (errorPago.isPresent()) {
            request.setAttribute("error", errorPago.get());
            request.setAttribute("usuario", usuario);
            request.setAttribute("carrito", carrito);
            double subtotalErr = carrito.stream().mapToDouble(ItemCarrito::getSubtotal).sum();
            request.setAttribute("subtotal", subtotalErr);
            request.setAttribute("total", subtotalErr);
            request.getRequestDispatcher("/checkoutView.jsp").forward(request, response);
            return;
        }

        if (direccionEnvio == null || direccionEnvio.trim().isEmpty()) {
            request.setAttribute("error", "Debe proporcionar la dirección de envío");
            request.setAttribute("usuario", usuario);
            request.setAttribute("carrito", carrito);
            double subtotalErr = carrito.stream().mapToDouble(ItemCarrito::getSubtotal).sum();
            request.setAttribute("subtotal", subtotalErr);
            request.setAttribute("total", subtotalErr);
            request.getRequestDispatcher("/checkoutView.jsp").forward(request, response);
            return;
        }
        
        try {
            Pedido pedido = new Pedido();
            pedido.setId(new ObjectId());
            pedido.setIdUsuario(usuario.getId());
            pedido.setNombreCliente(usuario.getNombre());
            pedido.setFecha(new Date());
            pedido.setEstado(estadoPedido.PENDIENTE);
            pedido.setMetodoPago(metodoPago);
            pedido.setDireccionEnvio(direccionEnvio);
            pedido.setEstadoPago(estadoPagoInicial(metodoPago));

            double total = 0;
            List<detallePedido> detalles = new java.util.ArrayList<>();
            
            for (ItemCarrito item : carrito) {
                detallePedido detalle = new detallePedido();
                detalle.setPedidoId(pedido.getId());
                detalle.setNombreProducto(item.getNombre());
                detalle.setPrecioUnitario(item.getPrecioUnitario());
                detalle.setCantidad(item.getCantidad());
                detalle.setSubtotal(item.getSubtotal());
                detalles.add(detalle);
                total += item.getSubtotal();
            }
            
            pedido.setProductos(detalles);
            pedido.setTotal(total);
            
            pedidoBO.registrarPedido(pedido);
            
            String numeroPedido = generarNumeroPedido(pedido.getId().toString());
            
            try {
                EmailService emailService = new EmailService();
                emailService.enviarConfirmacionPedido(usuario.getCorreo(), usuario.getNombre(),
                        numeroPedido, total);
                request.setAttribute("emailEnviado", true);
            } catch (Exception e) {
                System.err.println("Error al enviar email: " + e.getMessage());
                request.setAttribute("avisoEmail",
                        "Pedido registrado correctamente. No se pudo enviar el correo de confirmación: "
                                + e.getMessage()
                                + ". Configure SENDER_EMAIL y SENDER_PASSWORD en el servidor.");
            }
            
            request.setAttribute("pedido", pedido);
            request.setAttribute("numeroPedido", numeroPedido);
            request.setAttribute("metodoPago", metodoPago);
            request.setAttribute("direccionEnvio", direccionEnvio);
            request.setAttribute("mensaje", "Pedido creado exitosamente");
            
            sesion.removeAttribute(CARRITO_SESION);
            
            request.getRequestDispatcher("/confirmacionPedidoView.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error al crear el pedido: " + e.getMessage());
            request.setAttribute("usuario", usuario);
            request.setAttribute("carrito", carrito);
            double subtotalErr = carrito.stream().mapToDouble(ItemCarrito::getSubtotal).sum();
            request.setAttribute("subtotal", subtotalErr);
            request.setAttribute("total", subtotalErr);
            request.getRequestDispatcher("/checkoutView.jsp").forward(request, response);
        }
    }
    
    private String generarNumeroPedido(String objectId) {
        String fecha = new java.text.SimpleDateFormat("yyyyMMdd").format(new Date());
        String hash = objectId.substring(0, 5).toUpperCase();
        return "PED-" + fecha + "-" + hash;
    }

    private String estadoPagoInicial(String metodoPago) {
        if ("contraentrega".equals(metodoPago)) {
            return "PENDIENTE";
        }
        return "POR_CONFIRMAR";
    }
}
