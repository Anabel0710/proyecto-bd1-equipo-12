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