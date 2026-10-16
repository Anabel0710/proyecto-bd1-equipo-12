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


