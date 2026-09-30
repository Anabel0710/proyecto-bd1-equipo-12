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
