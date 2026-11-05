# Restricciones implementadas (Roles y Usuarios)

- Claves primarias mediante `PRIMARY KEY`.
- Identificadores automáticos mediante `IDENTITY`.
- Datos obligatorios mediante `NOT NULL`.
- Nombre de rol único.
- DNI de usuario único.
- Nombre de usuario único.
- Email de usuario obligatorio y único.
- Estados permitidos mediante `CHECK`.
- Estado `Activo` como valor predeterminado.
- Clave foránea entre `Usuario` y `Rol`.
- Protección de los roles utilizados mediante `ON DELETE NO ACTION`.
- Actualización referencial mediante `ON UPDATE CASCADE`.

---

# Restricciones implementadas (Productos, Categorías y Géneros)

- Claves primarias mediante PRIMARY KEY.
- Identificadores automáticos mediante IDENTITY.
- Datos obligatorios mediante NOT NULL.
- Nombre de género único.
- Nombre de categoría único.
- Precios mayores o iguales a cero.
- Precio de venta obligatorio y mayor que cero.
- Stock actual y stock mínimo no negativos.
- Estado limitado a ACTIVO o INACTIVO.
- Valor predeterminado para el stock actual.
- Valor predeterminado para el stock mínimo.
- Valor predeterminado para el estado del producto.
- Clave foránea entre Producto y Genero.
- Clave foránea entre Producto y Categoria.
- Protección contra la eliminación de categorías o géneros utilizados por productos.
