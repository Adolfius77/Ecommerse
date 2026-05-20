
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


