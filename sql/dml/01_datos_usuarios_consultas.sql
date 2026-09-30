USE BD_Joyeria_Practica;
GO

/* =========================================================
   DATOS DE PRUEBA: Rol
   Se cargan 8 registros.
   ========================================================= */

INSERT INTO Rol (NombreRol)
VALUES
    ('Administrador'),
    ('Cliente'),
    ('Vendedor'),
    ('Supervisor'),
    ('Cajero'),
    ('Encargado de inventario'),
    ('Atencion al cliente'),
    ('Auditor');
GO


/* =========================================================
   DATOS DE PRUEBA: Usuario
   Se cargan 10 registros.
   ========================================================= */

INSERT INTO Usuario
    (Nombre, Apellido, Email, Contrasenia, IdRol)
VALUES
    ('Sofia', 'Benitez',
     'sofia.benitez@example.com', 'ClavePrueba01', 1),

    ('Martin', 'Ramirez',
     'martin.ramirez@example.com', 'ClavePrueba02', 2),

    ('Valentina', 'Gomez',
     'valentina.gomez@example.com', 'ClavePrueba03', 3),

    ('Nicolas', 'Fernandez',
     'nicolas.fernandez@example.com', 'ClavePrueba04', 4),

    ('Camila', 'Lopez',
     'camila.lopez@example.com', 'ClavePrueba05', 5),

    ('Joaquin', 'Acosta',
     'joaquin.acosta@example.com', 'ClavePrueba06', 5),

    ('Lucia', 'Medina',
     'lucia.medina@example.com', 'ClavePrueba07', 6),

    ('Mateo', 'Silva',
     'mateo.silva@example.com', 'ClavePrueba08', 7),

    ('Agustina', 'Torres',
     'agustina.torres@example.com', 'ClavePrueba09', 4),

    ('Thiago', 'Sosa',
     'thiago.sosa@example.com', 'ClavePrueba10', 8);
GO


/* =========================================================
   DATOS DE PRUEBA: Consulta
   Se cargan 10 registros.

   Las consultas con IdUsuario NULL representan mensajes
   enviados por visitantes no registrados.
   ========================================================= */

INSERT INTO Consulta
    (
        NombreRemitente,
        EmailRemitente,
        FechaHora,
        Estado,
        Mensaje,
        IdUsuario
    )
VALUES
    (
        'Martin Ramirez',
        'martin.ramirez@example.com',
        '2026-09-20T10:15:00',
        'Pendiente',
        'Quisiera conocer la disponibilidad de anillos de oro.',
        2
    ),

    (
        'Valentina Gomez',
        'valentina.gomez@example.com',
        '2026-09-20T11:30:00',
        'Respondida',
        'Necesito información sobre los medios de pago disponibles.',
        3
    ),

    (
        'Carolina Perez',
        'carolina.perez@example.com',
        '2026-09-21T09:20:00',
        'Pendiente',
        'Quisiera consultar si realizan envíos a otras provincias.',
        NULL
    ),

    (
        'Nicolas Fernandez',
        'nicolas.fernandez@example.com',
        '2026-09-21T15:40:00',
        'Leida',
        '¿Cuál es el tiempo estimado de entrega de una compra?',
        4
    ),

    (
        'Camila Lopez',
        'camila.lopez@example.com',
        '2026-09-22T12:10:00',
        'Respondida',
        'Necesito cambiar el método de pago de mi pedido.',
        5
    ),

    (
        'Daniela Romero',
        'daniela.romero@example.com',
        '2026-09-23T08:45:00',
        'Pendiente',
        'Quisiera saber si tienen collares de plata disponibles.',
        NULL
    ),

    (
        'Joaquin Acosta',
        'joaquin.acosta@example.com',
        '2026-09-23T16:25:00',
        'Leida',
        'Solicito información sobre el estado de mi pedido.',
        6
    ),

    (
        'Lucia Medina',
        'lucia.medina@example.com',
        '2026-09-24T10:50:00',
        'Respondida',
        '¿Se puede reservar una joya antes de realizar el pago?',
        7
    ),

    (
        'Pablo Martinez',
        'pablo.martinez@example.com',
        '2026-09-24T14:15:00',
        'Pendiente',
        'Quisiera consultar si realizan grabados personalizados.',
        NULL
    ),

    (
        'Mateo Silva',
        'mateo.silva@example.com',
        '2026-09-25T17:35:00',
        'Pendiente',
        'Necesito información sobre la garantía de los productos.',
        8
    );
GO