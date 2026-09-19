# Modelo relacional

## 1. Introducción

El presente modelo relacional surge de la transformación del Diagrama Entidad-Relación del Sistema de Gestión Comercial y Control de Inventario para Joyería.

Las entidades del DER se transformaron en relaciones, sus atributos identificadores se convirtieron en claves primarias y las relaciones 1:N se implementaron mediante claves foráneas.

La relación N:M entre ORDEN y PRODUCTO se transformó en la relación intermedia DETALLE_ORDEN.

### Referencias utilizadas

- **PK:** clave primaria.
- **FK:** clave foránea.
- **UK:** clave única.
- **NULL:** atributo opcional.
- **NOT NULL:** atributo obligatorio.

---

## 2. Relaciones resultantes

### ROL

ROL(
    id_rol PK,
    nombre_rol UK NOT NULL
)

La relación ROL almacena los diferentes roles que pueden asignarse a los usuarios, como Cliente o Administrador.

---

### USUARIO

USUARIO(
    id_usuario PK,
    nombre NOT NULL,
    apellido NOT NULL,
    email UK NOT NULL,
    contrasenia NOT NULL,
    id_rol FK NOT NULL
)

**Clave foránea:**

- id_rol referencia a ROL(id_rol).

Cada usuario debe tener asignado un único rol. Un rol puede estar asignado a varios usuarios.

El email se define como único para cumplir con la regla RN.01, que impide registrar dos cuentas con la misma dirección de correo electrónico.

---

### CATEGORIA

CATEGORIA(
    id_categoria PK,
    nombre_categoria UK NOT NULL
)

La relación CATEGORIA almacena las categorías utilizadas para clasificar los productos, por ejemplo: anillos, aretes, pulseras y collares.

---

### GENERO

GENERO(
    id_genero PK,
    nombre_genero UK NOT NULL
)

La relación GENERO almacena el género o público al que pertenece cada joya.

---

### PRODUCTO

PRODUCTO(
    id_producto PK,
    nombre NOT NULL,
    descripcion,
    precio_actual NOT NULL,
    stock_actual NOT NULL,
    stock_minimo NOT NULL,
    activo NOT NULL,
    id_categoria FK NOT NULL,
    id_genero FK NOT NULL
)

**Claves foráneas:**

- id_categoria referencia a CATEGORIA(id_categoria).
- id_genero referencia a GENERO(id_genero).

Cada producto pertenece a una única categoría y a un único género. Una categoría o género puede estar relacionado con varios productos.

El atributo precio_actual representa el precio vigente del producto en el catálogo.

Los atributos stock_actual y stock_minimo permiten controlar la disponibilidad y determinar cuándo un producto se encuentra sin stock o con poco stock.

El atributo activo permite aplicar una baja lógica sin eliminar productos que formen parte del historial de ventas.

---

### METODO_PAGO

METODO_PAGO(
    id_metodo_pago PK,
    nombre_metodo UK NOT NULL
)

La relación METODO_PAGO almacena los medios de pago aceptados por el sistema, como transferencia, tarjeta de débito, tarjeta de crédito y efectivo.

---

### ORDEN

ORDEN(
    id_orden PK,
    fecha_hora NOT NULL,
    estado NOT NULL,
    id_usuario FK NOT NULL,
    id_metodo_pago FK NOT NULL
)

**Claves foráneas:**

- id_usuario referencia a USUARIO(id_usuario).
- id_metodo_pago referencia a METODO_PAGO(id_metodo_pago).

Cada orden es realizada por un único usuario y debe registrar obligatoriamente un método de pago.

El atributo estado permite indicar la situación actual de la orden, por ejemplo: Pendiente, Pagado o Cancelado.

El total no se almacena físicamente en esta relación porque puede calcularse sumando los importes de sus detalles.

---

### DETALLE_ORDEN

DETALLE_ORDEN(
    id_orden PK, FK,
    id_producto PK, FK,
    cantidad NOT NULL,
    precio_unitario NOT NULL
)

**Clave primaria compuesta:**

- PK(id_orden, id_producto).

**Claves foráneas:**

- id_orden referencia a ORDEN(id_orden).
- id_producto referencia a PRODUCTO(id_producto).

DETALLE_ORDEN surge de la transformación de la relación N:M CONTIENE existente entre ORDEN y PRODUCTO.

La clave primaria compuesta impide que un mismo producto aparezca más de una vez dentro de la misma orden. Cuando se adquieren varias unidades, esa información se registra mediante el atributo cantidad.

El atributo precio_unitario conserva el precio que tenía el producto en el momento de la operación. Los cambios posteriores en precio_actual de PRODUCTO no modifican el historial de ventas.

El subtotal no se almacena porque puede calcularse mediante:

subtotal = cantidad × precio_unitario

---

### CONSULTA

