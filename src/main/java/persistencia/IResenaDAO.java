/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package persistencia;

import java.util.List;
import java.util.Optional;
import model.reseña;
import org.bson.types.ObjectId;

/**
 * Persistencia de reseñas (colección Mongo: resena).
 */
public interface IResenaDAO {

    void crear(reseña r);

    List<reseña> listarTodas();

    List<reseña> listarPorProducto(ObjectId productoId);

    Optional<reseña> obtenerPorId(ObjectId _id);

    boolean eliminarPorId(ObjectId _id);
    
    boolean actualizar(reseña resena);
}
