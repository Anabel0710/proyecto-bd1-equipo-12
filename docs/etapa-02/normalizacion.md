# Proceso de normalización

## 1. Introducción

El proceso de normalización se aplicó al Sistema de Gestión Comercial y Control de Inventario para Joyería con el propósito de reducir la redundancia, evitar inconsistencias y asegurar que cada dato se almacene en la relación que le corresponde.

A partir de los requisitos definidos en la Etapa 1, se identificaron los datos relacionados con usuarios, productos, categorías, géneros, órdenes, métodos de pago y consultas.

El modelo fue analizado progresivamente hasta alcanzar la Tercera Forma Normal (3FN).

---

## 2. Estructura inicial no normalizada

Inicialmente, toda la información de una operación comercial podría haberse almacenado en una única estructura:

VENTA_GENERAL(
    id_orden,
    fecha_hora,
    estado_orden,
    nombre_usuario,
    apellido_usuario,
    email_usuario,
    rol_usuario,
    metodo_pago,
    productos,
    cantidades,
    precios_unitarios,
    subtotales,
    total
)

Esta estructura presenta los siguientes problemas:

- Una orden puede contener varios productos.
- Los atributos productos, cantidades, precios y subtotales tendrían múltiples valores.
- Los datos del usuario se repetirían en cada orden.
- Los datos de los productos se repetirían en todas las ventas.
- Los nombres de categorías, géneros, roles y métodos de pago aparecerían repetidos.
- Una modificación podría producir inconsistencias en diferentes registros.
- No sería posible conservar adecuadamente el precio histórico de cada producto vendido.

Por estos motivos, la estructura inicial no cumple con la Primera Forma Normal.

---

## 3. Primera Forma Normal — 1FN

Una relación se encuentra en Primera Forma Normal cuando:

- Cada atributo contiene un único valor.
- Los valores son atómicos.
- No existen listas ni grupos repetitivos.
- Cada registro puede identificarse de manera única.

En la estructura inicial, una orden podía contener varios productos dentro del mismo registro. Para eliminar este grupo repetitivo, se separaron los datos generales de la orden de los productos incluidos en ella.

Se obtuvieron las siguientes relaciones iniciales:

ORDEN(
    id_orden,
    fecha_hora,
    estado,
    id_usuario,
    id_metodo_pago
)

DETALLE_ORDEN(
    id_orden,
    id_producto,
    cantidad,
    precio_unitario
)

PRODUCTO(
    id_producto,
    nombre,
    descripcion,
    precio_actual,
    stock_actual,
    stock_minimo,
    activo,
    id_categoria,
    id_genero
)

USUARIO(
    id_usuario,
    nombre,
    apellido,
    email,
    contrasenia,
    id_rol
)

Cada fila de DETALLE_ORDEN representa un único producto incluido en una orden determinada.

La relación DETALLE_ORDEN utiliza como clave primaria la combinación:

(id_orden, id_producto)

Esta clave compuesta impide que el mismo producto aparezca más de una vez dentro de la misma orden. Si se adquieren varias unidades del producto, se registra el valor correspondiente en el atributo cantidad.

De esta manera:

- Cada atributo contiene un solo valor.
- Se eliminaron las listas de productos.
- Cada fila puede identificarse de manera única.
- El modelo cumple con la Primera Forma Normal.

---

## 4. Segunda Forma Normal — 2FN

Una relación se encuentra en Segunda Forma Normal cuando:

- Cumple con la Primera Forma Normal.
- Todos los atributos que no forman parte de la clave dependen de la clave primaria completa.
- No existen dependencias funcionales parciales respecto de una clave compuesta.

La relación que requiere especial análisis es DETALLE_ORDEN, porque posee una clave primaria compuesta:

DETALLE_ORDEN(
    id_orden,
    id_producto,
    cantidad,
    precio_unitario
)

Su clave primaria es:

(id_orden, id_producto)

Las dependencias funcionales son:

(id_orden, id_producto) → cantidad

(id_orden, id_producto) → precio_unitario

El atributo cantidad depende tanto de la orden como del producto, porque representa la cantidad de un producto específico comprada en una orden determinada.

El atributo precio_unitario también depende de la combinación completa, porque representa el precio histórico aplicado a ese producto en esa operación particular.

Los atributos propios del producto, como nombre, descripción, precio actual, stock, categoría y género, no se almacenan en DETALLE_ORDEN, porque dependen únicamente de id_producto. Estos atributos se almacenan en PRODUCTO.

De igual manera, la fecha, el estado, el usuario y el método de pago dependen únicamente de id_orden, por lo que se almacenan en ORDEN.

Por lo tanto, no existen atributos no clave que dependan solamente de una parte de la clave compuesta y el modelo cumple con la Segunda Forma Normal.

