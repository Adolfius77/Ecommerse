/**
 * SCRIPTS DE INICIALIZACIÓN PARA MONGODB - ECOMMERCE
 * Copiar y ejecutar estos comandos en MongoDB Compass o mongo shell
 */

// ============================================================
// 1. CREAR COLECCIÓN DE USUARIOS
// ============================================================
db.createCollection("usuario");

// Insertar usuarios de prueba
db.usuario.insertMany([
    {
        "_id": ObjectId("507f1f77bcf86cd799439011"),
        "nombre": "Juan",
        "apellido": "Pérez",
        "correo": "juan@example.com",
        "contrasena": "password123",
        "telefono": "5551234567",
        "direccion": "Calle Principal 123, Ciudad",
        "rol": "cliente",
        "activo": true
    },
    {
        "_id": ObjectId("507f1f77bcf86cd799439012"),
        "nombre": "María",
        "apellido": "García",
        "correo": "maria@example.com",
        "contrasena": "password456",
        "telefono": "5559876543",
        "direccion": "Avenida Secundaria 456, Ciudad",
        "rol": "cliente",
        "activo": true
    },
    {
        "_id": ObjectId("507f1f77bcf86cd799439013"),
        "nombre": "Admin",
        "apellido": "Sistema",
        "correo": "admin@example.com",
        "contrasena": "admin123",
        "telefono": "5555555555",
        "direccion": "Oficina Admin",
        "rol": "admin",
        "activo": true
    }
]);

// ============================================================
// 2. CREAR COLECCIÓN DE CATEGORÍAS
// ============================================================
db.createCollection("categoria");

db.categoria.insertMany([
    {
        "_id": ObjectId("607f1f77bcf86cd799439001"),
        "nombre": "Tecnología",
        "descripcion": "Productos tecnológicos y electrónicos"
    },
    {
        "_id": ObjectId("607f1f77bcf86cd799439002"),
        "nombre": "Hogar",
        "descripcion": "Artículos para el hogar"
    },
    {
        "_id": ObjectId("607f1f77bcf86cd799439003"),
        "nombre": "Accesorios",
        "descripcion": "Accesorios varios"
    },
    {
        "_id": ObjectId("607f1f77bcf86cd799439004"),
        "nombre": "Moda",
        "descripcion": "Ropa y accesorios de moda"
    }
]);

// ============================================================
// 3. CREAR COLECCIÓN DE PRODUCTOS
// ============================================================
db.createCollection("producto");

db.producto.insertMany([
    {
        "_id": ObjectId("708f1f77bcf86cd799439001"),
        "nombre": "Laptop Dell XPS 13",
        "precio": 999.99,
        "descripcion": "Laptop ultradelgada de 13 pulgadas con procesador Intel i7",
        "imagenProducto": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400&h=400&fit=crop",
        "stock": 15,
        "categoria": "Tecnología",
        "listaResenas": []
    },
    {
        "_id": ObjectId("708f1f77bcf86cd799439002"),
        "nombre": "iPhone 14 Pro",
        "precio": 1199.99,
        "descripcion": "Smartphone Apple con cámara de 48MP y procesador A16",
        "imagenProducto": "https://images.unsplash.com/photo-1592286927505-1def25115558?w=400&h=400&fit=crop",
        "stock": 8,
        "categoria": "Tecnología",
        "listaResenas": []
    },
    {
        "_id": ObjectId("708f1f77bcf86cd799439003"),
        "nombre": "Lámpara de Escritorio LED",
        "precio": 49.99,
        "descripcion": "Lámpara LED ajustable con tres modos de luz",
        "imagenProducto": "https://images.unsplash.com/photo-1565636192335-14a0d2f6662d?w=400&h=400&fit=crop",
        "stock": 45,
        "categoria": "Hogar",
        "listaResenas": []
    },
    {
        "_id": ObjectId("708f1f77bcf86cd799439004"),
        "nombre": "Auriculares Sony WH-1000XM4",
        "precio": 349.99,
        "descripcion": "Auriculares con cancelación de ruido de clase mundial",
        "imagenProducto": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=400&fit=crop",
        "stock": 22,
        "categoria": "Accesorios",
        "listaResenas": []
    },
    {
        "_id": ObjectId("708f1f77bcf86cd799439005"),
        "nombre": "Camiseta Básica Unisex",
        "precio": 19.99,
        "descripcion": "Camiseta de algodón 100% de alta calidad",
        "imagenProducto": "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400&h=400&fit=crop",
        "stock": 120,
        "categoria": "Moda",
        "listaResenas": []
    },
    {
        "_id": ObjectId("708f1f77bcf86cd799439006"),
        "nombre": "Monitor Samsung 4K",
        "precio": 449.99,
        "descripcion": "Monitor 4K de 32 pulgadas para profesionales",
        "imagenProducto": "https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=400&h=400&fit=crop",
        "stock": 12,
        "categoria": "Tecnología",
        "listaResenas": []
    },
    {
        "_id": ObjectId("708f1f77bcf86cd799439007"),
        "nombre": "Sofá Gris Moderno",
        "precio": 599.99,
        "descripcion": "Sofá cómodo de 3 asientos con tela resistente",
        "imagenProducto": "https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&h=400&fit=crop",
        "stock": 5,
        "categoria": "Hogar",
        "listaResenas": []
    },
    {
        "_id": ObjectId("708f1f77bcf86cd799439008"),
        "nombre": "Teclado Mecánico RGB",
        "precio": 129.99,
        "descripcion": "Teclado gaming con switches mecánicos y iluminación RGB",
        "imagenProducto": "https://images.unsplash.com/photo-1587829191301-41f3e3406beb?w=400&h=400&fit=crop",
        "stock": 35,
        "categoria": "Accesorios",
        "listaResenas": []
    }
]);

