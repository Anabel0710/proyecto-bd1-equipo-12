## Etapa V: Permisos a Nivel de Usuarios y Roles de Base de Datos

## 1. ¿Qué es el manejo de permisos y roles y para qué lo usamos?


En una base de datos relacional, la seguridad por permisos y roles es el mecanismo que nos permite controlar exactamente qué usuarios pueden ingresar a la base de datos y qué acciones tienen permitidas realizar sobre la información. La regla principal es aplicar el principio de mínimo privilegio: cada usuario debe tener acceso únicamente a lo estrictamente necesario para cumplir con su trabajo.

En lugar de asignarle permisos de forma individual a cada empleado, SQL Server nos permite crear roles personalizados (que funcionan como grupos o perfiles de trabajo), asignar los permisos a esos roles y luego sumar a los usuarios según su función en el negocio.

## Conceptos clave que aplicamos:

Logins vs. Usuarios de Base de Datos: El Login es la cuenta de acceso general al servidor de SQL Server, mientras que el Usuario es la identidad que tiene esa cuenta dentro de una base de datos específica (BD_Joyeria_Practica).

Roles de DBMS: Son contenedores de permisos que simplifican la administración. Si ingresa un nuevo vendedor, solo basta con sumarlo al rol de vendedores sin tener que reconfigurar la base de datos desde cero.

Abstracción mediante Procedimientos Almacenados: Consiste en denegar el permiso directo de modificación sobre una tabla (INSERT, UPDATE, DELETE), pero otorgar permiso de ejecución (GRANT EXECUTE) sobre un procedimiento almacenado. De esta manera, el usuario puede guardar datos pero únicamente bajo el flujo estricto que valida el procedimiento.

## Objetivo del trabajo

El objetivo de esta etapa es implementar y verificar de forma práctica en SQL Server Express un esquema de seguridad basado en permisos directos y roles de base de datos. Se busca comprobar cómo el motor bloquea accesos indebidos a tablas sensibles de la joyería y cómo permite canalizar operaciones mediante procedimientos almacenados autorizados.

## 2. ¿Por qué nos sirve esto en el sistema de la joyería?

En Joyería ALBA, distintos empleados interactúan con el sistema con responsabilidades diferentes:

Administradores / Gerencia: Necesitan control total para configurar productos, precios y supervisar la operación.

Vendedores del mostrador: Necesitan consultar el catálogo de joyas y registrar ventas, pero no deberían poder modificar directamente el precio ni borrar productos mediante sentencias manuales.

Auditores / Contadores: Necesitan ver los reportes y registros de auditoría, pero no deben poder modificar ningún dato.

## ¿Qué ventajas nos da aplicarlo acá?

Protección del catálogo de precios: Evita que un usuario sin privilegios altere por error o intención el valor de una joya de oro o plata en la tabla Producto.

Control de la lógica de negocio: Garantiza que cualquier inserción de stock o venta pase obligatoriamente por los procedimientos almacenados que validan reglas (como controlar stock mínimo o guardar precios históricos).

Administración ágil: Si la joyería contrata personal nuevo para el área de ventas, simplemente se lo vincula al rol rol_lectura_catalogos o al perfil operativo correspondiente de forma inmediata.

## 3. Comandos que usamos en SQL Server

Para gestionar la seguridad y los permisos usamos las siguientes instrucciones de T-SQL:

CREATE LOGIN / DROP LOGIN: Crea o elimina las credenciales de acceso a nivel del servidor de base de datos.

CREATE USER / DROP USER: Vincula el inicio de sesión del servidor con un usuario interno de la base de datos BD_Joyeria_Practica.

CREATE ROLE: Define un nuevo rol personalizado para agrupar permisos según la función dentro del negocio.

GRANT: Otorga permisos específicos (SELECT, INSERT, EXECUTE) a un usuario o a un rol.

ALTER ROLE ... ADD MEMBER: Suma a un usuario como miembro de un rol del sistema (db_owner) o de un rol personalizado.

EXECUTE AS USER = '...' / REVERT: Nos permite "impersonar" o simular la sesión de un usuario determinado dentro del script de prueba para validar en vivo si SQL Server autoriza o rechaza una operación.

## 4. El caso práctico que elegimos

Para probar la seguridad en nuestro sistema definimos escenarios con perfiles diferenciados dentro del catálogo de joyas (Producto):

Prueba de Permisos a Nivel de Usuario:

usuario_admin: Cuenta con privilegios completos (db_owner).

