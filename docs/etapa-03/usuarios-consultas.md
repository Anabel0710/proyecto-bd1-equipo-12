# Implementación del módulo de usuarios y consultas

## Responsable

Gonzalez Rocío Anabel.

## Tablas implementadas

Durante la Etapa III se implementaron las tablas ROL, USUARIO y
CONSULTA en Microsoft SQL Server.

La tabla ROL almacena los roles disponibles en el sistema.

La tabla USUARIO registra los datos de los usuarios y contiene una
clave foránea hacia ROL. El email se definió como obligatorio y único.

La tabla CONSULTA almacena mensajes enviados por usuarios registrados
o visitantes. El atributo id_usuario admite valores nulos porque una
consulta puede no pertenecer a un usuario registrado.

## Restricciones implementadas

- Claves primarias mediante PRIMARY KEY.
- Identificadores automáticos mediante IDENTITY.
- Datos obligatorios mediante NOT NULL.
- Email de usuario único.
- Nombre de rol único.
- Clave foránea entre USUARIO y ROL.
- Clave foránea opcional entre CONSULTA y USUARIO.
- Estados de consulta controlados mediante CHECK.
- Valor predeterminado para el estado de una consulta.
- Protección contra la eliminación de roles utilizados.
- Conservación de consultas mediante ON DELETE SET NULL.

## Datos de prueba

Se cargaron:

- 8 registros en ROL.
- 10 registros en USUARIO.
- 10 registros en CONSULTA.

Las consultas incluyen registros asociados a usuarios y consultas
enviadas por visitantes.

## Validaciones realizadas

Se ejecutaron consultas SELECT y COUNT para verificar los datos.

Los resultados obtenidos fueron:

- ROL: 8 registros.
- USUARIO: 10 registros.
- CONSULTA: 10 registros.

También se comprobó que las relaciones entre las tablas y las
restricciones de integridad fueran creadas correctamente.