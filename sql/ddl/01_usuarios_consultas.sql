-- =====================================================
-- Equipo 12
-- Sistema de Gestión Comercial y Control de Inventario
-- para Joyería
-- Etapa III - Implementación física
-- Módulo: roles, usuarios y consultas
-- Responsable: Gonzalez Rocío Anabel
-- Motor: Microsoft SQL Server
-- =====================================================

-- La tabla ROL se crea primero porque USUARIO
-- necesita referenciarla mediante una clave foránea.

CREATE TABLE dbo.ROL (
    id_rol INT IDENTITY(1,1) NOT NULL,
    nombre_rol NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_ROL
        PRIMARY KEY (id_rol),

    CONSTRAINT UK_ROL_nombre
        UNIQUE (nombre_rol)
);
GO

-- Cada usuario posee obligatoriamente un rol.
-- El email es obligatorio y no puede repetirse.

CREATE TABLE dbo.USUARIO (
    id_usuario INT IDENTITY(1,1) NOT NULL,
    nombre NVARCHAR(60) NOT NULL,
    apellido NVARCHAR(60) NOT NULL,
    email NVARCHAR(120) NOT NULL,
    contrasenia NVARCHAR(255) NOT NULL,
    id_rol INT NOT NULL,

    CONSTRAINT PK_USUARIO
        PRIMARY KEY (id_usuario),

    CONSTRAINT UK_USUARIO_email
        UNIQUE (email),

    CONSTRAINT FK_USUARIO_ROL
        FOREIGN KEY (id_rol)
        REFERENCES dbo.ROL (id_rol)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);
GO

-- La clave foránea id_usuario admite NULL porque
-- una consulta puede ser enviada por un visitante.

CREATE TABLE dbo.CONSULTA (
    id_consulta INT IDENTITY(1,1) NOT NULL,
    nombre_remitente NVARCHAR(120) NOT NULL,
    email_remitente NVARCHAR(120) NOT NULL,
    fecha_hora DATETIME2 NOT NULL,

    estado NVARCHAR(20) NOT NULL
        CONSTRAINT DF_CONSULTA_estado
        DEFAULT N'Pendiente',

    mensaje NVARCHAR(500) NOT NULL,
    id_usuario INT NULL,

    CONSTRAINT PK_CONSULTA
        PRIMARY KEY (id_consulta),

    CONSTRAINT CHK_CONSULTA_estado
        CHECK (
            estado IN (
                N'Pendiente',
                N'Respondida',
                N'Cerrada'
            )
        ),

    CONSTRAINT FK_CONSULTA_USUARIO
        FOREIGN KEY (id_usuario)
        REFERENCES dbo.USUARIO (id_usuario)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);
GO