CONSULTA(
    id_consulta PK,
    nombre_remitente NOT NULL,
    email_remitente NOT NULL,
    fecha_hora NOT NULL,
    estado NOT NULL,
    mensaje NOT NULL,
    id_usuario FK NULL
)

**Clave foránea:**

- id_usuario referencia a USUARIO(id_usuario).

La clave foránea id_usuario es opcional porque la consulta puede ser enviada por un usuario registrado o por un visitante.

Cuando la consulta corresponde a un visitante, id_usuario puede tener un valor nulo. Los datos del remitente se conservan mediante nombre_remitente y email_remitente.

---

## 3. Transformación de las relaciones

### Relación entre ROL y USUARIO

La relación 1:N SE_ASIGNA se implementó agregando id_rol como clave foránea en USUARIO.

ROL 1 ─── N USUARIO

---

### Relación entre USUARIO y ORDEN

La relación 1:N REALIZA se implementó agregando id_usuario como clave foránea en ORDEN.

USUARIO 1 ─── N ORDEN

---

### Relación entre METODO_PAGO y ORDEN

La relación 1:N UTILIZA se implementó agregando id_metodo_pago como clave foránea en ORDEN.

METODO_PAGO 1 ─── N ORDEN

---

### Relación entre CATEGORIA y PRODUCTO

La relación 1:N CLASIFICA se implementó agregando id_categoria como clave foránea en PRODUCTO.

CATEGORIA 1 ─── N PRODUCTO

---

### Relación entre GENERO y PRODUCTO

La relación 1:N PERTENECE se implementó agregando id_genero como clave foránea en PRODUCTO.

GENERO 1 ─── N PRODUCTO

---

### Relación entre ORDEN y PRODUCTO

La relación N:M CONTIENE se transformó en DETALLE_ORDEN.

ORDEN N ─── M PRODUCTO

DETALLE_ORDEN incorpora las claves de ORDEN y PRODUCTO, además de los atributos propios de la relación:

- cantidad;
- precio_unitario.

---

### Relación entre USUARIO y CONSULTA

La relación ENVIA se implementó agregando id_usuario como clave foránea opcional en CONSULTA.

USUARIO 1 ─── N CONSULTA

La clave foránea admite valores nulos porque las consultas también pueden ser enviadas por visitantes.

---

## 4. Resumen de claves

| Relación | Clave primaria | Claves foráneas |
|---|---|---|
| ROL | id_rol | — |
| USUARIO | id_usuario | id_rol |
| CATEGORIA | id_categoria | — |
| GENERO | id_genero | — |
| PRODUCTO | id_producto | id_categoria, id_genero |
| METODO_PAGO | id_metodo_pago | — |
| ORDEN | id_orden | id_usuario, id_metodo_pago |
| DETALLE_ORDEN | id_orden, id_producto | id_orden, id_producto |
| CONSULTA | id_consulta | id_usuario |

---

## 5. Esquema relacional completo

ROL(
    id_rol PK,
    nombre_rol UK NOT NULL
)

USUARIO(
    id_usuario PK,
    nombre NOT NULL,
    apellido NOT NULL,
    email UK NOT NULL,
    contrasenia NOT NULL,
    id_rol FK NOT NULL
)

CATEGORIA(
    id_categoria PK,
    nombre_categoria UK NOT NULL
)

GENERO(
    id_genero PK,
    nombre_genero UK NOT NULL
)

PRODUCTO(
    id_producto PK,
    nombre NOT NULL,
    descripcion,
    precio_actual NOT NULL,
    stock_actual NOT NULL,
    stock_minimo NOT NULL,
    activo NOT NULL,
    id_categoria FK NOT NULL,
    id_genero FK NOT NULL
)

METODO_PAGO(
    id_metodo_pago PK,
    nombre_metodo UK NOT NULL
)

ORDEN(
    id_orden PK,
    fecha_hora NOT NULL,
    estado NOT NULL,
    id_usuario FK NOT NULL,
    id_metodo_pago FK NOT NULL
)

DETALLE_ORDEN(
    id_orden PK, FK,
    id_producto PK, FK,
    cantidad NOT NULL,
    precio_unitario NOT NULL
)

CONSULTA(
    id_consulta PK,
    nombre_remitente NOT NULL,
    email_remitente NOT NULL,
    fecha_hora NOT NULL,
    estado NOT NULL,
    mensaje NOT NULL,
    id_usuario FK NULL
)

---

## 6. Conclusión

La transformación del DER al modelo relacional permitió representar las entidades mediante relaciones y las asociaciones 1:N mediante claves foráneas.

La relación N:M entre ORDEN y PRODUCTO se resolvió mediante DETALLE_ORDEN, que conserva la cantidad y el precio unitario histórico de cada producto vendido.

El modelo resultante mantiene la integridad referencial, evita redundancias y permite implementar las reglas de negocio definidas en la Etapa 1.