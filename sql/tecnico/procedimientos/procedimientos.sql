USE BD_JoyeriaAlba;
GO

/* =========================================================================
   ETAPA V: PROCEDIMIENTOS ALMACENADOS (STORED PROCEDURES)
   Proyecto: BD_JoyeriaAlba
   Descripción: Implementación y pruebas de procedimientos para encapsular
                la lógica transaccional de registro de ventas en mostrador.
========================================================================= */

-- =========================================================================
-- PROCEDIMIENTO ALMACENADO: sp_RegistrarVentaCompleta
-- Objetivo: Encapsular el circuito de venta: validación de stock, cálculo
--           de descuento por cliente, alta de comprobante, inserción de renglón
--           y descuento físico de mercadería en inventario.
-- =========================================================================
IF OBJECT_ID('dbo.sp_RegistrarVentaCompleta', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_RegistrarVentaCompleta;
GO

CREATE PROCEDURE dbo.sp_RegistrarVentaCompleta
    @idMedioPago INT,
    @idTipoComprobante INT,
    @idCliente INT,
    @idUsuario INT,
    @CodigoProducto INT,
    @Cantidad INT,
    @idComprobanteGenerado INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @PrecioVenta DECIMAL(10,2);
    DECLARE @StockActual INT;
    DECLARE @Descuento DECIMAL(5,2);
    DECLARE @PrecioFinal DECIMAL(10,2);
    
    -- 1. Validación de existencia de producto y existencia en stock
    SELECT @PrecioVenta = PrecioVenta, @StockActual = StockActual
    FROM Producto
    WHERE CodigoProducto = @CodigoProducto;
    
    IF @PrecioVenta IS NULL
    BEGIN
        RAISERROR('El producto especificado no existe.', 16, 1);
        RETURN;
    END
    
    IF @StockActual < @Cantidad
    BEGIN
        RAISERROR('Stock insuficiente en Joyería Alba para realizar la venta.', 16, 1);
        RETURN;
    END
    
    -- 2. Cálculo dinámico de bonificación mediante la UDF escalar
    SET @Descuento = dbo.fn_CalcularDescuentoCliente(@idCliente);
    SET @PrecioFinal = @PrecioVenta * (1.00 - @Descuento);
    
    -- 3. Registro del encabezado de venta (Comprobante)
    INSERT INTO Comprobante (FechaComprobante, idMedioPago, idTipoComprobante, idCliente, idUsuario)
    VALUES (GETDATE(), @idMedioPago, @idTipoComprobante, @idCliente, @idUsuario);
    
    SET @idComprobanteGenerado = SCOPE_IDENTITY();
    
    -- 4. Registro del detalle de venta con el precio unitario final aplicado
    INSERT INTO DetalleComprobante (idComprobante, Cantidad, PrecioUnitario, CodigoProducto)
    VALUES (@idComprobanteGenerado, @Cantidad, @PrecioFinal, @CodigoProducto);
    
    -- 5. Actualización física de inventario
    UPDATE Producto
    SET StockActual = StockActual - @Cantidad
    WHERE CodigoProducto = @CodigoProducto;
    
    PRINT 'Venta completada con éxito. ID Comprobante: ' + CAST(@idComprobanteGenerado AS VARCHAR(10));
END;
GO


-- =========================================================================
-- DEMOSTRACIÓN Y PRUEBAS DE EJECUCIÓN
-- =========================================================================

-- Ejecución del Procedimiento Almacenado y Verificación de Facturación
DECLARE @NuevoComprobanteID INT;

EXEC dbo.sp_RegistrarVentaCompleta 
    @idMedioPago = 1, 
    @idTipoComprobante = 1, 
    @idCliente = 1, 
    @idUsuario = 1, 
    @CodigoProducto = 1, 
    @Cantidad = 1, 
    @idComprobanteGenerado = @NuevoComprobanteID OUTPUT;

-- Comprobación del comprobante y renglón generado
SELECT 
    c.idComprobante,
    c.FechaComprobante,
    dc.CodigoProducto,
    dc.Cantidad,
    dc.PrecioUnitario,
    (dc.Cantidad * dc.PrecioUnitario) AS Subtotal
FROM Comprobante c
INNER JOIN DetalleComprobante dc ON c.idComprobante = dc.idComprobante
WHERE c.idComprobante = @NuevoComprobanteID;
GO
