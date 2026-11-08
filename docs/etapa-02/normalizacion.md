# Proceso de Normalización

## 1. Introducción

El proceso de normalización se aplicó sobre el modelo de datos de **Joyería ALBA** con el propósito de erradicar redundancias, evitar anomalías de inserción, modificación y borrado, y asegurar que cada atributo se ubique en la relación que le corresponde según sus dependencias funcionales.

El diseño se analizó rigurosamente pasando por la **Primera Forma Normal (1FN)**, **Segunda Forma Normal (2FN)** y alcanzando plenamente la **Tercera Forma Normal (3FN)** en sus 18 relaciones.

---

## 2. Estructura Inicial No Normalizada (0FN)

Si la operatoria comercial de la joyería se almacenara en una única estructura plana sin normalizar, tendríamos una tabla semejante a:

```text
OPERACION_COMERCIAL(
    nro_transaccion,
    fecha_operacion,
    tipo_operacion,         -- 'COMPRA' o 'VENTA'
    dni_cuit_sujeto,
    nombre_razon_social,
    condicion_iva_o_estado,
    contacto_sujeto,
    medio_pago,
    empleado_responsable,
    productos_codigos,      -- [Lista repetitiva]
    productos_nombres,      -- [Lista repetitiva]
    categorias,             -- [Lista repetitiva]
    generos,                -- [Lista repetitiva]
    cantidades,             -- [Lista repetitiva]
    precios_unitarios,      -- [Lista repetitiva]
    subtotales,             -- [Valores calculables]
    total_operacion         -- [Valor calculable]
)
```

### Problemas identificados en 0FN:
* **Grupos repetitivos:** Cada transacción contiene listas de productos, cantidades y precios.
* **Redundancia severa:** Los datos del cliente, proveedor o empleado se repetirían en cada operación.
* **Riesgo de inconsistencias:** Modificar el precio o descripción de un producto obligaría a alterar miles de filas históricas.
* **Anomalías de borrado:** Si se eliminara la única venta registrada de un cliente, se perderían sus datos de contacto y condición frente al IVA.

---

## 3. Primera Forma Normal (1FN)

> **Definición:** Una relación está en 1FN si y solo si todos sus atributos contienen valores atómicos (indivisibles), no existen grupos repetitivos y existe una clave primaria definida.

### Acciones aplicadas:
1. **Descomposición de grupos repetitivos:** Se separaron las cabeceras de las operaciones de sus renglones de detalle.
2. **Creación de relaciones intermedias:**
   * En compras: se dividió en `Compra` (cabecera) y `DetalleCompra` (ítems individuales).
   * En recepciones: se dividió en `Recepcion` (cabecera de entrega) y `DetalleRecepcion` (cantidades físicas).
   * En ventas: se dividió en `Comprobante` (cabecera de factura) y `DetalleComprobante` (renglones de venta).
3. **Atomicidad de datos:** Nombres, apellidos y domicilios se estructuraron en campos individuales atómicos.

---

## 4. Segunda Forma Normal (2FN)

> **Definición:** Una relación está en 2FN si está en 1FN y ningún atributo no clave depende funcionalmente de una parte de la clave primaria (eliminación de dependencias parciales sobre claves compuestas).

### Acciones aplicadas:
1. **Adopción de Claves Primarias Simples:** Para optimizar el rendimiento y evitar dependencias parciales, las tablas de detalle (`DetalleComprobante`, `DetalleCompra`, `DetalleRecepcion`) adoptaron claves primarias artificiales autoincrementales (`idDetalleComprobante`, `IdDetalleCompra`, `idDetalleRecepcion`).
2. **Aislamiento de entidades maestras:**
   * La descripción, categoría y género del producto no dependen de la transacción de venta, sino exclusivamente del producto. Por ello se desacoplaron en la tabla `Producto`.
   * Los datos de proveedores y clientes se desacoplaron de las compras y comprobantes hacia `Proveedor` y `Cliente`.

---

## 5. Tercera Forma Normal (3FN)

> **Definición:** Una relación está en 3FN si está en 2FN y no existen dependencias transitivas entre atributos que no formen parte de la clave (es decir, ningún atributo no clave debe depender de otro atributo no clave: $X \rightarrow Y \rightarrow Z$).

### Acciones aplicadas en Joyería ALBA:

