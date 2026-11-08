-------------------------------------------------------------------------------
-- SEGURIDAD -- 1.1 PERMISOS A NIVEL DE USUARIOS
-------------------------------------------------------------------------------
USE BD_JoyeriaAlba;
GO

-- 1. Crear Logins e Usuarios de base de datos

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usuario_admin')
    DROP USER usuario_admin;
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'usuario_admin')
    DROP LOGIN usuario_admin;
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usuario_lector')
    DROP USER usuario_lector;
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'usuario_lector')
    DROP LOGIN usuario_lector;
GO

CREATE LOGIN usuario_admin WITH PASSWORD = 'AdminPassword123*';
CREATE LOGIN usuario_lector WITH PASSWORD = 'LectorPassword123*';
GO

CREATE USER usuario_admin FOR LOGIN usuario_admin;
CREATE USER usuario_lector FOR LOGIN usuario_lector;
GO

-- 2. A un usuario darle el permiso de administrador y al otro solo permiso de lectura

ALTER ROLE db_owner ADD MEMBER usuario_admin;
GRANT SELECT ON dbo.Producto TO usuario_lector;
GO

-- 3. Crear el procedimiento almacenado sp_InsertarProducto si no existe
IF OBJECT_ID('dbo.sp_InsertarProducto', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_InsertarProducto;
GO

CREATE PROCEDURE dbo.sp_InsertarProducto
    @Nombre VARCHAR(100),
    @PrecioVenta DECIMAL(10,2),
    @PrecioCompra DECIMAL(10,2),
    @StockActual INT = 0,
    @StockMinimo INT = 1,
    @Descripcion VARCHAR(255) = NULL,
    @Estado VARCHAR(20) = 'Disponible',
    @idGenero INT,
    @idCategoria INT,
    @NuevoCodigo INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.Producto (Nombre, PrecioVenta, PrecioCompra, StockActual, StockMinimo, Descripcion, Estado, idGenero, idCategoria)
    VALUES (@Nombre, @PrecioVenta, @PrecioCompra, @StockActual, @StockMinimo, @Descripcion, @Estado, @idGenero, @idCategoria);
    SET @NuevoCodigo = SCOPE_IDENTITY();
END;
GO

-- 4. Al usuario con permiso de solo lectura, darle permiso de ejecución sobre el procedimiento almacenado

GRANT EXECUTE ON dbo.sp_InsertarProducto TO usuario_lector;
GO

-- 5. PRUEBAS DE VERIFICACIÓN (Permisos a Nivel de Usuarios)
-- ----------------------------------------------------------------------------

-- PRUEBA A: Realizar INSERT con sentencia SQL directa sobre la tabla Producto

-- Con usuario_admin: (Debe ser EXITOSO)
EXECUTE AS USER = 'usuario_admin';
INSERT INTO Producto (Nombre, PrecioVenta, PrecioCompra, StockActual, StockMinimo, Descripcion, Estado, idGenero, idCategoria)
VALUES ('Anillo Diamante Admin Directo', 500000.00, 300000.00, 2, 1, 'Inserto directo Admin', 'Disponible', 1, 1);
REVERT;
GO

-- Con usuario_lector: (Debe FALLAR por falta de permisos de INSERT)

EXECUTE AS USER = 'usuario_lector';
BEGIN TRY
    INSERT INTO Producto (Nombre, PrecioVenta, PrecioCompra, StockActual, StockMinimo, Descripcion, Estado, idGenero, idCategoria)
    VALUES ('Anillo Diamante Lector Directo', 500000.00, 300000.00, 2, 1, 'Inserto directo Lector', 'Disponible', 1, 1);
END TRY
BEGIN CATCH
    PRINT 'Resultado esperado (INSERT Directo Lector): Error de permisos denegado.';
    PRINT ERROR_MESSAGE();
END CATCH;
REVERT;
GO

-- PRUEBA B: Realizar INSERT a través del procedimiento almacenado con el usuario de solo lectura

-- Con usuario_lector: (Debe ser EXITOSO porque tiene permiso EXECUTE sobre el SP)
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

PRINT 'Resultado esperado (EXEC SP Lector): Ejecución exitosa mediante el procedimiento.';
REVERT;
GO

-------------------------------------------------------------------------------
-- 1.2 PERMISOS A NIVEL DE ROLES DEL DBMS
-------------------------------------------------------------------------------

-- 1. Crear dos usuarios de base de datos adicionales

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usuario_con_rol')
    DROP USER usuario_con_rol;
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'usuario_con_rol')
    DROP LOGIN usuario_con_rol;
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usuario_sin_rol')
    DROP USER usuario_sin_rol;
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'usuario_sin_rol')
    DROP LOGIN usuario_sin_rol;
GO

CREATE LOGIN usuario_con_rol WITH PASSWORD = 'RolUserPassword123*';
CREATE LOGIN usuario_sin_rol WITH PASSWORD = 'SinRolPassword123*';
GO

CREATE USER usuario_con_rol FOR LOGIN usuario_con_rol;
CREATE USER usuario_sin_rol FOR LOGIN usuario_sin_rol;
GO

-- 2. Crear un rol que solo permita la lectura de alguna de las tablas creadas

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'rol_lectura_catalogos' AND type = 'R')
    DROP ROLE rol_lectura_catalogos;
GO

CREATE ROLE rol_lectura_catalogos;
GO
GRANT SELECT ON dbo.Producto TO rol_lectura_catalogos;
GO

-- 3. Darle permiso a uno de los usuarios sobre el rol creado anteriormente

ALTER ROLE rol_lectura_catalogos ADD MEMBER usuario_con_rol;
GO

-- 4. Verificar el comportamiento de ambos usuarios al intentar leer la tabla

-- PRUEBA A: Lectura con usuario_con_rol (EXITOSO)

EXECUTE AS USER = 'usuario_con_rol';
SELECT TOP 5 CodigoProducto, Nombre, PrecioVenta 
FROM dbo.Producto;
PRINT 'Verificación usuario_con_rol: Consulta SELECT ejecutada correctamente.';
REVERT;
GO

-- PRUEBA B: Lectura con usuario_sin_rol (FALLA)

EXECUTE AS USER = 'usuario_sin_rol';
BEGIN TRY
    SELECT TOP 5 CodigoProducto, Nombre, PrecioVenta 
    FROM dbo.Producto;
END TRY
BEGIN CATCH
    PRINT 'Verificación usuario_sin_rol: Acceso denegado (Resultado Esperado).';
    PRINT ERROR_MESSAGE();
END CATCH;
REVERT;
GO
