/* =========================================================
   ARCHIVO: 01_datos_roles_usuarios.sql
   ========================================================= */
USE BD_Joyeria_Practica;
GO

/* =========================================================
   DATOS DE PRUEBA: Rol
   ========================================================= */

INSERT INTO Rol (NombreRol)
VALUES
    ('Administrador'),
    ('Vendedor'),
    ('Encargado de inventario'),
    ('Cliente');
GO


/* =========================================================
   DATOS DE PRUEBA: Usuario
   ========================================================= */

INSERT INTO Usuario (
    Nombre,
    Apellido,
    DNI,
    NombreUsuario,
    Contrasenia,
    Email,
    Estado,
    Domicilio,
    Telefono,
    IdRol
)
VALUES
    (
        'Sofia',
        'Benitez',
        '40111222',
        'sbenitez',
        'ClavePrueba01',
        'sofia.benitez@example.com',
        'Activo',
        'Junin 1250',
        '3794001001',
        1
    ),
    (
        'Martin',
        'Ramirez',
        '39222333',
        'mramirez',
        'ClavePrueba02',
        'martin.ramirez@example.com',
        'Activo',
        'Cordoba 845',
        '3794001002',
        2
    ),
    (
        'Valentina',
        'Gomez',
        '41333444',
        'vgomez',
        'ClavePrueba03',
        'valentina.gomez@example.com',
        'Activo',
        'Catamarca 560',
        '3794001003',
        2
    ),
    (
        'Nicolas',
        'Fernandez',
        '38444555',
        'nfernandez',
        'ClavePrueba04',
        'nicolas.fernandez@example.com',
        'Activo',
        'La Rioja 920',
        '3794001004',
        3
    ),
    (
        'Camila',
        'Lopez',
        '42555666',
        'clopez',
        'ClavePrueba05',
        'camila.lopez@example.com',
        'Activo',
        'Salta 430',
        '3794001005',
        4
    ),
    (
        'Joaquin',
        'Acosta',
        '40666777',
        'jacosta',
        'ClavePrueba06',
        'joaquin.acosta@example.com',
        'Activo',
        'Mendoza 780',
        '3794001006',
        4
    ),
    (
        'Lucia',
        'Medina',
        '41777888',
        'lmedina',
        'ClavePrueba07',
        'lucia.medina@example.com',
        'Activo',
        'Belgrano 1120',
        '3794001007',
        4
    ),
    (
        'Mateo',
        'Silva',
        '39888999',
        'msilva',
        'ClavePrueba08',
        'mateo.silva@example.com',
        'Activo',
        'San Martin 670',
        '3794001008',
        4
    ),
    (
        'Agustina',
        'Torres',
        '42999000',
        'atorres',
        'ClavePrueba09',
        'agustina.torres@example.com',
        'Inactivo',
        'Rivadavia 315',
        '3794001009',
        4
    ),
    (
        'Thiago',
        'Sosa',
        '39110111',
        'tsosa',
        'ClavePrueba10',
        'thiago.sosa@example.com',
        'Activo',
        'Buenos Aires 1540',
        '3794001010',
        4
    );
GO

/* =========================================================
   ARCHIVO: 02_datos_productos_categorias_generos.sql
   ========================================================= */
-- Seleccionar la base de datos del proyecto
USE BD_Joyeria_Practica;
GO

-- Datos de prueba para Genero
INSERT INTO dbo.Genero (NombreGenero)
VALUES
    ('Masculino'),
    ('Femenino'),
    ('Unisex'),
    ('Infantil'),
    ('Bebe'),
    ('Juvenil'),
    ('Senior'),
    ('Parejas'),
    ('Edicion Especial'),
    ('Sin Genero');
GO

-- Datos de prueba para Categoria
INSERT INTO dbo.Categoria (NombreCategoria)
VALUES
    ('Collar'),
    ('Aro'),
    ('Dije'),
    ('Anillo'),
    ('Pulsera'),
    ('Reloj'),
    ('Cadena'),
    ('Gemelos'),
    ('Tobillera'),
    ('Rosario');
GO

