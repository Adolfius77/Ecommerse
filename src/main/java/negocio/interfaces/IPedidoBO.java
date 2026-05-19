/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package negocio.interfaces;

import java.util.List;
import model.Pedido;
import model.detallePedido;
import model.estadoPedido;
import org.bson.types.ObjectId;

/**
 *
 * @author USER
 */
public interface IPedidoBO {

    List<Pedido> listarTodosPedidos();

    List<Pedido> listarPedidosPorUsuario(ObjectId idUsuario);

    Pedido obtenerPedidoConDetalles(ObjectId id) throws Exception;

    void crearPedido(Pedido pedido, List<detallePedido> detalles) throws Exception;

    boolean cambiarEstadoPedido(ObjectId id, estadoPedido nuevoEstado) throws Exception;

    boolean actualizarPedido(Pedido pedido) throws Exception;
    
    void registrarPedido(Pedido pedido) throws Exception;
    
    List<Pedido> obtenerPedidosPorUsuario(ObjectId idUsuario) throws Exception;

    boolean cambiarEstadoPago(ObjectId id, String nuevoEstadoPago) throws Exception;
}
