USE BD_Joyeria_Practica;
GO

-- 1. Vaciamos las tablas y reseteamos los contadores IDENTITY a 0
DELETE FROM DetalleCompra;
DELETE FROM Compra;
DBCC CHECKIDENT ('Compra', RESEED, 0);
GO

-- 2. Aseguramos el formato de fecha
SET DATEFORMAT ymd;
GO

-- 3. Insertamos las compras (se generarán los IdCompra del 1 al 8)
INSERT INTO Compra (FechaCompra, IdUsuario, IdProveedor, IdEstadoCompra, IdMedioPago) VALUES
('2026-09-01 09:30:00', 5, 1, 5, 1),
('2026-09-05 11:15:00', 5, 2, 5, 1),
('2026-09-10 16:45:00', 1, 3, 5, 2),
('2026-09-15 10:00:00', 5, 4, 5, 2),
('2026-09-20 14:20:00', 1, 5, 3, 3),
('2026-09-24 08:50:00', 5, 6, 4, 1),
('2026-09-28 17:10:00', 5, 7, 2, 2),
('2026-09-30 12:00:00', 1, 8, 1, 3);
GO

-- 4. Insertamos el detalle con IdCompra del 1 al 8
INSERT INTO DetalleCompra (IdCompra, Cantidad, PrecioUnitario, IdProducto) VALUES
(1, 10, 110000.00, 1),
(2, 20, 24000.00, 2),
(3, 30, 11500.00, 3),
(4, 15, 39000.00, 4),
(5, 10, 29000.00, 5),
(6, 5, 120000.00, 6),
(7, 4, 220000.00, 7),
(8, 6, 180000.00, 8);
GO
