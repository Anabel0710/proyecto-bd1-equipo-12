 Implementación del módulo de productos, categorías y géneros

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

## Restricciones implementadas

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

## Datos de prueba

Se cargaron:

- 10 registros en Genero.
- 10 registros en Categoria.
- 10 registros en Producto.

Los productos cargados representan diferentes tipos de joyas y contienen
precios, cantidades de stock, descripciones, estados, géneros y categorías
coherentes para las pruebas del sistema.

## Validaciones realizadas

Se ejecutaron consultas SELECT y COUNT para comprobar la carga de los datos.

Los resultados obtenidos fueron:

- Genero: 10 registros.
- Categoria: 10 registros.
- Producto: 10 registros.

También se verificó que las claves foráneas relacionaran correctamente cada
producto con su género y categoría, y que las restricciones impidieran cargar
precios o cantidades de stock inválidas