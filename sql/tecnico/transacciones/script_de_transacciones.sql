USE BD_JoyeriaAlba;
GO

/* =========================================================================
   ETAPA V: MANEJO DE TRANSACCIONES Y TRANSACCIONES ANIDADAS
   Proyecto: BD_JoyeriaAlba
   Descripción: Pruebas de atomicidad, consistencia, manejo de excepciones
                y control jerárquico mediante @@TRANCOUNT.
========================================================================= */

-- =========================================================================
-- PARTE A: TRANSACCIONES SIMPLES
-- =========================================================================

-- -------------------------------------------------------------------------
-- PRUEBA 1: Transacción Simple Exitosa (Confirmación con COMMIT)
-- Objetivo: Verificar la inserción coordinada en 3 tablas y descuento de stock.
-- -------------------------------------------------------------------------
PRINT '--- PRUEBA 1: TRANSACCIÓN SIMPLE EXITOSA ---';

-- Verificación del stock previo
SELECT CodigoProducto, Nombre, StockActual 
FROM Producto 
WHERE CodigoProducto = 1;

BEGIN TRY
    BEGIN TRANSACTION;

    -- 1. Insertar el encabezado de venta (Tabla 1)
    INSERT INTO Comprobante (FechaComprobante, idMedioPago, idTipoComprobante, idCliente, idUsuario)
    VALUES (GETDATE(), 1, 2, 1, 1);

    -- Captura del ID autoincremental recién emitido
    DECLARE @idVenta INT = SCOPE_IDENTITY();

    -- 2. Insertar el detalle de la venta (Tabla 2)
    INSERT INTO DetalleComprobante (idComprobante, CodigoProducto, Cantidad, PrecioUnitario)
    VALUES (@idVenta, 1, 1, 45000.00);

    -- 3. Actualizar el stock del producto vendido (Tabla 3)
    UPDATE Producto
    SET StockActual = StockActual - 1
    WHERE CodigoProducto = 1;

    -- Si no hubo errores, se confirman las tres operaciones
    COMMIT TRANSACTION;
    PRINT '>> ÉXITO: Transacción confirmada con COMMIT.';
END TRY
BEGIN CATCH
    -- Si alguna instrucción arroja error, se anula todo
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT '>> ERROR: Se canceló la transacción. Detalle: ' + ERROR_MESSAGE();
END CATCH;
GO

-- Verificación del stock posterior (debe reflejar una unidad menos)
SELECT CodigoProducto, Nombre, StockActual 
FROM Producto 
WHERE CodigoProducto = 1;
GO


-- -------------------------------------------------------------------------
-- PRUEBA 2: Transacción con Fallo Provocado (Atomicidad y ROLLBACK)
-- Objetivo: Provocar un error de FK en el paso 2 y verificar reversión total.
-- -------------------------------------------------------------------------
PRINT '--- PRUEBA 2: TRANSACCIÓN CON FALLO PROVOCADO ---';

-- Registramos la cantidad de comprobantes y stock antes de la prueba
SELECT COUNT(*) AS ComprobantesAntes FROM Comprobante;
SELECT CodigoProducto, Nombre, StockActual FROM Producto WHERE CodigoProducto = 1;

BEGIN TRY
    BEGIN TRANSACTION;

    -- Paso 1: Inserción de cabecera válida (se ejecuta primero)
    INSERT INTO Comprobante (FechaComprobante, idMedioPago, idTipoComprobante, idCliente, idUsuario)
    VALUES (GETDATE(), 1, 2, 1, 1);

    DECLARE @idVentaFallida INT = SCOPE_IDENTITY();

    -- Paso 2: ERROR PROVOCADO
    -- El producto 9999 no existe. Dispara una violación de Foreign Key y corta el TRY
    INSERT INTO DetalleComprobante (idComprobante, CodigoProducto, Cantidad, PrecioUnitario)
    VALUES (@idVentaFallida, 9999, 1, 45000.00);

    -- Paso 3: Modificación de inventario (el motor no debe llegar a esta línea)
    UPDATE Producto
    SET StockActual = StockActual - 1
    WHERE CodigoProducto = 1;

    COMMIT TRANSACTION;
    PRINT '>> ÉXITO: Transacción completada.';
