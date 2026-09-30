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