-- Datos de prueba para Producto
INSERT INTO dbo.Producto (
    Nombre,
    PrecioVenta,
    PrecioCompra,
    StockActual,
    StockMinimo,
    Descripcion,
    Estado,
    idGenero,
    idCategoria
)
VALUES
    (
        'Anillo Solitario Oro 18k',
        150000.00,
        90000.00,
        12,
        3,
        'Anillo de oro amarillo 18k con zirconias',
        'ACTIVO',
        2,
        4
    ),
    (
        'Cadena Escalera Plata 925',
        45000.00,
        25000.00,
        25,
        5,
        'Cadena de plata 925 de 50 cm',
        'ACTIVO',
        3,
        7
    ),
    (
        'Dije Cruz Plata y Oro',
        28000.00,
        15000.00,
        18,
        4,
        'Dije combinado en forma de cruz en plata y oro',
        'ACTIVO',
        3,
        3
    ),
    (
        'Aros de Perla Cultivada',
        62000.00,
        35000.00,
        8,
        2,
        'Aros pasantes con perla cultivada de agua dulce',
        'ACTIVO',
        2,
        2
    ),
    (
        'Reloj Cronografo Caballero',
        220000.00,
        140000.00,
        6,
        2,
        'Reloj de acero inoxidable sumergible hasta 50 metros',
        'ACTIVO',
        1,
        6
    ),
    (
        'Pulsera Grumet Plata 925',
        52000.00,
        30000.00,
        15,
        4,
        'Pulsera grumet pesada para hombre',
        'ACTIVO',
        1,
        5
    ),
    (
        'Collar Corazon Cristal',
        38000.00,
        20000.00,
        10,
        3,
        'Collar de cadena fina con dije de corazon',
        'ACTIVO',
        2,
        1
    ),
    (
        'Gemelos Elegantes Acero',
        25000.00,
        12000.00,
        14,
        2,
        'Gemelos de camisa para eventos formales',
        'ACTIVO',
        1,
        8
    ),
    (
        'Tobillera Verano Estrellas',
        18000.00,
        9000.00,
        30,
        5,
        'Tobillera de plata con dijes de estrellas',
        'ACTIVO',
        2,
        9
    ),
    (
        'Rosario Plata de Lapislazuli',
        75000.00,
        42000.00,
        5,
        2,
        'Rosario artesanal con cuentas de lapislazuli',
        'ACTIVO',
        3,
        10
    );
GO

-- Verificación de los datos insertados
SELECT * FROM dbo.Genero;
SELECT * FROM dbo.Categoria;
SELECT * FROM dbo.Producto;
GO

-- Verificación de la cantidad de registros
SELECT COUNT(*) AS CantidadGeneros
FROM dbo.Genero;

SELECT COUNT(*) AS CantidadCategorias
FROM dbo.Categoria;

SELECT COUNT(*) AS CantidadProductos
FROM dbo.Producto;
GO

/* =========================================================
   ARCHIVO: 03_datos_proveedor_mediopago_estadocompra.sql
   ========================================================= */
USE BD_Joyeria_Practica;
GO

-- 1. Carga en MedioPago
INSERT INTO MedioPago (NombreMedioPago) VALUES 
('Efectivo'),
('Tarjeta de Débito'),
('Tarjeta de Crédito'),
('Transferencia Bancaria'),
('Mercado Pago'),
('Cheque'),
('Dólar Estadounidense'),
('Criptomoneda USDT');
GO

-- 2. Carga en EstadoCompra
INSERT INTO EstadoCompra (NombreEstadoCompra) VALUES 
('Pendiente'),
('Aprobada'),
('En Preparación'),
('Despachada'),
('Recibida Conforme'),
('Recibida Parcial'),
('Observada'),
('Cancelada');
GO

-- 3. Carga en Proveedor (sin guiones para CUIT y Teléfono)
INSERT INTO Proveedor (RazonSocial, CUIT, Telefono, CorreoElectronico) VALUES 
('Metales del Norte S.A.', '30711234568', '03794421122', 'ventas@metalesdelnorte.com.ar'),
('Joyas y Gemas Argentinas S.R.L.', '30709876543', '01143219876', 'contacto@gemasarg.com.ar'),
('Oro Líquido Mayorista', '33654987129', '03794458900', 'pedidos@oroliquido.com'),
('Importadora Brillante S.A.', '30554433221', '01155667788', 'info@brillante.com.ar'),
('Plata 925 Mayorista BsAs', '27289991114', '01148765432', 'ventas@plata925mayor.com'),
('Accesorios & Estuches Corrientes', '20334455662', '03794412389', 'estuchesctes@gmail.com'),
('Orfebrería San Cayetano', '30667788995', '03794489012', 'sancayetanojoyas@hotmail.com'),
('Distribuidora Platino Centro', '30881122337', '03514234567', 'ventas@platinocentro.com.ar');
GO

