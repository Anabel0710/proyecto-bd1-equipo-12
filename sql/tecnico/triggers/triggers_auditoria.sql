
USE BD_Joyeria_Practica;
GO

/* =====================================================
   ETAPA V - TRIGGERS DE AUDITORIA
   ===================================================== */


/* 1. TABLA AUXILIAR DE AUDITORIA */

IF OBJECT_ID('dbo.AuditoriaProducto', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.AuditoriaProducto
    (
        IdAuditoria INT IDENTITY(1,1) PRIMARY KEY,
        CodigoProducto INT NOT NULL,
        TipoOperacion VARCHAR(10) NOT NULL,

        PrecioVentaAnterior INT NULL,
        PrecioVentaNuevo INT NULL,

        StockAnterior INT NULL,
        StockNuevo INT NULL,

        FechaCambio DATETIME2 NOT NULL
            DEFAULT SYSDATETIME(),

        UsuarioSQL SYSNAME NOT NULL
            DEFAULT SUSER_SNAME()
    );
END;
GO


/* 2. TRIGGER DE AUDITORIA DE PRODUCTOS
   Registra UPDATE y DELETE */

CREATE OR ALTER TRIGGER dbo.tr_AuditarProducto
ON dbo.Producto
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    /* Auditoria de modificaciones */

    IF EXISTS (SELECT 1 FROM inserted)
       AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO dbo.AuditoriaProducto
        (
            CodigoProducto,
            TipoOperacion,
            PrecioVentaAnterior,
            PrecioVentaNuevo,
            StockAnterior,
            StockNuevo
        )
        SELECT
            d.CodigoProducto,
            'UPDATE',
            d.PrecioVenta,
            i.PrecioVenta,
            d.StockActual,
            i.StockActual
        FROM deleted d
        INNER JOIN inserted i
            ON d.CodigoProducto = i.CodigoProducto;
    END;

    /* Auditoria de eliminaciones */

    ELSE IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO dbo.AuditoriaProducto
        (
            CodigoProducto,
            TipoOperacion,
            PrecioVentaAnterior,
            PrecioVentaNuevo,
            StockAnterior,
            StockNuevo
        )
        SELECT
            d.CodigoProducto,
            'DELETE',
            d.PrecioVenta,
            NULL,
            d.StockActual,
            NULL
        FROM deleted d;
    END;
END;
GO


/* 3. TRIGGER PARA BLOQUEAR ELIMINACIONES DE COMPRAS */

CREATE OR ALTER TRIGGER dbo.tr_BloquearEliminacionCompra
ON dbo.Compra
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    RAISERROR(
        'No esta permitido eliminar compras. Se debe conservar el historial comercial.',
        16,
        1
    );
END;
GO


/* =====================================================
   4. PRUEBAS DE FUNCIONAMIENTO
   ===================================================== */


/* PRUEBA 1: Modificar el precio de un producto.
   Reemplazar el codigo por uno existente. */

-- UPDATE dbo.Producto
-- SET PrecioVenta = PrecioVenta + 100
-- WHERE CodigoProducto = 1;
-- GO


/* PRUEBA 2: Modificar el stock de un producto. */

-- UPDATE dbo.Producto
-- SET StockActual = StockActual + 5
-- WHERE CodigoProducto = 1;
-- GO


/* PRUEBA 3: Consultar los cambios registrados. */

SELECT *
FROM dbo.AuditoriaProducto
ORDER BY IdAuditoria DESC;
GO


/* PRUEBA 4: Eliminar un producto de prueba.
   Verificar previamente que no tenga relaciones
   que impidan su eliminacion. */

-- DELETE FROM dbo.Producto
-- WHERE CodigoProducto = 1;
-- GO


/* PRUEBA 5: Consultar las eliminaciones registradas. */

SELECT *
FROM dbo.AuditoriaProducto
WHERE TipoOperacion = 'DELETE';
GO


/* PRUEBA 6: Intentar eliminar una compra.
   La operacion debe ser bloqueada. */

-- DELETE FROM dbo.Compra
-- WHERE IdCompra = 1;
-- GO
