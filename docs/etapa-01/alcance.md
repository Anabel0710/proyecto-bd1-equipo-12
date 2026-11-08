# Alcance del sistema

El sistema abarca los siguientes puntos:

## Gestión de catálogo y categorías

Registro y control de las joyas (nombre, descripción, género al que pertenece, precio de compra y venta, y categoría asignada).

## Control de existencias y ajustes de inventario

Descuento automático de cantidades vendidas, control de stock mínimo para reposición y registro de movimientos manuales o extraordinarios (mermas, roturas y ajustes de inventario) mediante la tabla `AjusteStock`.

## Registro de clientes, proveedores y personal

Almacenamiento de los datos de las personas y entidades vinculadas al negocio:
* **Personal y usuarios:** Roles de acceso (`Rol`, `Usuario`) con autenticación, estado activo/inactivo y datos de contacto.
* **Clientes:** Datos fiscales, de contacto y condición frente al IVA (`Cliente`, `CondicionIVA`).
* **Proveedores:** Datos comerciales, CUIT y contacto de los mayoristas (`Proveedor`).

## Circuito de compras a proveedores y recepción

Emisión de órdenes de compra con estado de seguimiento (`Compra`, `DetalleCompra`, `EstadoCompra`), y control de la recepción física efectiva de mercadería en depósito (`Recepcion`, `DetalleRecepcion`).

## Circuito de ventas y facturación en mostrador

Emisión de comprobantes de venta (`Comprobante`, `DetalleComprobante`), asociación del tipo de comprobante legal (`TipoComprobante`), cliente atendido, empleado responsable y método de pago utilizado (`MedioPago`), congelando el precio histórico en cada operación.
