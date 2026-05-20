/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package negocio;

import Config.MongoClientProvider;
import java.util.Date;
import java.util.List;
import model.Pedido;
import model.detallePedido;
import model.estadoPedido;
import negocio.interfaces.IPedidoBO;
import org.bson.types.ObjectId;
import persistencia.IDetallesPedidoDAO;
import persistencia.IPedidoDAO;
import persistencia.impl.PedidoDAO;
import persistencia.impl.detallesPedidoDAO;

/**
 *
 * @author USER
 */
public class PedidoBO implements IPedidoBO {

    private final IPedidoDAO pedidoDAO;
    private final IDetallesPedidoDAO detallesPedidoDAO;

    public PedidoBO() {
        this.pedidoDAO = new PedidoDAO(MongoClientProvider.INSTANCE.getcCollection("pedido", Pedido.class));
        this.detallesPedidoDAO = new detallesPedidoDAO(
                MongoClientProvider.INSTANCE.getcCollection("detalle_pedido", detallePedido.class));
    }

    public PedidoBO(IPedidoDAO pedidoDAO, IDetallesPedidoDAO detallesPedidoDAO) {
        this.pedidoDAO = new PedidoDAO(MongoClientProvider.INSTANCE.getcCollection("pedido", Pedido.class));
        this.detallesPedidoDAO = new detallesPedidoDAO(
                MongoClientProvider.INSTANCE.getcCollection("detalle_pedido", detallePedido.class));
    }

    @Override
    public List<Pedido> listarTodosPedidos() {
        return pedidoDAO.listarTodos();
    }

    @Override
    public List<Pedido> listarPedidosPorUsuario(ObjectId idUsuario) {
        if (idUsuario == null) {
            throw new IllegalArgumentException("El id de usuario es obligatorio");
        }
        return pedidoDAO.listarPorUsuario(idUsuario);
    }

    @Override
    public Pedido obtenerPedidoConDetalles(ObjectId id) throws Exception {
        if (id == null) {
            throw new IllegalArgumentException("El id del pedido es obligatorio");
        }
        Pedido pedido = pedidoDAO.obtenerPorId(id)
                .orElseThrow(() -> new Exception("Pedido no encontrado"));
        List<detallePedido> embebidos = pedido.getProductos();
        if (embebidos == null || embebidos.isEmpty()) {
            pedido.setProductos(detallesPedidoDAO.obtenerPorPedido(id));
        }
        return pedido;
    }

    @Override
    public void crearPedido(Pedido pedido, List<detallePedido> detalles) throws Exception {
        if (pedido == null) {
            throw new IllegalArgumentException("El pedido no puede ser nulo");
        }
        if (detalles == null || detalles.isEmpty()) {
            throw new Exception("El pedido debe tener al menos un detalle");
        }
        if (pedido.getFecha() == null) {
            pedido.setFecha(new Date());
        }
        if (pedido.getEstado() == null) {
            pedido.setEstado(estadoPedido.PENDIENTE);
        }
        if (pedido.getEstadoPago() == null || pedido.getEstadoPago().trim().isEmpty()) {
            pedido.setEstadoPago("POR_CONFIRMAR");
        }
        pedidoDAO.crear(pedido);
        ObjectId pedidoId = pedido.getId();
        for (detallePedido detalle : detalles) {
            detalle.setPedidoId(pedidoId);
        }
        detallesPedidoDAO.agregarDetalles(detalles);
        pedido.setProductos(detalles);
    }

    @Override
    public boolean cambiarEstadoPedido(ObjectId id, estadoPedido nuevoEstado) throws Exception {
        if (id == null) {
            throw new IllegalArgumentException("El id del pedido es obligatorio");
        }
        if (nuevoEstado == null) {
            throw new IllegalArgumentException("El estado del pedido es obligatorio");
        }
        return pedidoDAO.actualizarEstado(id, nuevoEstado);
    }

    @Override
    public boolean actualizarPedido(Pedido pedido) throws Exception {
        if (pedido == null || pedido.getId() == null) {
            throw new IllegalArgumentException("El pedido debe tener id para actualizar");
        }
        return pedidoDAO.actualizar(pedido);
    }
    
    public void registrarPedido(Pedido pedido) throws Exception {
        if (pedido == null) {
            throw new IllegalArgumentException("El pedido no puede ser nulo");
        }
        if (pedido.getProductos() == null || pedido.getProductos().isEmpty()) {
            throw new Exception("El pedido debe tener al menos un detalle");
        }
        if (pedido.getFecha() == null) {
            pedido.setFecha(new Date());
        }
        if (pedido.getEstado() == null) {
            pedido.setEstado(estadoPedido.PENDIENTE);
        }
        if (pedido.getEstadoPago() == null || pedido.getEstadoPago().trim().isEmpty()) {
            pedido.setEstadoPago("POR_CONFIRMAR");
        }
        pedidoDAO.crear(pedido);
    }
    
    public List<Pedido> obtenerPedidosPorUsuario(ObjectId idUsuario) throws Exception {
        if (idUsuario == null) {
            throw new IllegalArgumentException("El id de usuario es obligatorio");
        }
        return pedidoDAO.listarPorUsuario(idUsuario);
    }

    @Override
    public boolean cambiarEstadoPago(ObjectId id, String nuevoEstadoPago) throws Exception {
        if (id == null) {
            throw new IllegalArgumentException("El id del pedido es obligatorio");
        }
        if (nuevoEstadoPago == null || nuevoEstadoPago.trim().isEmpty()) {
            throw new IllegalArgumentException("El estado de pago es obligatorio");
        }
        Pedido pedido = pedidoDAO.obtenerPorId(id)
                .orElseThrow(() -> new Exception("Pedido no encontrado"));
        pedido.setEstadoPago(nuevoEstadoPago.trim());
        return pedidoDAO.actualizar(pedido);
    }
}
