/* =========================================================
   SISTEMA DE GESTIÓN COMERCIAL Y CONTROL DE INVENTARIO
   PROYECTO: Joyería ALBA (Equipo 12)
   BASE DE DATOS: BD_JoyeriaAlba
   DDL UNIFICADO - 18 TABLAS
   ========================================================= */

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'BD_JoyeriaAlba')
BEGIN
    CREATE DATABASE BD_JoyeriaAlba;
END
GO

USE BD_JoyeriaAlba;
GO

/* =========================================================
   1. MÓDULO DE USUARIOS Y ROLES
   ========================================================= */

-- 1.1 Rol
CREATE TABLE Rol (
    IdRol INT IDENTITY(1,1) NOT NULL,
    NombreRol VARCHAR(50) NOT NULL,

    CONSTRAINT PK_IdRol
        PRIMARY KEY (IdRol),

    CONSTRAINT UQ_NombreRol
        UNIQUE (NombreRol)
);
GO

-- 1.2 Usuario
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
   2. MÓDULO DE CATÁLOGO E INVENTARIO
   ========================================================= */

-- 2.1 Genero
CREATE TABLE Genero (
    idGenero INT IDENTITY(1,1),
    NombreGenero VARCHAR(30) NOT NULL,
    CONSTRAINT pk_genero PRIMARY KEY (idGenero),
    CONSTRAINT uq_genero_nombre UNIQUE (NombreGenero)
);
GO

-- 2.2 Categoria
CREATE TABLE Categoria (
    idCategoria INT IDENTITY(1,1),
    NombreCategoria VARCHAR(50) NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY (idCategoria),
    CONSTRAINT uq_categoria_nombre UNIQUE (NombreCategoria)
);
GO

-- 2.3 Producto
CREATE TABLE Producto (
    CodigoProducto INT IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    PrecioVenta DECIMAL(10,2) NOT NULL,
    PrecioCompra DECIMAL(10,2) NOT NULL,
    StockActual INT DEFAULT 0,
    StockMinimo INT DEFAULT 1,
    Descripcion VARCHAR(255) NULL,
    Estado VARCHAR(20) DEFAULT 'Disponible',
    idGenero INT NOT NULL,
    idCategoria INT NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY (CodigoProducto),
    CONSTRAINT ck_producto_precioventa CHECK (PrecioVenta > 0),
    CONSTRAINT ck_producto_preciocompra CHECK (PrecioCompra >= 0),
    CONSTRAINT ck_producto_stockactual CHECK (StockActual >= 0),
    CONSTRAINT ck_producto_stockminimo CHECK (StockMinimo >= 0),
    CONSTRAINT ck_producto_estado CHECK (Estado IN ('Disponible', 'Agotado', 'Discontinuado', 'ACTIVO', 'INACTIVO')),

    CONSTRAINT fk_producto_genero FOREIGN KEY (idGenero) 
        REFERENCES Genero(idGenero),
    CONSTRAINT fk_producto_categoria FOREIGN KEY (idCategoria) 
        REFERENCES Categoria(idCategoria)
);
GO

-- 2.4 Ajuste de Stock
CREATE TABLE AjusteStock (
    idAjuste INT IDENTITY(1,1),
    FechaAjuste DATETIME NOT NULL DEFAULT GETDATE(),
    TipoAjuste VARCHAR(30) NOT NULL,
    CantidadAjuste INT NOT NULL,
    Observacion VARCHAR(250) NULL,
    idUsuario INT NOT NULL,
    CodigoProducto INT NOT NULL,
    CONSTRAINT pk_ajustestock PRIMARY KEY (idAjuste),
    CONSTRAINT ck_ajustestock_cantidad CHECK (CantidadAjuste <> 0),
    CONSTRAINT fk_ajustestock_usuario FOREIGN KEY (idUsuario) 
        REFERENCES Usuario(IdUsuario) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION,
    CONSTRAINT fk_ajustestock_producto FOREIGN KEY (CodigoProducto) 
        REFERENCES Producto(CodigoProducto) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION
);
GO

/* =========================================================
   3. MÓDULO DE COMPRAS Y RECEPCIÓN
   ========================================================= */

