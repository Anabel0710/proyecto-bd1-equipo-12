

-- ============================================================================
-- PARTE 2: OPTIMIZACIÓN DE CONSULTAS A TRAVÉS DE ÍNDICES
-- ============================================================================

-- 1. Realizar una carga masiva de por lo menos un millón de registros sobre alguna tabla con campo fecha (sin índice)

IF OBJECT_ID('dbo.VentaHistoricaALBA', 'U') IS NOT NULL 
    DROP TABLE dbo.VentaHistoricaALBA;
GO

-- Tabla sin índice agrupado inicial (Heap)
CREATE TABLE dbo.VentaHistoricaALBA (
    id_venta BIGINT IDENTITY(1,1),
    fecha_venta DATETIME NOT NULL,
    monto_total DECIMAL(12,2) NOT NULL,
    idCliente INT NOT NULL,
    idMedioPago INT NOT NULL
);
GO

-- Script para automatizar la carga masiva de 1.000.000 de filas
SET NOCOUNT ON;
GO

WITH Numeros AS (
    SELECT TOP (1000000)
        ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
    CROSS JOIN sys.objects c
)
INSERT INTO dbo.VentaHistoricaALBA (fecha_venta, monto_total, idCliente, idMedioPago)
SELECT
    DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 2628000, '2021-01-01'),
    ROUND((RAND(CHECKSUM(NEWID())) * 450000) + 5000, 2),
    (ABS(CHECKSUM(NEWID())) % 10) + 1,
    (ABS(CHECKSUM(NEWID())) % 4) + 1
FROM Numeros;
GO

-- Verificar la cantidad de registros insertados

SELECT COUNT(*) AS TotalRegistrosCargados FROM dbo.VentaHistoricaALBA;
GO

-------------------------------------------------------------------------------
-- 2. BÚSQUEDA POR PERÍODO Y MEDICIÓN SIN ÍNDICE
-------------------------------------------------------------------------------

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

-- Consulta por período sobre tabla sin índices (Genera un Table Scan)

SELECT id_venta, fecha_venta, monto_total
FROM dbo.VentaHistoricaALBA
WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-03-31';
GO

-------------------------------------------------------------------------------
-- 3. CREAR ÍNDICE AGRUPADO SOBRE LA COLUMNA FECHA Y REPETIR CONSULTA
-------------------------------------------------------------------------------

CREATE CLUSTERED INDEX IX_VentaHistoricaALBA_Fecha
ON dbo.VentaHistoricaALBA (fecha_venta);
GO

-- Repetir la consulta (Genera un Clustered Index Seek)

SELECT id_venta, fecha_venta, monto_total
FROM dbo.VentaHistoricaALBA
WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-03-31';
GO

-------------------------------------------------------------------------------
-- 4. BORRAR EL ÍNDICE CREADO
-------------------------------------------------------------------------------

DROP INDEX IX_VentaHistoricaALBA_Fecha ON dbo.VentaHistoricaALBA;
GO

-------------------------------------------------------------------------------
-- 5. CREAR OTRO ÍNDICE AGRUPADO QUE ADEMÁS INCLUYA LAS COLUMNAS SELECCIONADAS
-------------------------------------------------------------------------------

-- Se crea un Índice Agrupado Compuesto que cubre la fecha y las columnas seleccionadas

CREATE CLUSTERED INDEX IX_VentaHistoricaALBA_Fecha_Compuesto
ON dbo.VentaHistoricaALBA (fecha_venta, id_venta, monto_total);
GO

-- Repetir la consulta anterior (Genera Clustered Index Seek optimizado)

SELECT id_venta, fecha_venta, monto_total
FROM dbo.VentaHistoricaALBA
WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-03-31';
GO

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO