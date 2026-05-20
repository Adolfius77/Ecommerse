/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia.impl;

import Config.MongoClientProvider;
import com.mongodb.MongoException;
import com.mongodb.client.MongoCollection;
import static com.mongodb.client.model.Filters.eq;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import model.reseña;
import org.bson.types.ObjectId;
import persistencia.IResenaDAO;

/**
 * Colección Mongo sugerida: resena (ASCII).
 */
public class ResenaDAO implements IResenaDAO {

    private final MongoCollection<reseña> col;

    public ResenaDAO(MongoCollection<reseña> col) {
        this.col = MongoClientProvider.INSTANCE.getcCollection("resena", reseña.class);
    }

    @Override
    public void crear(reseña r) {
        try {
            if (r.getId() == null) {
                r.setId(new ObjectId());
            }
            col.insertOne(r);
        } catch (Exception e) {
            throw new MongoException("error al crear reseña: " + e.getMessage());
        }
    }

    @Override
    public List<reseña> listarTodas() {
        try {
            return col.find().into(new ArrayList<>());
        } catch (MongoException e) {
            throw new MongoException("error al listar reseñas: " + e.getMessage());
        }
    }

    @Override
    public List<reseña> listarPorProducto(ObjectId productoId) {
        try {
            return col.find(eq("productoId", productoId)).into(new ArrayList<>());
        } catch (MongoException e) {
            throw new MongoException("error al listar reseñas por producto: " + e.getMessage());
        }
    }

    @Override
    public Optional<reseña> obtenerPorId(ObjectId _id) {
        try {
            return Optional.ofNullable(col.find(eq("_id", _id)).first());
        } catch (MongoException e) {
            throw new MongoException("error al obtener reseña: " + e.getMessage());
        }
    }

    @Override
    public boolean eliminarPorId(ObjectId _id) {
        try {
            return col.deleteOne(eq("_id", _id)).getDeletedCount() > 0;
        } catch (MongoException e) {
            throw new MongoException("error al eliminar reseña: " + e.getMessage());
        }
    }
    
    @Override
    public boolean actualizar(reseña resena) {
        try {
            if (resena.getId() == null) {
                throw new IllegalArgumentException("El id de la reseña no puede ser nulo");
            }
            return col.replaceOne(eq("_id", resena.getId()), resena).getModifiedCount() > 0;
        } catch (MongoException e) {
            throw new MongoException("error al actualizar reseña: " + e.getMessage());
        }
    }
}
