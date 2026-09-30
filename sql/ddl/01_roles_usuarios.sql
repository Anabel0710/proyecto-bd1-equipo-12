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