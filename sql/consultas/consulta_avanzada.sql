USE BD_Joyeria_Practica;
GO

SELECT 
    u.idUsuario AS LegajoVendedor,
    CONCAT(u.Nombre, ' ', u.Apellido) AS Vendedor,
    r.NombreRol AS Puesto,
    COUNT(DISTINCT c.idComprobante) AS ComprobantesEmitidos,
    SUM(dc.Cantidad * dc.PrecioUnitario) AS TotalFacturado
FROM Usuario u
INNER JOIN Rol r ON u.idRol = r.idRol
INNER JOIN Comprobante c ON u.idUsuario = c.idUsuario
INNER JOIN DetalleComprobante dc ON c.idComprobante = dc.idComprobante
WHERE r.NombreRol = 'Vendedor' 
  AND u.Estado = 'Activo'
GROUP BY u.idUsuario, u.Nombre, u.Apellido, r.NombreRol
HAVING SUM(dc.Cantidad * dc.PrecioUnitario) >= 100000.00
ORDER BY TotalFacturado DESC;
GO