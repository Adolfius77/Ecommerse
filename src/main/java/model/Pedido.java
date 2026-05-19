/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.util.List;
import org.bson.types.ObjectId;

/**
 *
 * @author USER
 */
public class Pedido {
    ObjectId _id;
    private String nombreCliente;
    private Date fecha;
    private estadoPedido estado;
    private List<detallePedido> productos;
    private ObjectId idUsuario;
    private Double total;
    private String estadoPago;
    private String metodoPago;
    private String direccionEnvio;

    public Pedido() {
    }

    public Pedido(ObjectId _id, String nombreCliente, Date fecha, estadoPedido estado, List<detallePedido> productos) {
        this._id = _id;
        this.nombreCliente = nombreCliente;
        this.fecha = fecha;
        this.estado = estado;
        this.productos = productos;
    }

    public ObjectId getId() {
        return _id;
    }

    public void setId(ObjectId _id) {
        this._id = _id;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public estadoPedido getEstado() {
        return estado;
    }

    public void setEstado(estadoPedido estado) {
        this.estado = estado;
    }

    public List<detallePedido> getProductos() {
        return productos;
    }

    public void setProductos(List<detallePedido> productos) {
        this.productos = productos;
    }

    public ObjectId getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(ObjectId idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public String getEstadoPago() {
        return estadoPago;
    }

    public void setEstadoPago(String estadoPago) {
        this.estadoPago = estadoPago;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public String getDireccionEnvio() {
        return direccionEnvio;
    }

    public void setDireccionEnvio(String direccionEnvio) {
        this.direccionEnvio = direccionEnvio;
    }

}
