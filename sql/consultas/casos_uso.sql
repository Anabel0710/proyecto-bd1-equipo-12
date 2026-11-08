USE BD_JoyeriaAlba;
GO

-- =================================================================
-- Caso de Uso 1: Control de Stock y Detección de Existencias Bajas
-- =================================================================
SELECT
    p.CodigoProducto,
    p.Nombre AS Producto,
    c.NombreCategoria AS Categoria,
    g.NombreGenero AS Genero,
    p.StockActual,
    p.StockMinimo,
    (15 - p.StockActual) AS UnidadesParaNivelOptimo
FROM Producto p
INNER JOIN Categoria c ON p.idCategoria = c.idCategoria
INNER JOIN Genero g ON p.idGenero = g.idGenero
WHERE p.StockActual <= 10 
  AND p.Estado IN ('ACTIVO', 'Disponible')
ORDER BY p.StockActual ASC;
GO

-- =================================================================
-- Caso de Uso 2: Auditoría y Seguimiento de Ajustes Manuales de Stock
-- =================================================================
SELECT
    a.idAjuste,
    a.FechaAjuste,
    CONCAT(u.Nombre, ' ', u.Apellido) AS EmpleadoResponsable,
    u.NombreUsuario AS LoginUsuario,
    p.Nombre AS ProductoAfectado,
    a.TipoAjuste,
    a.CantidadAjuste,
    a.Observacion
FROM AjusteStock a
INNER JOIN Usuario u ON a.idUsuario = u.IdUsuario
INNER JOIN Producto p ON a.CodigoProducto = p.CodigoProducto
ORDER BY a.FechaAjuste DESC;
GO

-- =================================================================
-- Caso de Uso 3: Verificación de Cumplimiento de Entregas de Proveedores
-- =================================================================
SELECT
    c.IdCompra AS NroOrdenCompra,
    pr.RazonSocial AS Proveedor,
    p.Nombre AS Producto,
    dc.Cantidad AS CantidadPedida,
    ISNULL(dr.CantidadRecibida, 0) AS CantidadRecibida,
    (dc.Cantidad - ISNULL(dr.CantidadRecibida, 0)) AS DiferenciaFaltante,
    r.FechaRecepcion
FROM Compra c
INNER JOIN Proveedor pr ON c.IdProveedor = pr.IdProveedor
INNER JOIN DetalleCompra dc ON c.IdCompra = dc.IdCompra
INNER JOIN Producto p ON dc.IdProducto = p.CodigoProducto
LEFT JOIN DetalleRecepcion dr ON dc.IdDetalleCompra = dr.idDetalleCompra
LEFT JOIN Recepcion r ON dr.idRecepcion = r.idRecepcion
ORDER BY c.IdCompra ASC;
GO