/* =========================================================
   ARCHIVO: 04_compra_detalleCompra.sql
   ========================================================= */
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


/* =========================================================
   ARCHIVO: 05_ventas_facturacion_ajustes.sql
   ========================================================= */
USE BD_Joyeria_Practica;
GO

-- 1. Condición frente al IVA
INSERT INTO CondicionIVA (CondicionIVA) VALUES
('Consumidor Final'),
('Responsable Inscripto'),
('Monotributo'),
('Exento');
GO

-- 2. Tipo de Comprobante
INSERT INTO TipoComprobante (TipoComprobante) VALUES
('Factura B'),
('Factura A'),
('Ticket Consumidor Final'),
('Nota de Crédito');
GO

-- 3. Clientes
INSERT INTO Cliente (Nombre, Apellido, DNI_CUIT, Telefono, CorreoElectronico, idCondicionIVA) VALUES
('Mariana', 'Vazquez', '27356667774', '03794112233', 'mariana.vazquez@gmail.com', 1),
('Carlos', 'Benitez', '20304445558', '03794223344', 'carlos.benitez@hotmail.com', 1),
('Estilo & Elegancia S.A.', 'Gimenez', '30718889993', '01145556677', 'administracion@estiloelegancia.com.ar', 2),
('Lucia', 'Morales', '27389990001', '03794334455', 'lucia.morales@yahoo.com.ar', 3),
('Roberto', 'Sosa', '20287778882', '03794556677', 'roberto.sosa@live.com', 1);
GO

-- 4. Ajustes de Stock
INSERT INTO AjusteStock (FechaAjuste, TipoAjuste, CantidadAjuste, Observacion, idUsuario, CodigoProducto) VALUES
('2026-10-01 10:30:00', 'Rotura en vitrina', -1, 'Aro de plata dañado en exhibición del local', 1, 2),
('2026-10-05 18:00:00', 'Ajuste de inventario', 2, 'Sobrante detectado tras recuento mensual físico', 4, 3),
('2026-10-10 11:15:00', 'Merma por manipulación', -1, 'Cierre de pulsera defectuoso enviado a taller', 1, 5),
('2026-10-15 16:45:00', 'Auditoría interna', -1, 'Diferencia en mostrador regularizada', 4, 1);
GO

-- 5. Recepciones de Mercadería (Asociadas a compras aprobadas y recibidas)
INSERT INTO Recepcion (FechaRecepcion, idCompra, idUsuario) VALUES
('2026-09-03 14:00:00', 1, 4),
('2026-09-07 10:30:00', 2, 4),
('2026-09-12 16:00:00', 3, 4),
('2026-09-17 11:45:00', 4, 4);
GO

-- 6. Detalle de Recepción (Cantidades recibidas vs pedidas)
INSERT INTO DetalleRecepcion (CantidadRecibida, idRecepcion, idDetalleCompra) VALUES
(10, 1, 1),
(20, 2, 2),
(30, 3, 3),
(15, 4, 4);
GO

-- 7. Comprobantes de Venta (Facturación en mostrador)
INSERT INTO Comprobante (FechaComprobante, idMedioPago, idTipoComprobante, idCliente, idUsuario) VALUES
('2026-10-02 10:15:00', 1, 1, 1, 2),
('2026-10-04 12:30:00', 3, 1, 2, 3),
('2026-10-08 17:45:00', 2, 2, 3, 2),
('2026-10-12 11:00:00', 1, 1, 4, 3),
('2026-10-16 19:20:00', 4, 1, 5, 2),
('2026-10-20 16:10:00', 1, 3, 1, 3),
('2026-10-25 18:35:00', 2, 1, 2, 2),
('2026-10-29 11:50:00', 3, 2, 3, 2);
GO

-- 8. Detalle de Comprobantes (Renglones de venta)
INSERT INTO DetalleComprobante (idComprobante, Cantidad, PrecioUnitario, CodigoProducto) VALUES
(1, 1, 220000.00, 1),
(2, 2, 48000.00, 2),
(3, 1, 23000.00, 3),
(3, 1, 78000.00, 4),
(4, 1, 58000.00, 5),
(5, 1, 240000.00, 6),
(6, 1, 440000.00, 7),
(7, 1, 360000.00, 8),
(8, 2, 220000.00, 1),
(8, 1, 48000.00, 2);
GO
