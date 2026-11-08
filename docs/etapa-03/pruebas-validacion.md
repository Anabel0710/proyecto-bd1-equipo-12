# Etapa III: Pruebas de Carga y Validación de Integridad

Los scripts de creación ([sql/ddl/crear_bd.sql](../../sql/ddl/crear_bd.sql)) y de carga inicial ([sql/dml/datos_prueba.sql](../../sql/dml/datos_prueba.sql)) fueron ejecutados y verificados en **Microsoft SQL Server** sobre la base de datos **`BD_JoyeriaAlba`**.

---

## 1. Resumen de Lotes de Datos de Prueba Cargados

Se poblaron las **18 tablas** del modelo superando el umbral mínimo de 8 registros por tabla y respetando el orden de dependencias referenciales:

| Nº | Tabla | Registros Cargados | Descripción de los datos de prueba |
| :-: | :--- | :-: | :--- |
| 1 | `Rol` | **8** | Perfiles administrativos, comerciales, técnicos y clientes |
| 2 | `Usuario` | **10** | Personal de mostrador, depósito, administración y usuarios registrados |
| 3 | `Genero` | **10** | Clasificaciones por público (Masculino, Femenino, Unisex, Infantil, etc.) |
| 4 | `Categoria` | **10** | Rubros de joyería (Anillo, Collar, Aro, Pulsera, Reloj, Cadena, etc.) |
| 5 | `Producto` | **10** | Piezas de oro 18k, plata 925 y acero con precios y stock realistas |
| 6 | `MedioPago` | **8** | Efectivo, tarjetas, transferencia, Mercado Pago, cheque, divisas |
| 7 | `EstadoCompra` | **8** | Estados del ciclo de abastecimiento (Pendiente a Recibida Conforme) |
| 8 | `Proveedor` | **8** | Mayoristas de metales, gemas y orfebrería con CUIT y teléfono válido |
| 9 | `Compra` | **8** | Órdenes de compra emitidas a los proveedores |
| 10 | `DetalleCompra` | **8** | Renglones de productos solicitados con su costo unitario |
| 11 | `CondicionIVA` | **8** | Categorías fiscales ante AFIP/ARCA |
| 12 | `TipoComprobante` | **8** | Facturas A/B/C, Tickets y Notas de Crédito/Débito |
| 13 | `Cliente` | **8** | Compradores particulares y corporativos con DNI/CUIT único |
| 14 | `AjusteStock` | **8** | Registros de auditoría por roturas, mermas y recuentos físicos |
| 15 | `Recepcion` | **8** | Remitos de ingreso de mercadería en depósito |
| 16 | `DetalleRecepcion` | **8** | Cantidades recibidas vinculadas a cada renglón de compra |
| 17 | `Comprobante` | **8** | Facturas y tickets emitidos en mostrador |
| 18 | `DetalleComprobante` | **10** | Artículos vendidos con su precio unitario histórico congelado |

---

## 2. Consultas de Verificación de Carga

Para comprobar que las 18 tablas quedaron correctamente pobladas en `BD_JoyeriaAlba`, se ejecutó el siguiente control de recuento:

```sql
USE BD_JoyeriaAlba;
GO

SELECT 'Rol' AS Tabla, COUNT(*) AS Cantidad FROM Rol
UNION ALL SELECT 'Usuario', COUNT(*) FROM Usuario
UNION ALL SELECT 'Genero', COUNT(*) FROM Genero
UNION ALL SELECT 'Categoria', COUNT(*) FROM Categoria
UNION ALL SELECT 'Producto', COUNT(*) FROM Producto
UNION ALL SELECT 'MedioPago', COUNT(*) FROM MedioPago
UNION ALL SELECT 'EstadoCompra', COUNT(*) FROM EstadoCompra
UNION ALL SELECT 'Proveedor', COUNT(*) FROM Proveedor
UNION ALL SELECT 'Compra', COUNT(*) FROM Compra
UNION ALL SELECT 'DetalleCompra', COUNT(*) FROM DetalleCompra
UNION ALL SELECT 'CondicionIVA', COUNT(*) FROM CondicionIVA
UNION ALL SELECT 'TipoComprobante', COUNT(*) FROM TipoComprobante
UNION ALL SELECT 'Cliente', COUNT(*) FROM Cliente
UNION ALL SELECT 'AjusteStock', COUNT(*) FROM AjusteStock
UNION ALL SELECT 'Recepcion', COUNT(*) FROM Recepcion
UNION ALL SELECT 'DetalleRecepcion', COUNT(*) FROM DetalleRecepcion
UNION ALL SELECT 'Comprobante', COUNT(*) FROM Comprobante
UNION ALL SELECT 'DetalleComprobante', COUNT(*) FROM DetalleComprobante;
GO
```

---

## 3. Pruebas de Validación de Restricciones (Casos de Rechazo)

Se verificó el correcto disparo de las restricciones de integridad intentando insertar o modificar datos inválidos:

### 3.1. Prueba de Unicidad (`UNIQUE`)
* **Caso probado:** Intento de registrar un segundo usuario con un DNI o Email ya existente (`'40111222'`), o un proveedor con un CUIT repetido (`'30711234568'`).
* **Resultado en SQL Server:** Operación rechazada por violación de la restricción `UQ_DNIUsuario` / `UQ_CUIT`, impidiendo duplicados.

### 3.2. Prueba de Dominio (`CHECK`)
* **Caso probado:** Intento de insertar un producto con `StockActual = -5` o `PrecioVenta = 0`, y un proveedor con letras en el campo `Telefono`.
* **Resultado en SQL Server:** Operación bloqueada por las restricciones `ck_producto_stockactual`, `ck_producto_precioventa` y `CK_Telefono`.

```sql
-- Ejemplo de prueba de rechazo por CHECK de stock negativo:
INSERT INTO Producto (Nombre, PrecioVenta, PrecioCompra, StockActual, StockMinimo, Estado, idGenero, idCategoria)
VALUES ('Anillo Prueba Error', 50000, 25000, -5, 1, 'ACTIVO', 1, 4);
-- Mensaje devuelto por SQL Server:
-- The INSERT statement conflicted with the CHECK constraint "ck_producto_stockactual".
```

### 3.3. Prueba de Integridad Referencial (`FOREIGN KEY`)
* **Caso probado:** Intento de insertar un renglón en `DetalleComprobante` apuntando a un `CodigoProducto = 9999` inexistente, o intento de eliminar un `Rol` o `Producto` que ya posee registros asociados.
* **Resultado en SQL Server:** Operación rechazada por las restricciones `fk_detallecomprobante_producto` y `FK_Usuario_Rol` (`ON DELETE NO ACTION`), resguardando la trazabilidad histórica de la base de datos.
