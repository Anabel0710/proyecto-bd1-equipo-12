# Implementación del módulo de usuarios y consultas

## Responsable

Gonzalez Rocío Anabel.

## Tablas implementadas

Durante la Etapa III se implementaron las tablas Rol, Usuario y
Consulta en Microsoft SQL Server.

La tabla Rol almacena los roles disponibles en el sistema.

La tabla Usuario registra los datos de los usuarios y contiene una
clave foránea hacia Rol. El email se definió como obligatorio y único.

La tabla Consulta almacena mensajes enviados por usuarios registrados
o visitantes. El atributo IdUsuario admite valores nulos porque una
consulta puede no pertenecer a un usuario registrado.

## Restricciones implementadas

- Claves primarias mediante PRIMARY KEY.
- Identificadores automáticos mediante IDENTITY.
- Datos obligatorios mediante NOT NULL.
- Email de usuario único mediante UNIQUE.
- Nombre de rol único mediante UNIQUE.
- Clave foránea entre Usuario y Rol.
- Clave foránea opcional entre Consulta y Usuario.
- Estados de consulta controlados mediante CHECK.
- Valor predeterminado Pendiente para el estado de una consulta.
- Protección contra la eliminación de roles utilizados mediante ON DELATE NO ACTION.
- Conservación de consultas mediante ON DELETE SET NULL cuando se elimina el usuario asociado.

## Datos de prueba

Se cargaron:

- 8 registros en Rol.
- 10 registros en Usuario.
- 10 registros en Consulta.

Las consultas incluyen registros asociados a usuarios y consultas
enviadas por visitantes.

## Validaciones realizadas

Los scripts DDL y DML fueron ejecutados en Microsoft SQL Server sobre la base de datos BD_Joyeria_Practica.

Se utilizaron consultas SELECT y COUNT para verificar la carga de los datos. Los resultados obtenidos fueron:

Rol: 8 registros.

Usuario: 10 registros.

Consulta: 10 registros.

También se verificó la creación de las claves primarias, claves foráneas y demás restricciones de integridad definidas en las tablas.

Archivos relacionados

sql/ddl/01_usuarios_consultas.sql

sql/dml/01_datos_usuarios_consultas.sql