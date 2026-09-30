USE BD_Joyeria_Practica;
GO

/* =========================================================
   TABLA: Rol
   Almacena los roles que pueden asignarse a los usuarios.
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
   Almacena los usuarios registrados en el sistema.
   ========================================================= */

CREATE TABLE Usuario (
    IdUsuario INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(60) NOT NULL,
    Apellido VARCHAR(60) NOT NULL,
    Email VARCHAR(120) NOT NULL,
    Contrasenia VARCHAR(255) NOT NULL,
    IdRol INT NOT NULL,

    CONSTRAINT PK_IdUsuario
        PRIMARY KEY (IdUsuario),

    CONSTRAINT UQ_EmailUsuario
        UNIQUE (Email),

    CONSTRAINT FK_Usuario_Rol
        FOREIGN KEY (IdRol)
        REFERENCES Rol (IdRol)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);
GO


/* =========================================================
   TABLA: Consulta
   Registra los mensajes enviados por usuarios o visitantes.
   IdUsuario puede ser NULL cuando el remitente no está
   registrado en el sistema.
   ========================================================= */

CREATE TABLE Consulta (
    IdConsulta INT IDENTITY(1,1) NOT NULL,
    NombreRemitente VARCHAR(120) NOT NULL,
    EmailRemitente VARCHAR(120) NOT NULL,
    FechaHora DATETIME2 NOT NULL
        CONSTRAINT DF_FechaHoraConsulta
        DEFAULT SYSDATETIME(),

    Estado VARCHAR(20) NOT NULL
        CONSTRAINT DF_EstadoConsulta
        DEFAULT 'Pendiente',

    Mensaje VARCHAR(1000) NOT NULL,
    IdUsuario INT NULL,

    CONSTRAINT PK_IdConsulta
        PRIMARY KEY (IdConsulta),

    CONSTRAINT CK_EstadoConsulta
        CHECK (Estado IN ('Pendiente', 'Leida', 'Respondida')),

    CONSTRAINT FK_Consulta_Usuario
        FOREIGN KEY (IdUsuario)
        REFERENCES Usuario (IdUsuario)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);
GO