-- 3.1 Medio de Pago
CREATE TABLE MedioPago (
    IdMedioPago INT IDENTITY(1,1),
    NombreMedioPago VARCHAR(50) NOT NULL, 
    CONSTRAINT PK_IdMedioPago PRIMARY KEY (IdMedioPago),
    CONSTRAINT UQ_NombreMedioPago UNIQUE (NombreMedioPago)
);
GO

-- 3.2 Estado de Compra
CREATE TABLE EstadoCompra (
    IdEstadoCompra INT IDENTITY(1,1), 
    NombreEstadoCompra VARCHAR(50) NOT NULL,
    CONSTRAINT PK_IdEstadoCompra PRIMARY KEY (IdEstadoCompra),
    CONSTRAINT UQ_NombreEstadoCompra UNIQUE (NombreEstadoCompra)
);
GO

-- 3.3 Proveedor
CREATE TABLE Proveedor (
    IdProveedor INT IDENTITY(1,1),
    RazonSocial VARCHAR(125) NOT NULL,
    CUIT VARCHAR(11) NOT NULL,
    Telefono VARCHAR(25) NOT NULL,
    CorreoElectronico VARCHAR(255) NULL, 
    CONSTRAINT PK_IdProveedor PRIMARY KEY (IdProveedor),
    CONSTRAINT UQ_CUIT UNIQUE (CUIT),
    CONSTRAINT CK_Telefono CHECK (Telefono NOT LIKE '%[^0-9]%')
);
GO

-- 3.4 Compra (Cabecera)
CREATE TABLE Compra (
    IdCompra INT IDENTITY(1,1),
    FechaCompra DATETIME NOT NULL DEFAULT GETDATE(),
    IdUsuario INT NOT NULL,
    IdProveedor INT NOT NULL,
    IdEstadoCompra INT NOT NULL,
    IdMedioPago INT NOT NULL,
    CONSTRAINT PK_Compra PRIMARY KEY (IdCompra),
    CONSTRAINT FK_Compra_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
    CONSTRAINT FK_Compra_Proveedor FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor),
    CONSTRAINT FK_Compra_EstadoCompra FOREIGN KEY (IdEstadoCompra) REFERENCES EstadoCompra(IdEstadoCompra),
    CONSTRAINT FK_Compra_MedioPago FOREIGN KEY (IdMedioPago) REFERENCES MedioPago(IdMedioPago)
);
GO

-- 3.5 Detalle de Compra (Renglones)
CREATE TABLE DetalleCompra (
    IdDetalleCompra INT IDENTITY(1,1),
    IdCompra INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(12,2) NOT NULL,
    IdProducto INT NOT NULL,
    CONSTRAINT PK_DetalleCompra PRIMARY KEY (IdDetalleCompra),
    CONSTRAINT CK_DetalleCompra_Cantidad CHECK (Cantidad > 0),
    CONSTRAINT CK_DetalleCompra_Precio CHECK (PrecioUnitario >= 0),
    CONSTRAINT FK_DetalleCompra_Compra FOREIGN KEY (IdCompra) REFERENCES Compra(IdCompra),
    CONSTRAINT FK_DetalleCompra_Producto FOREIGN KEY (IdProducto) REFERENCES Producto(CodigoProducto)
);
GO

-- 3.6 Recepción (Cabecera de Ingreso a Depósito)
CREATE TABLE Recepcion (
    idRecepcion INT IDENTITY(1,1),
    FechaRecepcion DATETIME NOT NULL DEFAULT GETDATE(),
    idCompra INT NOT NULL,
    idUsuario INT NOT NULL,
    CONSTRAINT pk_recepcion PRIMARY KEY (idRecepcion),
    CONSTRAINT fk_recepcion_compra FOREIGN KEY (idCompra) 
        REFERENCES Compra(IdCompra) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION,
    CONSTRAINT fk_recepcion_usuario FOREIGN KEY (idUsuario) 
        REFERENCES Usuario(IdUsuario) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION
);
GO

