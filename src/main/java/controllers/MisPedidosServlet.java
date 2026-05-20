package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import model.Usuario;
import model.Pedido;
import negocio.UsuarioBO;
import negocio.PedidoBO;
import negocio.interfaces.IUsuarioBO;
import negocio.interfaces.IPedidoBO;
import org.bson.types.ObjectId;

/**
 * Servlet para mostrar el historial de pedidos del usuario
 */
@WebServlet(name = "MisPedidosServlet", urlPatterns = {"/misPedidos"})
public class MisPedidosServlet extends HttpServlet {

    private IUsuarioBO usuarioBO;
    private IPedidoBO pedidoBO;

    public MisPedidosServlet() {
        this.usuarioBO = new UsuarioBO();
        this.pedidoBO = new PedidoBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);

        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/loginView.jsp");
            return;
        }

        String correo = (String) sesion.getAttribute("usuario");
        Optional<Usuario> usuarioOpt = usuarioBO.obtenerUsuarioPorCorreo(correo);

        if (!usuarioOpt.isPresent()) {
            request.setAttribute("error", "Usuario no encontrado");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        Usuario usuario = usuarioOpt.get();
        String pedidoIdStr = request.getParameter("pedidoId");

        if (pedidoIdStr != null && !pedidoIdStr.trim().isEmpty()) {
            mostrarDetalle(request, response, usuario, pedidoIdStr.trim());
            return;
        }

        mostrarLista(request, response, usuario);
    }

    private void mostrarLista(HttpServletRequest request, HttpServletResponse response, Usuario usuario)
            throws ServletException, IOException {
        try {
            String errorParam = request.getParameter("error");
            if (errorParam != null && !errorParam.trim().isEmpty()) {
                request.setAttribute("error", errorParam);
            }
            List<Pedido> pedidos = pedidoBO.obtenerPedidosPorUsuario(usuario.getId());
            request.setAttribute("usuario", usuario);
            request.setAttribute("pedidos", pedidos);
            request.setAttribute("numerosPedido", construirNumerosPedido(pedidos));
            request.getRequestDispatcher("/misPedidosView.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al obtener pedidos: " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

    private void mostrarDetalle(HttpServletRequest request, HttpServletResponse response,
            Usuario usuario, String pedidoIdStr) throws ServletException, IOException {
        try {
            ObjectId pedidoId = new ObjectId(pedidoIdStr);
            Pedido pedido = pedidoBO.obtenerPedidoConDetalles(pedidoId);

            if (pedido.getIdUsuario() == null || !pedido.getIdUsuario().equals(usuario.getId())) {
                response.sendRedirect(request.getContextPath() + "/misPedidos?error="
                        + java.net.URLEncoder.encode("No tienes permiso para ver este pedido", "UTF-8"));
                return;
            }

            String numeroPedido = pedido.getNumeroPedido();
            if (numeroPedido == null || numeroPedido.trim().isEmpty()) {
                numeroPedido = generarNumeroPedido(pedido.getId().toString());
            }

            request.setAttribute("usuario", usuario);
            request.setAttribute("pedidoDetalle", pedido);
            request.setAttribute("numeroPedido", numeroPedido);
            request.getRequestDispatcher("/misPedidosView.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            response.sendRedirect(request.getContextPath() + "/misPedidos?error="
                    + java.net.URLEncoder.encode("ID de pedido inválido", "UTF-8"));
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/misPedidos?error="
                    + java.net.URLEncoder.encode(
                            e.getMessage() != null ? e.getMessage() : "Pedido no encontrado", "UTF-8"));
        }
    }

    private Map<String, String> construirNumerosPedido(List<Pedido> pedidos) {
        Map<String, String> numeros = new HashMap<>();
        for (Pedido p : pedidos) {
            if (p.getId() != null) {
                String numero = p.getNumeroPedido();
                if (numero == null || numero.trim().isEmpty()) {
                    numero = generarNumeroPedido(p.getId().toString());
                }
                numeros.put(p.getId().toHexString(), numero);
            }
        }
        return numeros;
    }

    private String generarNumeroPedido(String objectId) {
        String fecha = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String hash = objectId.substring(0, 5).toUpperCase();
        return "PED-" + fecha + "-" + hash;
    }
}
