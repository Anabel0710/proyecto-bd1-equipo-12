USE BD_JoyeriaAlba;
GO

SELECT 
    cat.NombreCategoria AS Categoria,
    COUNT(DISTINCT comp.idComprobante) AS OperacionesRealizadas,
    SUM(dc.Cantidad) AS UnidadesVendidas,
    SUM(dc.Cantidad * dc.PrecioUnitario) AS TotalRecaudado
FROM Categoria cat
INNER JOIN Producto p ON cat.idCategoria = p.idCategoria
INNER JOIN DetalleComprobante dc ON p.CodigoProducto = dc.CodigoProducto
INNER JOIN Comprobante comp ON dc.idComprobante = comp.idComprobante
WHERE comp.FechaComprobante >= '20261001' 
  AND comp.FechaComprobante <= '20261031 23:59:59'
GROUP BY cat.idCategoria, cat.NombreCategoria
ORDER BY TotalRecaudado DESC;
GO
