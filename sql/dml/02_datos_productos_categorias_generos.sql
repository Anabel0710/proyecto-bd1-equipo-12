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