---

## 5. Tercera Forma Normal — 3FN

Una relación se encuentra en Tercera Forma Normal cuando:

- Cumple con la Segunda Forma Normal.
- Los atributos no clave dependen directamente de la clave primaria.
- No existen dependencias transitivas entre atributos no clave.

Durante el análisis se identificaron datos que no debían almacenarse directamente en USUARIO o PRODUCTO.

### 5.1. Normalización de roles

Si se almacenara el nombre del rol directamente en USUARIO, se produciría la siguiente dependencia:

id_usuario → id_rol → nombre_rol

El nombre del rol depende de id_rol y no directamente de id_usuario. Para eliminar esta dependencia transitiva se creó la relación ROL:

ROL(
    id_rol,
    nombre_rol
)

USUARIO conserva solamente id_rol como clave foránea.

### 5.2. Normalización de categorías

Si se almacenara el nombre de la categoría dentro de PRODUCTO, se produciría la dependencia:

id_producto → id_categoria → nombre_categoria

Para eliminarla, se creó la relación CATEGORIA:

CATEGORIA(
    id_categoria,
    nombre_categoria
)

PRODUCTO conserva solamente id_categoria como clave foránea.

### 5.3. Normalización de géneros

El nombre del género depende de id_genero y no directamente de id_producto:

id_producto → id_genero → nombre_genero

Por lo tanto, se creó la relación GENERO:

GENERO(
    id_genero,
    nombre_genero
)

PRODUCTO conserva id_genero como clave foránea.

### 5.4. Normalización de métodos de pago

El nombre del método de pago no debe repetirse en cada orden:

id_orden → id_metodo_pago → nombre_metodo

Para eliminar esta dependencia transitiva, se creó la relación METODO_PAGO:

METODO_PAGO(
    id_metodo_pago,
    nombre_metodo
)

ORDEN conserva id_metodo_pago como clave foránea.

### 5.5. Consultas

Las consultas se almacenan en una relación independiente porque sus datos dependen únicamente de id_consulta.

CONSULTA(
    id_consulta,
    nombre_remitente,
    email_remitente,
    fecha_hora,
    estado,
    mensaje,
    id_usuario
)

La clave foránea id_usuario puede admitir un valor nulo, debido a que una consulta también puede ser enviada por un visitante no registrado.

### 5.6. Atributos calculados

El subtotal de cada detalle no se almacena como un dato independiente, porque puede calcularse mediante:

subtotal = cantidad × precio_unitario

El total de una orden puede calcularse sumando los subtotales de todos sus detalles:

total_orden = SUM(cantidad × precio_unitario)

En el DER, subtotal y total pueden representarse como atributos derivados. En el modelo relacional no es necesario almacenarlos, evitando redundancia y posibles inconsistencias.

---

## 6. Modelo resultante en Tercera Forma Normal

Luego de aplicar las tres formas normales, el modelo queda compuesto por las siguientes relaciones:

ROL(
    id_rol PK,
    nombre_rol
)

USUARIO(
    id_usuario PK,
    nombre,
    apellido,
    email,
    contrasenia,
    id_rol FK
)

CATEGORIA(
    id_categoria PK,
    nombre_categoria
)

GENERO(
    id_genero PK,
    nombre_genero
)

PRODUCTO(
    id_producto PK,
    nombre,
    descripcion,
    precio_actual,
    stock_actual,
    stock_minimo,
    activo,
    id_categoria FK,
    id_genero FK
)

METODO_PAGO(
    id_metodo_pago PK,
    nombre_metodo
)

ORDEN(
    id_orden PK,
    fecha_hora,
    estado,
    id_usuario FK,
    id_metodo_pago FK
)

DETALLE_ORDEN(
    id_orden PK, FK,
    id_producto PK, FK,
    cantidad,
    precio_unitario
)

CONSULTA(
    id_consulta PK,
    nombre_remitente,
    email_remitente,
    fecha_hora,
    estado,
    mensaje,
    id_usuario FK
)

---

## 7. Conclusión

El modelo alcanza la Tercera Forma Normal porque:

- Todos los atributos contienen valores atómicos.
- Se eliminaron los grupos repetitivos.
- Los atributos no clave dependen de la clave primaria completa.
- No existen dependencias funcionales parciales.
- No existen dependencias transitivas entre atributos no clave.
- Los datos de roles, categorías, géneros y métodos de pago se almacenan en relaciones independientes.
- Los productos de una orden se representan mediante DETALLE_ORDEN.
- El precio histórico se conserva en precio_unitario de DETALLE_ORDEN.
- Los valores calculables, como subtotal y total, no generan redundancia.

La normalización obtenida reduce la duplicación de información, protege el historial de ventas y facilita el mantenimiento de la integridad de la base de datos.