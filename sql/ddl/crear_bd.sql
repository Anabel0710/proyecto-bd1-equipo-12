/* =========================================================
   ARCHIVO: 01_roles_usuarios.sql
   ========================================================= */
USE BD_Joyeria_Practica;
GO

/* =========================================================
   TABLA: Rol
   Almacena los roles disponibles para los usuarios.
   ========================================================= */

CREATE TABLE Rol (
    IdRol INT IDENTITY(1,1) NOT NULL,
    NombreRol VARCHAR(50) NOT NULL,

    CONSTRAINT PK_IdRol
        PRIMARY KEY (IdRol),

    CONSTRAINT UQ_NombreRol
        UNIQUE (NombreRol)
);
GO


/* =========================================================
   TABLA: Usuario
   Almacena los clientes y el personal registrado.
   Cada usuario posee un único rol.
   ========================================================= */

CREATE TABLE Usuario (
    IdUsuario INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(60) NOT NULL,
    Apellido VARCHAR(60) NOT NULL,
    DNI VARCHAR(10) NOT NULL,
    NombreUsuario VARCHAR(50) NOT NULL,
    Contrasenia VARCHAR(255) NOT NULL,
    Email VARCHAR(120) NOT NULL,
    Estado VARCHAR(10) NOT NULL
        CONSTRAINT DF_EstadoUsuario DEFAULT 'Activo',
    Domicilio VARCHAR(150) NULL,
    Telefono VARCHAR(25) NULL,
    IdRol INT NOT NULL,

    CONSTRAINT PK_IdUsuario
        PRIMARY KEY (IdUsuario),

    CONSTRAINT UQ_DNIUsuario
        UNIQUE (DNI),

    CONSTRAINT UQ_NombreUsuario
        UNIQUE (NombreUsuario),

    CONSTRAINT UQ_EmailUsuario
        UNIQUE (Email),

    CONSTRAINT CK_EstadoUsuario
        CHECK (Estado IN ('Activo', 'Inactivo')),

    CONSTRAINT FK_Usuario_Rol
        FOREIGN KEY (IdRol)
        REFERENCES Rol (IdRol)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);
GO

/* =========================================================
   ARCHIVO: 02_productos_categorias_generos.sql
   ========================================================= */
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
GO

/* =========================================================
   ARCHIVO: 03_proveedor_mediopago_estadocompra.sql
   ========================================================= */
USE master;
GO

-- 1. Crear una base de datos 100% nueva y aislada
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'BD_Joyeria_Practica')
BEGIN
    CREATE DATABASE BD_Joyeria_Practica;
END
GO

-- 2. Posicionarnos en la base nueva
USE BD_Joyeria_Practica;
GO

CREATE TABLE MedioPago (
IdMedioPago INT IDENTITY (1,1),
NombreMedioPago VARCHAR(50) NOT NULL, 
CONSTRAINT PK_IdMedioPago PRIMARY KEY (IdMedioPago)
);
GO

CREATE TABLE EstadoCompra (
IdEstadoCompra INT IDENTITY (1,1), 
NombreEstadoCompra VARCHAR(50) NOT NULL,
CONSTRAINT PK_IdEstadoCompra PRIMARY KEY (IdEstadoCompra)
);
GO

CREATE TABLE Proveedor (
IdProveedor INT IDENTITY (1,1),
RazonSocial VARCHAR (125) NOT NULL,
CUIT VARCHAR(11) NOT NULL,
Telefono VARCHAR(25) NOT NULL,
CorreoElectronico VARCHAR(255), 
CONSTRAINT PK_IdProveedor PRIMARY KEY (IdProveedor),
CONSTRAINT UQ_CUIT UNIQUE (CUIT),
CONSTRAINT CK_Telefono CHECK (Telefono NOT LIKE '%[^0-9]%')
);
GO

/* =========================================================
   ARCHIVO: 04_compra_detalleCompra.sql
   ========================================================= */
USE BD_Joyeria_Practica;
GO

CREATE TABLE Compra (
    IdCompra INT IDENTITY(1,1),
    FechaCompra DATETIME NOT NULL,
    IdUsuario INT NOT NULL,
    IdProveedor INT NOT NULL,
    IdEstadoCompra INT NOT NULL,
    IdMedioPago INT NOT NULL,
    CONSTRAINT PK_Compra PRIMARY KEY (IdCompra),
  --  CONSTRAINT FK_Compra_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
  --  CONSTRAINT FK_Compra_Proveedor FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor),
  --  CONSTRAINT FK_Compra_EstadoCompra FOREIGN KEY (IdEstadoCompra) REFERENCES EstadoCompra(IdEstadoCompra),
  --  CONSTRAINT FK_Compra_MedioPago FOREIGN KEY (IdMedioPago) REFERENCES MedioPago(IdMedioPago)
);
GO

CREATE TABLE DetalleCompra (
    IdDetalleCompra INT IDENTITY(1,1),
    IdCompra INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(12,2) NOT NULL,
    IdProducto INT NOT NULL,
    CONSTRAINT PK_DetalleCompra PRIMARY KEY (IdDetalleCompra),
    CONSTRAINT FK_DetalleCompra_Compra FOREIGN KEY (IdCompra) REFERENCES Compra(IdCompra),
  --  CONSTRAINT FK_DetalleCompra_Producto FOREIGN KEY (CodigoProducto) REFERENCES Producto(CodigoProducto)
);
GO