// ============================================================
// 4. CREAR COLECCIÓN DE PEDIDOS
// ============================================================
// Si ya ejecutaste un seed antiguo con estados en minúsculas, normaliza una vez en Compass:
// db.pedido.updateMany({ estado: "pendiente" }, { $set: { estado: "PENDIENTE" } })
// db.pedido.updateMany({ estado: "entregado" }, { $set: { estado: "ENTREGADO" } })
// db.pedido.updateMany({ estado: "enviado" }, { $set: { estado: "ENVIADO" } })
// db.pedido.updateMany({ estadoPago: "pagado" }, { $set: { estadoPago: "PAGADO" } })
db.createCollection("pedido");

db.pedido.insertMany([
    {
        "_id": ObjectId("809f1f77bcf86cd799439001"),
        "nombreCliente": "Juan Pérez",
        "fecha": new Date("2026-05-15"),
        "estado": "ENTREGADO",
        "idUsuario": ObjectId("507f1f77bcf86cd799439011"),
        "total": 1299.99,
        "estadoPago": "PAGADO",
        "productos": [
            {
                "idProducto": ObjectId("708f1f77bcf86cd799439001"),
                "nombre": "Laptop Dell XPS 13",
                "cantidad": 1,
                "precioUnitario": 999.99,
                "subtotal": 999.99
            },
            {
                "idProducto": ObjectId("708f1f77bcf86cd799439004"),
                "nombre": "Auriculares Sony WH-1000XM4",
                "cantidad": 1,
                "precioUnitario": 349.99,
                "subtotal": 349.99
            }
        ]
    },
    {
        "_id": ObjectId("809f1f77bcf86cd799439002"),
        "nombreCliente": "María García",
        "fecha": new Date("2026-05-16"),
        "estado": "PENDIENTE",
        "idUsuario": ObjectId("507f1f77bcf86cd799439012"),
        "total": 1199.99,
        "estadoPago": "PAGADO",
        "productos": [
            {
                "idProducto": ObjectId("708f1f77bcf86cd799439002"),
                "nombre": "iPhone 14 Pro",
                "cantidad": 1,
                "precioUnitario": 1199.99,
                "subtotal": 1199.99
            }
        ]
    }
]);

// ============================================================
// 5. CREAR COLECCIÓN DE RESEÑAS
// ============================================================
db.createCollection("resena");

db.resena.insertMany([
    {
        "_id": ObjectId("909f1f77bcf86cd799439001"),
        "idProducto": ObjectId("708f1f77bcf86cd799439001"),
        "idUsuario": ObjectId("507f1f77bcf86cd799439011"),
        "nombreUsuario": "Juan Pérez",
        "calificacion": 5,
        "comentario": "Excelente laptop, muy rápida y ligera",
        "fecha": new Date("2026-05-15"),
        "estado": "aprobada"
    },
    {
        "_id": ObjectId("909f1f77bcf86cd799439002"),
        "idProducto": ObjectId("708f1f77bcf86cd799439004"),
        "idUsuario": ObjectId("507f1f77bcf86cd799439011"),
        "nombreUsuario": "Juan Pérez",
        "calificacion": 4,
        "comentario": "Auriculares de muy buena calidad, cancelación excelente",
        "fecha": new Date("2026-05-14"),
        "estado": "aprobada"
    }
]);

// ============================================================
// 6. CREAR ÍNDICES PARA OPTIMIZACIÓN
// ============================================================

// Índices para usuario
db.usuario.createIndex({ "correo": 1 });
db.usuario.createIndex({ "rol": 1 });
db.usuario.createIndex({ "activo": 1 });

// Índices para producto
db.producto.createIndex({ "categoria": 1 });
db.producto.createIndex({ "stock": 1 });
db.producto.createIndex({ "nombre": "text" });

// Índices para pedido
db.pedido.createIndex({ "idUsuario": 1 });
db.pedido.createIndex({ "estado": 1 });
db.pedido.createIndex({ "fecha": -1 });

// Índices para reseña
db.resena.createIndex({ "idProducto": 1 });
db.resena.createIndex({ "idUsuario": 1 });
db.resena.createIndex({ "estado": 1 });

// ============================================================
// VERIFICACIÓN - Ejecuta estos comandos para verificar
// ============================================================

// Ver todas las colecciones
// show collections

// Contar documentos en cada colección
// db.usuario.countDocuments()
// db.categoria.countDocuments()
// db.producto.countDocuments()
// db.pedido.countDocuments()
// db.resena.countDocuments()

// Ver documentos de ejemplo
// db.usuario.findOne()
// db.producto.findOne()
// db.pedido.findOne()
