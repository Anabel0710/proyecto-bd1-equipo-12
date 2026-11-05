USE BD_JoyeriaAlba;
GO

/* =========================================================================
   ETAPA V: FUNCIONES DEFINIDAS POR EL USUARIO (UDF)
   Proyecto: BD_JoyeriaAlba
   Descripción: Implementación y pruebas de funciones escalares y funciones
                con valores de tabla en línea para el sistema de ventas.
========================================================================= */

-- =========================================================================
-- 1. FUNCIÓN ESCALAR: fn_CalcularDescuentoCliente
-- Objetivo: Determinar el porcentaje de descuento aplicable según el monto
--           total acumulado en compras históricas del cliente.
-- =========================================================================
IF OBJECT_ID('dbo.fn_CalcularDescuentoCliente', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_CalcularDescuentoCliente;
GO

CREATE FUNCTION dbo.fn_CalcularDescuentoCliente
(
    @idCliente INT
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @MontoAcumulado DECIMAL(10,2);
    DECLARE @PorcentajeDescuento DECIMAL(5,2);
    
    -- Sumar el gasto histórico del cliente a través de sus comprobantes
    SELECT @MontoAcumulado = ISNULL(SUM(dc.Cantidad * dc.PrecioUnitario), 0.00)
    FROM Comprobante c
    INNER JOIN DetalleComprobante dc ON c.idComprobante = dc.idComprobante
    WHERE c.idCliente = @idCliente;
    
    -- Escalas comerciales de bonificación
    IF @MontoAcumulado > 500000.00
        SET @PorcentajeDescuento = 0.10; -- 10% de descuento
    ELSE IF @MontoAcumulado > 200000.00
        SET @PorcentajeDescuento = 0.05; -- 5% de descuento
    ELSE
        SET @PorcentajeDescuento = 0.00; -- Sin bonificación
        
    RETURN @PorcentajeDescuento;
END;
GO


-- =========================================================================
-- 2. FUNCIÓN CON VALORES DE TABLA: fn_ObtenerProductosPorCategoria
-- Objetivo: Retornar el catálogo precompilado de artículos disponibles
--           para una categoría específica, uniendo género y categoría.
-- =========================================================================
IF OBJECT_ID('dbo.fn_ObtenerProductosPorCategoria', 'IF') IS NOT NULL
    DROP FUNCTION dbo.fn_ObtenerProductosPorCategoria;
GO

CREATE FUNCTION dbo.fn_ObtenerProductosPorCategoria
(
    @idCategoria INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.CodigoProducto,
        p.Nombre AS Producto,
        p.PrecioVenta,
        p.StockActual,
        c.NombreCategoria,
        g.NombreGenero
    FROM Producto p
    INNER JOIN Categoria c ON p.idCategoria = c.idCategoria
    INNER JOIN Genero g ON p.idGenero = g.idGenero
    WHERE p.idCategoria = @idCategoria 
      AND p.Estado = 'Disponible'
);
GO


-- =========================================================================
-- DEMOSTRACIÓN Y PRUEBAS DE EJECUCIÓN
-- =========================================================================

-- Prueba 1: Ejecución de la Función Escalar de Descuento (Cliente ID = 1)
SELECT 
    idCliente,
    Nombre + ' ' + Apellido AS Cliente,
    dbo.fn_CalcularDescuentoCliente(idCliente) AS PorcentajeDescuento
FROM Cliente
WHERE idCliente = 1;
GO

-- Prueba 2: Consulta mediante la Función de Tabla en Línea (Categoría ID = 1 - Anillos)
SELECT * FROM dbo.fn_ObtenerProductosPorCategoria(1);
GO
