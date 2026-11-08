# Etapa III: Implementación Física del Modelo de Datos

Durante la Etapa III se llevó a cabo la construcción física de las **18 tablas** del modelo relacional en **Microsoft SQL Server** dentro de la base de datos **`BD_JoyeriaAlba`**.

La implementación se estructuró en **4 módulos funcionales**, garantizando que las tablas padre (catálogos independientes) se creen antes que las entidades intermedias y transaccionales que dependen de ellas mediante claves foráneas (`FOREIGN KEY`).

---

## 1. Módulo de Roles y Usuarios (Seguridad y Accesos)

* **Tablas implementadas:** `Rol` y `Usuario`.
* **Descripción funcional:**
  * La tabla `Rol` almacena los perfiles operativos disponibles dentro del sistema (*Administrador*, *Vendedor*, *Encargado de inventario*, *Cliente*, *Gerente Comercial*, *Cajero*, *Auditor Contable* y *Orfebre / Taller*).
  * La tabla `Usuario` registra los datos personales, credenciales de acceso y estado de las personas registradas en la joyería. Cada usuario se vincula obligatoriamente con un único rol mediante la clave foránea `IdRol`.
  * *Nota de evolución del diseño:* La tabla `Consulta` (contemplada en un boceto preliminar) fue descartada en la revisión grupal para priorizar el circuito contable y de inventario.

---

## 2. Módulo de Catálogo de Joyas e Inventario

* **Tablas implementadas:** `Genero`, `Categoria`, `Producto` y `AjusteStock`.
* **Descripción funcional:**
  * `Genero` clasifica el público objetivo de cada pieza (*Masculino*, *Femenino*, *Unisex*, *Infantil*, etc.).
  * `Categoria` clasifica el tipo de alhaja (*Collar*, *Aro*, *Dije*, *Anillo*, *Pulsera*, *Reloj*, *Cadena*, *Gemelos*, *Tobillera*, *Rosario*).
  * `Producto` constituye la tabla maestra del catálogo comercial. Almacena nombre, descripción, `PrecioVenta`, `PrecioCompra`, `StockActual`, `StockMinimo` y `Estado`, relacionándose con `Genero` y `Categoria`.
  * `AjusteStock` permite asentar movimientos manuales o extraordinarios de inventario (roturas en vitrina, mermas, hallazgos en recuento físico), registrando la fecha, el empleado responsable (`idUsuario`) y la joya afectada (`CodigoProducto`).

---

## 3. Módulo de Abastecimiento, Compras y Recepción

* **Tablas implementadas:** `MedioPago`, `EstadoCompra`, `Proveedor`, `Compra`, `DetalleCompra`, `Recepcion` y `DetalleRecepcion`.
* **Descripción funcional:**
  * `MedioPago` cataloga las formas de pago habilitadas (*Efectivo*, *Tarjeta de Débito*, *Tarjeta de Crédito*, *Transferencia Bancaria*, *Mercado Pago*, *Cheque*, etc.).
  * `EstadoCompra` define el ciclo de vida de los pedidos a mayoristas (*Pendiente*, *Aprobada*, *En Preparación*, *Despachada*, *Recibida Conforme*, *Cancelada*, etc.).
  * `Proveedor` almacena la razón social, `CUIT` único y datos de contacto de los fabricantes y mayoristas.
  * `Compra` y `DetalleCompra` registran las órdenes de compra emitidas por el personal de la joyería y los artículos solicitados junto con su costo unitario pactado (`PrecioUnitario`).
  * `Recepcion` y `DetalleRecepcion` registran el ingreso físico real de las joyas al depósito del local, permitiendo contrastar la cantidad pedida contra la `CantidadRecibida`.

---

## 4. Módulo de Clientes, Ventas y Facturación

* **Tablas implementadas:** `CondicionIVA`, `TipoComprobante`, `Cliente`, `Comprobante` y `DetalleComprobante`.
* **Descripción funcional:**
  * `CondicionIVA` clasifica la situación fiscal del comprador frente a AFIP/ARCA (*Consumidor Final*, *Responsable Inscripto*, *Monotributo*, *Exento*, etc.).
  * `TipoComprobante` cataloga los documentos respaldatorios (*Factura A*, *Factura B*, *Ticket Consumidor Final*, *Nota de Crédito*, etc.).
  * `Cliente` almacena los datos identificatorios (`DNI_CUIT` único), contacto y condición frente al IVA de los compradores.
  * `Comprobante` y `DetalleComprobante` registran las operaciones de venta en mostrador, vinculando al cliente, al vendedor (`idUsuario`), el medio de pago, el tipo de comprobante y los renglones vendidos con su `PrecioUnitario` histórico congelado.

---

## 5. Scripts Relacionados

* **Definición de Datos (DDL):** [sql/ddl/crear_bd.sql](../../sql/ddl/crear_bd.sql)
* **Carga de Datos de Prueba (DML):** [sql/dml/datos_prueba.sql](../../sql/dml/datos_prueba.sql)
