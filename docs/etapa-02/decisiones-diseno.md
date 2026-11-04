# Decisiones de Diseño del Modelo de Datos

Durante el modelado conceptual, lógico y su posterior revisión grupal para la implementación física, el equipo tomó las siguientes decisiones de diseño:

## 1. Descarte de la entidad `Consulta` (Bandeja de mensajes)
En la primera versión del análisis se había contemplado una entidad `Consulta` para almacenar mensajes de visitantes web. Tras la revisión del modelo junto con los requerimientos centrales del negocio, se decidió descartarla del diseño definitivo dado que no aportaba al circuito transaccional ni contable de la joyería (compras, inventario y facturación), priorizando las entidades operativas del local.

## 2. Separación entre el circuito de Compras a Proveedores y Ventas a Clientes
Para reflejar de forma realista la operatoria de la joyería, se diferenciaron los dos flujos principales que afectan al inventario:
* **Abastecimiento (`Proveedor`, `Compra`, `DetalleCompra`, `EstadoCompra`, `Recepcion` y `DetalleRecepcion`):** Permite registrar las órdenes de compra emitidas a proveedores mayoristas y contrastar las unidades pedidas contra las efectivamente recibidas en depósito.
* **Facturación en mostrador (`Cliente`, `CondicionIVA`, `Comprobante`, `DetalleComprobante`, `TipoComprobante` y `MedioPago`):** Permite emitir comprobantes de venta asociando al cliente, su condición frente al IVA, el vendedor que lo atendió y el medio de pago utilizado.

## 3. Conservación del precio histórico en los detalles
Tanto en `DetalleCompra` como en `DetalleComprobante` se almacena explícitamente el atributo `PrecioUnitario` vigente en el instante de la operación. De esta manera, cuando se actualiza el `PrecioVenta` o `PrecioCompra` en la tabla `Producto`, los comprobantes y órdenes históricas mantienen inalterado el valor real al que fueron operados (cumpliendo con la regla de negocio `RN.02`).

## 4. No almacenamiento de subtotales ni totales calculados
En cumplimiento de la Tercera Forma Normal (3FN), se decidió no almacenar columnas de `Subtotal` en los renglones de detalle ni `Total` en las cabeceras de compras o comprobantes. Dichos importes son atributos derivados que se calculan dinámicamente mediante `Cantidad * PrecioUnitario` y `SUM(Cantidad * PrecioUnitario)`, evitando anomalías de actualización e inconsistencias contables.

## 5. Control de inventario y trazabilidad de ajustes (`AjusteStock`)
El stock disponible se controla mediante `StockActual` y `StockMinimo` en la tabla `Producto`, impidiendo valores negativos a través de restricciones `CHECK`. Adicionalmente, se incorporó la entidad `AjusteStock` para auditar mermas, roturas en exhibición o diferencias de inventario físico indicando el empleado responsable (`idUsuario`), la fecha y el motivo.

## 6. Baja lógica mediante estados en lugar de borrado físico
Para cumplir con la regla de negocio `RN.07` (protección del historial comercial), las tablas maestras como `Producto` y `Usuario` incorporan un atributo `Estado` y las relaciones de claves foráneas se definen con `ON DELETE NO ACTION`. Así se evita la eliminación física de registros que ya participaron en operaciones históricas.

## 7. Normalización de catálogos (`Rol`, `Categoria`, `Genero`, `MedioPago`, `EstadoCompra`, `CondicionIVA`, `TipoComprobante`)
Los valores descriptivos repetitivos se extrajeron en tablas catálogo independientes con restricción `UNIQUE` sobre sus nombres, eliminando dependencias transitivas y asegurando la uniformidad en los filtros y reportes.
