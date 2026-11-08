# Pruebas y Validaciones (Roles y Usuarios)

## Datos de prueba

Se cargaron:

- 4 registros en `Rol`.
- 10 registros en `Usuario`.

Los usuarios de prueba incluyen personal de la joyería y clientes
registrados.

## Validaciones realizadas

Los scripts DDL y DML fueron ejecutados en Microsoft SQL Server sobre
la base de datos `BD_JoyeriaAlba`.

Se verificó:

- La creación de las tablas `Rol` y `Usuario`.
- La carga de los registros de prueba.
- La relación entre ambas tablas.
- La unicidad del DNI, nombre de usuario y email.
- La restricción correspondiente al estado de los usuarios.
- La integridad referencial entre `Usuario` y `Rol`.

---

# Pruebas y Validaciones (Productos, Categorías y Géneros)

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