1. **Desacoplamiento de Catálogos e Impuestos:**
   * En `Cliente`, el atributo `idCondicionIVA` determinaba la alícuota o tipo impositivo. Se extrajo la tabla `CondicionIVA(idCondicionIVA, CondicionIVA)`.
   * En `Comprobante`, el tipo de documento determinaba normativas de facturación. Se extrajo `TipoComprobante(idTipoComprobante, TipoComprobante)`.
   * En `Compra`, los estados del pedido dependían entre sí. Se extrajo `EstadoCompra(IdEstadoCompra, NombreEstadoCompra)`.
   * En `Producto`, la clasificación por rubro y género se normalizó en `Categoria` y `Genero`.
   * En `Usuario`, los perfiles de permiso se normalizaron en `Rol`.
2. **Eliminación de Atributos Derivados (Calculables):**
   * Se eliminaron las columnas `Subtotal` en los detalles y `Total` en las cabeceras. En 3FN, no deben almacenarse importes que puedan calcularse dinámicamente mediante $Cantidad \times PrecioUnitario$ y $\sum(Cantidad \times PrecioUnitario)$.
3. **Preservación del Precio Histórico:**
   * En `DetalleComprobante` y `DetalleCompra` se mantiene el atributo `PrecioUnitario`. Esto no constituye redundancia, sino un dato histórico inmutable: refleja el valor pactado en el instante temporal de la transacción, independiente de las posteriores modificaciones en `Producto.PrecioVenta`.

---

## 6. Esquema Final Normalizado en 3FN (18 Relaciones)

El esquema final normalizado queda constituido por:

1. **`Rol`** (`IdRol` PK, `NombreRol` UK)
2. **`Usuario`** (`IdUsuario` PK, `Nombre`, `Apellido`, `DNI` UK, `NombreUsuario` UK, `Contrasenia`, `Email` UK, `Estado`, `Domicilio`, `Telefono`, `IdRol` FK)
3. **`Categoria`** (`idCategoria` PK, `NombreCategoria` UK)
4. **`Genero`** (`idGenero` PK, `NombreGenero` UK)
5. **`Producto`** (`CodigoProducto` PK, `Nombre`, `PrecioVenta`, `PrecioCompra`, `StockActual`, `StockMinimo`, `Descripcion`, `Estado`, `idGenero` FK, `idCategoria` FK)
6. **`Proveedor`** (`IdProveedor` PK, `RazonSocial`, `CUIT` UK, `Telefono`, `CorreoElectronico`)
7. **`EstadoCompra`** (`IdEstadoCompra` PK, `NombreEstadoCompra`)
8. **`MedioPago`** (`IdMedioPago` PK, `NombreMedioPago`)
9. **`Compra`** (`IdCompra` PK, `FechaCompra`, `IdUsuario` FK, `IdProveedor` FK, `IdEstadoCompra` FK, `IdMedioPago` FK)
10. **`DetalleCompra`** (`IdDetalleCompra` PK, `IdCompra` FK, `Cantidad`, `PrecioUnitario`, `IdProducto` FK)
11. **`Recepcion`** (`idRecepcion` PK, `FechaRecepcion`, `idCompra` FK, `idUsuario` FK)
12. **`DetalleRecepcion`** (`idDetalleRecepcion` PK, `CantidadRecibida`, `idRecepcion` FK, `idDetalleCompra` FK)
13. **`CondicionIVA`** (`idCondicionIVA` PK, `CondicionIVA` UK)
14. **`Cliente`** (`idCliente` PK, `Nombre`, `Apellido`, `DNI_CUIT` UK, `Telefono`, `CorreoElectronico`, `idCondicionIVA` FK)
15. **`TipoComprobante`** (`idTipoComprobante` PK, `TipoComprobante` UK)
16. **`Comprobante`** (`idComprobante` PK, `FechaComprobante`, `idMedioPago` FK, `idTipoComprobante` FK, `idCliente` FK, `idUsuario` FK)
17. **`DetalleComprobante`** (`idDetalleComprobante` PK, `idComprobante` FK, `Cantidad`, `PrecioUnitario`, `CodigoProducto` FK)
18. **`AjusteStock`** (`idAjuste` PK, `FechaAjuste`, `TipoAjuste`, `CantidadAjuste`, `Observacion`, `idUsuario` FK, `CodigoProducto` FK)

---

## 7. Conclusión

El proceso de normalización aplicado garantiza que:
* Cada hecho se registre exactamente una sola vez.
* Se mantenga la integridad referencial y temporal de las ventas y compras.
* El modelo sea escalable, previniendo errores de concurrencia y facilitando la consulta ágil mediante índices y vistas SQL.