usuario_lector: Solo tiene permiso de lectura (SELECT) sobre Producto y permiso de ejecución (EXECUTE) sobre el procedimiento sp_InsertarProducto.

Prueba de Permisos a Nivel de Roles:

Creamos el rol rol_lectura_catalogos con permiso SELECT sobre Producto.

usuario_con_rol: Usuario incluido dentro del rol.

usuario_sin_rol: Usuario sin asignación de rol ni permisos directos.

## 5. Pruebas realizadas y resultados

USE BD_Joyeria_Practica;
GO

-- ============================================================================
-- 1. CONFIGURACIÓN DE USUARIOS, ROLES Y PERMISOS
-- ============================================================================
**Demostración: El usuario usuario_admin pudo realizar modificaciones e inserciones directas sobre la tabla Producto (1 fila afectada), mientras que al intentar la misma operación directa con usuario_lector, el motor bloqueó la acción arrojando el error The INSERT permission was denied on the object 'Producto'. 

-- Creación de Logins y Usuarios para Permisos Directos
CREATE LOGIN usuario_admin WITH PASSWORD = 'AdminPassword123*';
CREATE LOGIN usuario_lector WITH PASSWORD = 'LectorPassword123*';
GO

CREATE USER usuario_admin FOR LOGIN usuario_admin;
CREATE USER usuario_lector FOR LOGIN usuario_lector;
GO

-- Asignación de Permisos Directos
ALTER ROLE db_owner ADD MEMBER usuario_admin;
GRANT SELECT ON dbo.Producto TO usuario_lector;
GRANT EXECUTE ON dbo.sp_InsertarProducto TO usuario_lector;
GO

-- Creación de Logins, Usuarios y Rol Personalizado
CREATE LOGIN usuario_con_rol WITH PASSWORD = 'RolUserPassword123*';
CREATE LOGIN usuario_sin_rol WITH PASSWORD = 'SinRolPassword123*';
GO

CREATE USER usuario_con_rol FOR LOGIN usuario_con_rol;
CREATE USER usuario_sin_rol FOR LOGIN usuario_sin_rol;
GO

CREATE ROLE rol_lectura_catalogos;
GO
GRANT SELECT ON dbo.Producto TO rol_lectura_catalogos;
GO
ALTER ROLE rol_lectura_catalogos ADD MEMBER usuario_con_rol;
GO

**Conclusión: Se verifica que la configuración de permisos directos impide que usuarios no autorizados modifiquen las tablas del sistema de forma arbitraria, protegiendo la integridad de la base de datos de Joyería Alba. 

## Eficiencia en la Administración de Seguridad mediante Roles del DBMS

## Parte A: Permisos a Nivel de Usuario (Directo vs. Procedimiento)

1. Intento de INSERT directo con usuario_admin vs usuario_lector

-- PRUEBA 1.1: INSERT directo con usuario_admin (EXITOSO)
EXECUTE AS USER = 'usuario_admin';
INSERT INTO Producto (Nombre, PrecioVenta, PrecioCompra, StockActual, StockMinimo, Descripcion, Estado, idGenero, idCategoria)
VALUES ('Anillo Diamante Admin Directo', 500000.00, 300000.00, 2, 1, 'Inserto directo Admin', 'Disponible', 1, 1);
REVERT;
GO

-- PRUEBA 1.2: INSERT directo con usuario_lector (FALLA POR DENEGACIÓN)
EXECUTE AS USER = 'usuario_lector';
BEGIN TRY
    INSERT INTO Producto (Nombre, PrecioVenta, PrecioCompra, StockActual, StockMinimo, Descripcion, Estado, idGenero, idCategoria)
    VALUES ('Anillo Diamante Lector Directo', 500000.00, 300000.00, 2, 1, 'Inserto directo Lector', 'Disponible', 1, 1);
END TRY
BEGIN CATCH
    PRINT '>> CONTROL DE SEGURIDAD: Error de permisos denegado al lector.';
    PRINT '>> Mensaje de SQL Server: ' + ERROR_MESSAGE();
END CATCH;
REVERT;
GO

Lo que pasó en la prueba:

El usuario administrador pudo realizar la inserción directa sin inconvenientes (1 fila afectada). En cambio, cuando simulamos la sesión con usuario_lector, SQL Server bloqueó la consulta arrojando el error explícito:

The INSERT permission was denied on the object 'Producto', database 'BD_Joyeria_Practica', schema 'dbo'.