-- 3.7 Detalle de Recepción (Cantidades Físicas Ingresadas)
CREATE TABLE DetalleRecepcion (
    idDetalleRecepcion INT IDENTITY(1,1),
    CantidadRecibida INT NOT NULL,
    idRecepcion INT NOT NULL,
    idDetalleCompra INT NOT NULL,
    CONSTRAINT pk_detallerecepcion PRIMARY KEY (idDetalleRecepcion),
    CONSTRAINT ck_detallerecepcion_cantidad CHECK (CantidadRecibida >= 0),
    CONSTRAINT fk_detallerecepcion_recepcion FOREIGN KEY (idRecepcion) 
        REFERENCES Recepcion(idRecepcion) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION,
    CONSTRAINT fk_detallerecepcion_detallecompra FOREIGN KEY (idDetalleCompra) 
        REFERENCES DetalleCompra(IdDetalleCompra) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION
);
GO

/* =========================================================
   4. MÓDULO DE VENTAS Y FACTURACIÓN
   ========================================================= */

-- 4.1 Condición frente al IVA
CREATE TABLE CondicionIVA (
    idCondicionIVA INT IDENTITY(1,1),
    CondicionIVA VARCHAR(50) NOT NULL,
    CONSTRAINT pk_condicioniva PRIMARY KEY (idCondicionIVA),
    CONSTRAINT uq_condicioniva UNIQUE (CondicionIVA)
);
GO

-- 4.2 Tipo de Comprobante
CREATE TABLE TipoComprobante (
    idTipoComprobante INT IDENTITY(1,1),
    TipoComprobante VARCHAR(50) NOT NULL,
    CONSTRAINT pk_tipocomprobante PRIMARY KEY (idTipoComprobante),
    CONSTRAINT uq_tipocomprobante UNIQUE (TipoComprobante)
);
GO

-- 4.3 Cliente
CREATE TABLE Cliente (
    idCliente INT IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DNI_CUIT VARCHAR(20) NOT NULL,
    Telefono VARCHAR(20) NULL,
    CorreoElectronico VARCHAR(100) NULL,
    idCondicionIVA INT NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (idCliente),
    CONSTRAINT uq_cliente_documento UNIQUE (DNI_CUIT),
    CONSTRAINT ck_cliente_email CHECK (CorreoElectronico LIKE '%@%.%' OR CorreoElectronico IS NULL),
    CONSTRAINT fk_cliente_condicioniva FOREIGN KEY (idCondicionIVA) 
        REFERENCES CondicionIVA(idCondicionIVA) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION
);
GO

-- 4.4 Comprobante (Cabecera de Venta)
CREATE TABLE Comprobante (
    idComprobante INT IDENTITY(1,1),
    FechaComprobante DATETIME NOT NULL DEFAULT GETDATE(),
    idMedioPago INT NOT NULL,
    idTipoComprobante INT NOT NULL,
    idCliente INT NOT NULL,
    idUsuario INT NOT NULL,
    CONSTRAINT pk_comprobante PRIMARY KEY (idComprobante),
    CONSTRAINT fk_comprobante_mediopago FOREIGN KEY (idMedioPago) 
        REFERENCES MedioPago(IdMedioPago) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION,
    CONSTRAINT fk_comprobante_tipocomprobante FOREIGN KEY (idTipoComprobante) 
        REFERENCES TipoComprobante(idTipoComprobante) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION,
    CONSTRAINT fk_comprobante_cliente FOREIGN KEY (idCliente) 
        REFERENCES Cliente(idCliente) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION,
    CONSTRAINT fk_comprobante_usuario FOREIGN KEY (idUsuario) 
        REFERENCES Usuario(IdUsuario) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION
);
GO

-- 4.5 Detalle de Comprobante (Renglones de Venta)
CREATE TABLE DetalleComprobante (
    idDetalleComprobante INT IDENTITY(1,1),
    idComprobante INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    CodigoProducto INT NOT NULL,
    CONSTRAINT pk_detallecomprobante PRIMARY KEY (idDetalleComprobante),
    CONSTRAINT ck_detallecomprobante_cantidad CHECK (Cantidad > 0),
    CONSTRAINT ck_detallecomprobante_precio CHECK (PrecioUnitario >= 0),
    CONSTRAINT fk_detallecomprobante_comprobante FOREIGN KEY (idComprobante) 
        REFERENCES Comprobante(idComprobante) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION,
    CONSTRAINT fk_detallecomprobante_producto FOREIGN KEY (CodigoProducto) 
        REFERENCES Producto(CodigoProducto) 
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION
);
GO
