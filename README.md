# E-Commerce Web
Integrantes:
<h3>Jose Adolfo Ortega Ruiz : 252882</h3>
<br>
<h3>Angel Gabriel Beltran Duarto: 244865</h3>
<br>

Aplicación web de comercio electrónico desarrollada para la materia **Aplicaciones Web – Unidad 4**. Permite a los clientes navegar un catálogo, usar carrito, realizar pedidos y dejar reseñas; los administradores gestionan productos, categorías, usuarios, pedidos y moderación de reseñas.

## Tecnologías

| Capa | Tecnología |
|------|------------|
| Backend | Java 11, Jakarta EE 10 (Servlets, JSP, JSTL) |
| Base de datos | MongoDB |
| Servidor | Apache Tomcat 10.1+ |
| Build | Maven |
| Seguridad | BCrypt (contraseñas), JWT (sesión) |

## Requisitos previos

- **JDK 21** o superior  
- **Apache Maven 3.6+**  
- **MongoDB** en ejecución (`mongodb://localhost:27017/`)  
- **Apache Tomcat 10.1+** (compatible con Jakarta EE 10)

## Configuración de MongoDB

1. Inicia el servicio de MongoDB en tu equipo.
2. Abre **MongoDB Compass** o la shell `mongosh`.
3. Crea/selecciona la base de datos **`Ecommerce-web`** (nombre usado por la aplicación).
4. Ejecuta el script de datos iniciales del proyecto:

   ```
   Ecommerce_web/scripts_mongodb.js
   ```

   Copia y pega el contenido en Compass o ejecútalo con:

   ```bash
   mongosh < scripts_mongodb.js
   ```

   > Si ya ejecutaste una versión antigua del seed y los pedidos no cargan en el panel admin, normaliza los estados con los `updateMany` documentados al inicio de la sección de pedidos en ese mismo archivo.

Al **primer arranque** de la aplicación, si no existe ningún usuario con rol `ADMIN`, se crea automáticamente uno por defecto (ver credenciales abajo).

## Cómo compilar el proyecto

Desde la carpeta `Ecommerce_web`:

```bash
mvn clean package
```

El archivo WAR se genera en:

```
target/Ecommerse-Web-1.0-SNAPSHOT.war
```

## Cómo ejecutar el proyecto

### Opción A: NetBeans (recomendado en el equipo del curso)

1. Abre el proyecto `Ecommerce_web` en NetBeans.
2. Configura **Apache Tomcat 10.1** como servidor de aplicaciones.
3. Clic derecho en el proyecto → **Run** / **Deploy**.
4. Abre el navegador en la URL que muestre NetBeans (por ejemplo `http://localhost:8080/Ecommerse-Web-1.0-SNAPSHOT/`).

### Opción B: Tomcat manual

1. Copia `target/Ecommerse-Web-1.0-SNAPSHOT.war` a la carpeta `webapps` de Tomcat.
2. Inicia Tomcat.
3. Accede a `http://localhost:8080/Ecommerse-Web-1.0-SNAPSHOT/`.

### Página de inicio

- `index.jsp` — portada del sitio  
- `loginView.jsp` — inicio de sesión  
- Tras login como **cliente** → catálogo (`/catalogo`)  
- Tras login como **admin** → panel (`/admin/dashboard`)

## Credenciales de prueba

| Rol | Correo | Contraseña | Notas |
|-----|--------|------------|--------|
| **Administrador** | `admin@tienda.com` | `admin123` | Se crea solo la primera vez si no hay admin en la BD (`InitAdminListener`). |
| **Cliente** | `angel@gmail.com` | `1234` | Usuario de prueba del equipo; debe existir en la colección `usuario` (registro manual o datos del curso). |

También puedes **registrar un cliente nuevo** desde `registroView.jsp` (`/registro`).

## Rutas principales

| Ruta | Descripción |
|------|-------------|
| `/catalogo` | Catálogo de productos |
| `/DetalleProducto?id=...` | Detalle de un producto |
| `/carrito` | Carrito de compras |
| `/checkout` | Proceso de pago |
| `/confirmarPedido` | Confirmación del pedido |
| `/misPedidos` | Historial del cliente |
| `/misPedidos?pedidoId=...` | Detalle de un pedido |
| `/Perfil` | Perfil del usuario |
| `/admin/dashboard` | Panel del administrador |
| `/admin/gestionProductos` | Inventario |
| `/admin/gestionCategorias` | Categorías |
| `/admin/gestionUsuarios` | Usuarios |
| `/admin/gestionPedidos` | Pedidos y pagos |
| `/admin/moderacionResenas` | Moderación de reseñas |

## Estructura del proyecto

```
Ecommerce_web/
├── src/main/java/
│   ├── Config/          # Conexión MongoDB
│   ├── controllers/     # Servlets
│   ├── negocio/         # Lógica de negocio (BO)
│   ├── persistencia/    # Acceso a datos (DAO)
│   ├── model/           # Entidades
│   ├── Filtros/         # Filtros de autenticación
│   ├── listeners/       # Inicialización (admin por defecto)
│   └── util/            # JWT, email, contraseñas
├── src/main/webapp/     # JSP, CSS, recursos estáticos
├── scripts_mongodb.js   # Datos de prueba para MongoDB
└── pom.xml
```

## Equipo

Proyecto académico – E-Commerce Web (Unidad 4).