**Conclusión: Se demuestra la efectividad de administrar accesos agrupados mediante roles personalizados (rol_lectura_catalogos). Esto simplifica la gestión de seguridad del sistema, evitando tener que otorgar permisos individuales a cada usuario y garantizando que solo los perfiles asignados puedan visualizar la información sensible del negocio. 

## 2. Inserción mediante Procedimiento Almacenado con usuario_lector

-- PRUEBA 1.3: INSERT a través de sp_InsertarProducto con usuario_lector (EXITOSO)
EXECUTE AS USER = 'usuario_lector';
DECLARE @idNuevo INT;

EXEC dbo.sp_InsertarProducto 
    @Nombre = 'Aros Plata Lector SP', 
    @PrecioVenta = 35000.00, 
    @PrecioCompra = 15000.00, 
    @StockActual = 10, 
    @StockMinimo = 2, 
    @Descripcion = 'Inserto mediante SP por usuario lector', 
    @Estado = 'Disponible', 
    @idGenero = 1, 
    @idCategoria = 4, 
    @NuevoCodigo = @idNuevo OUTPUT;

PRINT '>> ÉXITO: Inserción completada correctamente mediante el procedimiento almacenado.';
REVERT;
GO

## Lo que pasó en la prueba: 
Aunque usuario_lector no tiene permisos para hacer INSERT directo en la tabla Producto, la instrucción EXEC dbo.sp_InsertarProducto se ejecutó con éxito y devolvió el mensaje de confirmación. Esto demuestra que la seguridad permite delegar la carga de datos únicamente a través de la lógica controlada del procedimiento.

**Conclusión: Se comprueba que es posible delegar la ejecución de tareas operativas a usuarios con permisos restringidos mediante procedimientos almacenados (GRANT EXECUTE). De esta manera, el usuario no altera tablas directamente, sino que opera bajo la lógica de negocio validada dentro del procedimiento. 

## Parte B: Permisos a Nivel de Roles de Base de Datos

Verification de comportamiento entre usuario_con_rol y usuario_sin_rol

-- PRUEBA 2.1: Consulta SELECT con usuario_con_rol (EXITOSO)
EXECUTE AS USER = 'usuario_con_rol';
SELECT TOP 5 CodigoProducto, Nombre, PrecioVenta 
FROM dbo.Producto;
PRINT '>> ÉXITO: usuario_con_rol consultó el catálogo correctamente mediante su rol.';
REVERT;
GO

-- PRUEBA 2.2: Consulta SELECT con usuario_sin_rol (FALLA POR DENEGACIÓN)
EXECUTE AS USER = 'usuario_sin_rol';
BEGIN TRY
    SELECT TOP 5 CodigoProducto, Nombre, PrecioVenta 
    FROM dbo.Producto;
END TRY
BEGIN CATCH
    PRINT '>> CONTROL DE SEGURIDAD: Acceso denegado a usuario_sin_rol.';
    PRINT '>> Mensaje de SQL Server: ' + ERROR_MESSAGE();
END CATCH;
REVERT;
GO

## Lo que pasó en la prueba:

El usuario asignado al rol rol_lectura_catalogos pudo desplegar las primeras 5 filas del catálogo de joyas en la grilla de resultados. Por su parte, usuario_sin_rol fue rechazado por el motor con el mensaje The SELECT permission was denied on the object 'Producto', confirmando la correcta aislamiento del acceso.

**Conclusión: Se demuestra la efectividad de administrar accesos agrupados mediante roles personalizados (rol_lectura_catalogos). Esto simplifica la gestión de seguridad del sistema, evitando tener que otorgar permisos individuales a cada usuario y garantizando que solo los perfiles asignados puedan visualizar la información sensible del negocio. 

## 6. Conclusiones de las pruebas

Comprobamos la protección de tablas sensibles: El motor bloqueó de forma efectiva los intentos de modificación directa por parte de usuarios con permisos restringidos, asegurando que nadie pueda alterar valores en las tablas clave sin autorización.

Validamos el control por procedimientos almacenados: Demostramos que es posible permitir la carga de información a usuarios operativos mediante el permiso EXECUTE en procedimientos almacenados, impidiendo manipulaciones arbitrarias en las tablas base.

Confirmamos la eficiencia de los roles personalizados: La prueba entre el usuario con rol y sin rol evidenció que administrar accesos mediante grupos facilita el mantenimiento de la seguridad y garantiza el cumplimiento estricto del principio de mínimo privilegio.
