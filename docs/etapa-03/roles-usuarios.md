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

## Restricciones implementadas

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

## Roles definidos

Los roles establecidos para el sistema son:

- Administrador.
- Vendedor.
- Encargado de inventario.
- Cliente.

La tabla `Rol` contiene cuatro registros porque representa un catálogo
reducido de valores definidos por las necesidades reales del negocio.

## Datos de prueba

Se cargaron:

- 4 registros en `Rol`.
- 10 registros en `Usuario`.

Los usuarios de prueba incluyen personal de la joyería y clientes
registrados.

## Validaciones realizadas

Los scripts DDL y DML fueron ejecutados en Microsoft SQL Server sobre
la base de datos `BD_Joyeria_Practica`.

Se verificó:

- La creación de las tablas `Rol` y `Usuario`.
- La carga de los registros de prueba.
- La relación entre ambas tablas.
- La unicidad del DNI, nombre de usuario y email.
- La restricción correspondiente al estado de los usuarios.
- La integridad referencial entre `Usuario` y `Rol`.

## Archivos relacionados

- `sql/ddl/01_roles_usuarios.sql`
- `sql/dml/01_datos_roles_usuarios.sql`