-- 1. aseguramos de estar en master para poder crear bases de datos
USE master;

CREATE DATABASE BD_Joyeria_Practica;
GO
-- 2. Si la base no existe, se crea automáticamente
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'BD_Joyeria_Practica')
BEGIN
    CREATE DATABASE BD_Joyeria_Practica;
END
GO

-- 3. Para posicionarse en la base del proyecto
USE BD_Joyeria_Practica;
GO

CREATE TABLE Genero (
    idGenero INT IDENTITY(1,1),
    NombreGenero VARCHAR(30) NOT NULL,
    CONSTRAINT pk_genero PRIMARY KEY (idGenero),
    CONSTRAINT uq_genero_nombre UNIQUE (NombreGenero)
);
CREATE TABLE Categoria (
    idCategoria INT IDENTITY(1,1),
    NombreCategoria VARCHAR(50) NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY (idCategoria),
    CONSTRAINT uq_categoria_nombre UNIQUE (NombreCategoria)
);
CREATE TABLE Producto (
    CodigoProducto INT IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    PrecioVenta INT NOT NULL,
    PrecioCompra INT NOT NULL,
    StockActual INT DEFAULT 0,
    StockMinimo INT DEFAULT 1,
    Descripcion VARCHAR(255),
    Estado VARCHAR(10) DEFAULT 'ACTIVO',
    idGenero INT NOT NULL,
    idCategoria INT NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY (CodigoProducto),
    CONSTRAINT ck_producto_precioventa CHECK (PrecioVenta > 0),
    CONSTRAINT ck_producto_preciocompra CHECK (PrecioCompra >= 0),
    CONSTRAINT ck_producto_stockactual CHECK (StockActual >= 0),
    CONSTRAINT ck_producto_stockminimo CHECK (StockMinimo >= 0),
    CONSTRAINT ck_producto_estado CHECK (Estado IN ('ACTIVO', 'INACTIVO')),

    CONSTRAINT fk_producto_genero FOREIGN KEY (idGenero) 
        REFERENCES Genero(idGenero),
    CONSTRAINT fk_producto_categoria FOREIGN KEY (idCategoria) 
        REFERENCES Categoria(idCategoria)
);