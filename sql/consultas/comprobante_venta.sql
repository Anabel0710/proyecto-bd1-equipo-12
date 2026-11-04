USE BD_Joyeria_Practica;
GO

SELECT 
    c.idComprobante AS NroComprobante,
    tc.TipoComprobante,
    c.FechaComprobante,
    CONCAT(cli.Nombre, ' ', ISNULL(cli.Apellido, '')) AS Cliente,
    cli.DNI_CUIT AS DocumentoFiscal,
    CONCAT(u.Nombre, ' ', u.Apellido) AS AtendidoPor,
    mp.NombreMedioPago AS FormaPago,
    p.Nombre AS Producto,
    dc.Cantidad,
    dc.PrecioUnitario,
    (dc.Cantidad * dc.PrecioUnitario) AS SubtotalRenglon,
    (
        SELECT SUM(d2.Cantidad * d2.PrecioUnitario) 
        FROM DetalleComprobante d2 
        WHERE d2.idComprobante = c.idComprobante
    ) AS ImporteTotalGeneral
FROM Comprobante c
INNER JOIN TipoComprobante tc ON c.idTipoComprobante = tc.idTipoComprobante
INNER JOIN MedioPago mp ON c.idMedioPago = mp.idMedioPago
INNER JOIN Cliente cli ON c.idCliente = cli.idCliente
INNER JOIN Usuario u ON c.idUsuario = u.idUsuario
INNER JOIN DetalleComprobante dc ON c.idComprobante = dc.idComprobante
INNER JOIN Producto p ON dc.CodigoProducto = p.CodigoProducto
WHERE c.idComprobante = 1;
GO
