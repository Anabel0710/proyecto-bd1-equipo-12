

INSERT INTO dbo.ROL (nombre_rol)
VALUES
(N'Administrador'),
(N'Cliente'),
(N'Vendedor'),
(N'Supervisor'),
(N'Cajero'),
(N'Encargado de inventario'),
(N'Atención al cliente'),
(N'Auditor');
GO

-- 10 registros para USUARIO

INSERT INTO dbo.USUARIO (
    nombre,
    apellido,
    email,
    contrasenia,
    id_rol
)
VALUES
(N'Sofía', N'Benítez',
 N'sofia.benitez@example.com', N'ClavePrueba01', 2),

(N'Martín', N'Ramírez',
 N'martin.ramirez@example.com', N'ClavePrueba02', 2),

(N'Valentina', N'Gómez',
 N'valentina.gomez@example.com', N'ClavePrueba03', 2),

(N'Nicolás', N'Fernández',
 N'nicolas.fernandez@example.com', N'ClavePrueba04', 3),

(N'Camila', N'López',
 N'camila.lopez@example.com', N'ClavePrueba05', 1),

(N'Joaquín', N'Acosta',
 N'joaquin.acosta@example.com', N'ClavePrueba06', 5),

(N'Lucía', N'Medina',
 N'lucia.medina@example.com', N'ClavePrueba07', 6),

(N'Mateo', N'Silva',
 N'mateo.silva@example.com', N'ClavePrueba08', 7),

(N'Agustina', N'Torres',
 N'agustina.torres@example.com', N'ClavePrueba09', 4),

(N'Thiago', N'Sosa',
 N'thiago.sosa@example.com', N'ClavePrueba10', 8);
GO

-- 10 registros para CONSULTA.
-- Algunas consultas pertenecen a usuarios registrados.
-- Otras tienen id_usuario NULL porque fueron realizadas
-- por visitantes.

INSERT INTO dbo.CONSULTA (
    nombre_remitente,
    email_remitente,
    fecha_hora,
    estado,
    mensaje,
    id_usuario
)
VALUES
(
    N'Sofía Benítez',
    N'sofia.benitez@example.com',
    '2026-09-20T10:15:00',
    N'Pendiente',
    N'Quisiera conocer las medidas disponibles de los anillos.',
    1
),
(
    N'Martín Ramírez',
    N'martin.ramirez@example.com',
    '2026-09-20T11:30:00',
    N'Respondida',
    N'¿Realizan envíos a otras provincias?',
    2
),
(
    N'Valentina Gómez',
    N'valentina.gomez@example.com',
    '2026-09-21T09:20:00',
    N'Cerrada',
    N'Necesito información sobre el cuidado de las joyas.',
    3
),
(
    N'Carolina Pérez',
    N'carolina.perez@example.com',
    '2026-09-21T12:45:00',
    N'Pendiente',
    N'¿Puedo comprar sin registrarme?',
    NULL
),
(
    N'Federico Molina',
    N'federico.molina@example.com',
    '2026-09-22T16:10:00',
    N'Respondida',
    N'Quisiera consultar si aceptan pagos en efectivo.',
    NULL
),
(
    N'Sofía Benítez',
    N'sofia.benitez@example.com',
    '2026-09-23T14:25:00',
    N'Cerrada',
    N'¿Cómo puedo conocer el estado de mi pedido?',
    1
),
(
    N'Laura Romero',
    N'laura.romero@example.com',
    '2026-09-24T18:00:00',
    N'Pendiente',
    N'¿Los collares incluyen garantía?',
    NULL
),
(
    N'Martín Ramírez',
    N'martin.ramirez@example.com',
    '2026-09-25T08:40:00',
    N'Respondida',
    N'Quisiera modificar mis datos personales.',
    2
),
(
    N'Daniela Ortiz',
    N'daniela.ortiz@example.com',
    '2026-09-26T15:35:00',
    N'Pendiente',
    N'¿Disponen de pulseras ajustables?',
    NULL
),
(
    N'Valentina Gómez',
    N'valentina.gomez@example.com',
    '2026-09-27T17:50:00',
    N'Cerrada',
    N'Necesito consultar los métodos de pago disponibles.',
    3
);
GO