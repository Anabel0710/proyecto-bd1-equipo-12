# Reglas de negocio

## RN.01 - Registro único de clientes

Cada cliente debe registrarse obligatoriamente con una dirección de correo electrónico única. El sistema no permite dos o más cuentas con el mismo email.

## RN.02 - Congelamiento del precio histórico

Cuando se confirma una compra, el precio unitario del producto debe guardarse de forma fija en el detalle de la venta. Si más adelante el precio de la joya cambia en el catálogo general, las ventas viejas no se modifican y mantienen el valor exacto al que fueron pagadas.

## RN.03 - Control y descuento de stock

No se permite realizar una compra de una joya si la cantidad solicitada supera las existencias físicas disponibles. Al confirmarse el pedido, el stock debe descontarse automáticamente. Si el stock llega a 0 (cero), el producto pasa a estar "Sin Stock" y no puede venderse.

## RN.04 - Alerta de stock bajo

Cada joya tiene un número de stock mínimo definido. Cuando la cantidad restante es menor o igual a ese número, el sistema debe marcarlo con la alerta de "Poco Stock".

## RN.05 - Obligatoriedad del método de pago

Toda orden de compra generada debe registrar obligatoriamente el método de pago utilizado (Transferencia, Tarjeta de Débito, Tarjeta de Crédito o Efectivo).

## RN.06 - Cancelación y devolución de stock

Si una orden de compra pasa al estado "Cancelado", las cantidades de las joyas que estaban en esa orden deben volver a sumarse automáticamente al stock disponible.

## RN.07 - Protección contra eliminación de datos históricos

No se pueden borrar de la base de datos aquellos productos o clientes que ya figuren en una orden de compra realizada, para no romper el historial ni los comprobantes de ventas pasadas.