# Etapa III: Restricciones de Integridad Implementadas

Para garantizar la consistencia, exactitud y confiabilidad de los datos en **`BD_JoyeriaAlba`**, se implementaron restricciones declarativas en las 18 tablas del modelo dentro del script [sql/ddl/crear_bd.sql](../../sql/ddl/crear_bd.sql).

---

## 1. Integridad de Entidad (`PRIMARY KEY` e `IDENTITY`)

Todas las tablas cuentan con una clave primaria simple numérica autoincremental (`INT IDENTITY(1,1) NOT NULL`), lo que asegura que cada fila sea única e irrepetible y evita el uso de claves naturales susceptibles a cambios:

| Módulo | Tablas y Claves Primarias (`PK`) |
| :--- | :--- |
| **Seguridad y Usuarios** | `Rol (IdRol)`, `Usuario (IdUsuario)` |
| **Catálogo e Inventario** | `Genero (idGenero)`, `Categoria (idCategoria)`, `Producto (CodigoProducto)`, `AjusteStock (idAjuste)` |
| **Compras y Recepción** | `MedioPago (IdMedioPago)`, `EstadoCompra (IdEstadoCompra)`, `Proveedor (IdProveedor)`, `Compra (IdCompra)`, `DetalleCompra (IdDetalleCompra)`, `Recepcion (idRecepcion)`, `DetalleRecepcion (idDetalleRecepcion)` |
| **Ventas y Clientes** | `CondicionIVA (idCondicionIVA)`, `TipoComprobante (idTipoComprobante)`, `Cliente (idCliente)`, `Comprobante (idComprobante)`, `DetalleComprobante (idDetalleComprobante)` |

---

## 2. Integridad de Dominio (`NOT NULL`, `UNIQUE`, `DEFAULT` y `CHECK`)

### 2.1. Módulo de Roles y Usuarios
* **`UNIQUE`:**
  * `UQ_NombreRol`: Impide duplicar nombres de perfiles en `Rol`.
  * `UQ_DNIUsuario`, `UQ_NombreUsuario` y `UQ_EmailUsuario`: Garantizan que no existan dos usuarios con el mismo DNI, login o correo electrónico (cumpliendo la regla `RN.01`).
* **`CHECK` y `DEFAULT`:**
  * `CK_EstadoUsuario`: Restringe el campo `Estado` únicamente a `'Activo'` o `'Inactivo'`.
  * `DF_EstadoUsuario`: Asigna `'Activo'` por defecto al dar de alta un usuario.

### 2.2. Módulo de Catálogo de Joyas e Inventario
* **`UNIQUE`:**
  * `uq_genero_nombre` en `Genero` y `uq_categoria_nombre` en `Categoria`.
* **`CHECK` y `DEFAULT` en `Producto`:**
  * `ck_producto_precioventa`: Exige que el precio de venta sea estrictamente positivo (`PrecioVenta > 0`).
  * `ck_producto_preciocompra`: Impide costos negativos (`PrecioCompra >= 0`).
  * `ck_producto_stockactual` y `ck_producto_stockminimo`: Impiden existencias negativas (`StockActual >= 0`, `StockMinimo >= 0`), cumpliendo con `RN.04`.
  * `ck_producto_estado`: Limita los estados válidos del artículo (`'Disponible'`, `'Agotado'`, `'Discontinuado'`, `'ACTIVO'`, `'INACTIVO'`).
  * Valores por defecto: `StockActual DEFAULT 0`, `StockMinimo DEFAULT 1`.
* **`CHECK` y `DEFAULT` en `AjusteStock`:**
  * `ck_ajustestock_cantidad`: Impide registrar un ajuste neutro de cero unidades (`CantidadAjuste <> 0`).
  * `FechaAjuste DEFAULT GETDATE()`: Registra automáticamente la fecha y hora exacta del ajuste.

### 2.3. Módulo de Compras, Proveedores y Recepción
* **`UNIQUE`:**
  * `UQ_CUIT` en `Proveedor`: Evita registrar dos veces al mismo proveedor mayorista.
  * `UQ_NombreMedioPago` en `MedioPago` y `UQ_NombreEstadoCompra` en `EstadoCompra`.
* **`CHECK`:**
  * `CK_Telefono` en `Proveedor`: Valida mediante expresión regular (`Telefono NOT LIKE '%[^0-9]%'`) que el teléfono contenga únicamente dígitos numéricos.
  * `CK_DetalleCompra_Cantidad` (`Cantidad > 0`) y `CK_DetalleCompra_Precio` (`PrecioUnitario >= 0`) en `DetalleCompra`.
  * `ck_detallerecepcion_cantidad` (`CantidadRecibida >= 0`) en `DetalleRecepcion`.

### 2.4. Módulo de Clientes, Ventas y Facturación
* **`UNIQUE`:**
  * `uq_cliente_documento` en `Cliente`: Garantiza la unicidad del `DNI_CUIT`.
  * `uq_condicioniva` en `CondicionIVA` y `uq_tipocomprobante` en `TipoComprobante`.
* **`CHECK` y `DEFAULT`:**
  * `ck_cliente_email`: Valida que el correo electrónico del cliente respete el formato `@` y punto (`CorreoElectronico LIKE '%@%.%' OR CorreoElectronico IS NULL`).
  * `ck_detallecomprobante_cantidad` (`Cantidad > 0`) y `ck_detallecomprobante_precio` (`PrecioUnitario >= 0`) en `DetalleComprobante`.
  * `FechaComprobante DEFAULT GETDATE()` en `Comprobante`.

---

## 3. Integridad Referencial (`FOREIGN KEY`)

Todas las relaciones entre tablas están resguardadas por restricciones `FOREIGN KEY` con política **`ON DELETE NO ACTION`**:
* Impide borrar físicamente roles, categorías, géneros, proveedores, clientes, usuarios o productos que ya tengan historial de compras, recepciones, ajustes o comprobantes de venta asociados (cumpliendo la regla `RN.07` de preservación histórica).
* Obliga a que todo renglón de detalle (`DetalleComprobante`, `DetalleCompra`, `DetalleRecepcion`) esté vinculado a una cabecera válida existente.
