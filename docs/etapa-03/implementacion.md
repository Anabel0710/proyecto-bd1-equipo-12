# Implementación del módulo de roles y usuarios

## Responsable

Gonzalez Rocío Anabel.

## Tablas implementadas

Durante la Etapa III se implementaron las tablas `Rol` y `Usuario`
en Microsoft SQL Server.

La tabla `Rol` almacena los roles disponibles dentro del sistema.

La tabla `Usuario` registra los datos de los clientes y del personal
de la joyería. Cada usuario se relaciona con un único rol mediante
el atributo `IdRol`.

La tabla `Consulta`, incluida en una versión anterior del modelo, fue
eliminada luego de la revisión grupal del diseño.

## Roles definidos

Los roles establecidos para el sistema son:

- Administrador.
- Vendedor.
- Encargado de inventario.
- Cliente.

La tabla `Rol` contiene cuatro registros porque representa un catálogo
reducido de valores definidos por las necesidades reales del negocio.

## Archivos relacionados

- `sql/ddl/01_roles_usuarios.sql`
- `sql/dml/01_datos_roles_usuarios.sql`

---

# Implementación del módulo de productos, categorías y géneros

## Responsable

Rodriguez Mercedes Antonella.

## Tablas implementadas

Durante la Etapa III se implementaron las tablas Genero, Categoria y
Producto en Microsoft SQL Server.

La tabla Genero almacena los géneros utilizados para clasificar los productos.

La tabla Categoria almacena las categorías de joyas disponibles, como
anillos, collares, pulseras, relojes y aros.

La tabla Producto registra las joyas comercializadas. Contiene información
sobre el nombre, descripción, precio de venta, precio de compra, stock actual,
stock mínimo y estado del producto.

Además, Producto contiene claves foráneas hacia Genero y Categoria.