END TRY
BEGIN CATCH
    -- El motor intercepta el error y salta directamente a este bloque
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT '>> CONTROL DE FALLO: Se detectó el error provocado y se ejecutó ROLLBACK.';
    PRINT '>> Mensaje de SQL Server: ' + ERROR_MESSAGE();
END CATCH;
GO

-- Verificación de consistencia y atomicidad
SELECT COUNT(*) AS ComprobantesDespues FROM Comprobante;
SELECT CodigoProducto, Nombre, StockActual FROM Producto WHERE CodigoProducto = 1;
GO


-- =========================================================================
-- PARTE B: TRANSACCIONES ANIDADAS
-- =========================================================================

-- -------------------------------------------------------------------------
-- PRUEBA 3: Transacciones Anidadas y Control Jerárquico con @@TRANCOUNT
-- Objetivo: Demostrar cómo se incrementa/decrementa el contador y confirmar en nivel 0.
-- -------------------------------------------------------------------------
PRINT '--- PRUEBA 3: TRANSACCIÓN ANIDADA EN SQL SERVER ---';
PRINT 'Nivel de transacción al iniciar: ' + CAST(@@TRANCOUNT AS VARCHAR);

BEGIN TRY
    -- Nivel 1: Transacción Principal (Venta)
    BEGIN TRANSACTION VentaPrincipal;
    PRINT '1. Inicia Transacción Principal (Externa). @@TRANCOUNT = ' + CAST(@@TRANCOUNT AS VARCHAR);

    INSERT INTO Comprobante (FechaComprobante, idMedioPago, idTipoComprobante, idCliente, idUsuario)
    VALUES (GETDATE(), 1, 2, 1, 1);

    DECLARE @idVentaAnidada INT = SCOPE_IDENTITY();

    INSERT INTO DetalleComprobante (idComprobante, CodigoProducto, Cantidad, PrecioUnitario)
    VALUES (@idVentaAnidada, 1, 1, 45000.00);

    UPDATE Producto
    SET StockActual = StockActual - 1
    WHERE CodigoProducto = 1;

    -- Nivel 2: Transacción Secundaria (Registro Logístico / Auditoría)
    BEGIN TRANSACTION LogisticaInterna;
    PRINT '2. Inicia Transacción Secundaria (Interna). @@TRANCOUNT = ' + CAST(@@TRANCOUNT AS VARCHAR);

    -- Registro en auditoría de ajuste por salida de mostrador
    INSERT INTO AjusteStock (FechaAjuste, CantidadAjuste, TipoAjuste, Observacion, CodigoProducto, idUsuario)
    VALUES (GETDATE(), -1, 'Venta Mostrador', 'Salida automática vinculada a venta', 1, 1);

    -- COMMIT de la transacción interna (solo decrementa @@TRANCOUNT, no confirma en disco aún)
    COMMIT TRANSACTION LogisticaInterna;
    PRINT '3. COMMIT de Transacción Interna ejecutado. @@TRANCOUNT = ' + CAST(@@TRANCOUNT AS VARCHAR);

    -- COMMIT de la transacción principal (alcanza el nivel 0 y asienta todo de forma definitiva)
    COMMIT TRANSACTION VentaPrincipal;
    PRINT '4. COMMIT de Transacción Principal ejecutado. @@TRANCOUNT = ' + CAST(@@TRANCOUNT AS VARCHAR);

    PRINT '>> ÉXITO TOTAL: Se confirmaron las operaciones externas e internas de forma consistente.';
END TRY
BEGIN CATCH
    -- Si ocurre un error en cualquier nivel, ROLLBACK anula la totalidad de las operaciones
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT '>> ERROR DETECTADO: Se ejecutó ROLLBACK completo. @@TRANCOUNT se restableció a: ' + CAST(@@TRANCOUNT AS VARCHAR);
        PRINT '>> Detalle: ' + ERROR_MESSAGE();
    END
END CATCH;
GO