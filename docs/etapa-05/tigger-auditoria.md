3. TRIGGERS DE AUDITORÍA

## ¿Qué son?

Los triggers (disparadores) son objetos de la base de datos que ejecutan automáticamente un conjunto de instrucciones SQL cuando ocurre un determinado evento sobre una tabla o vista.

En SQL Server, los triggers pueden activarse ante operaciones como "INSERT", "UPDATE" y "DELETE".

A diferencia de los procedimientos almacenados, que deben ser invocados explícitamente, los triggers se ejecutan automáticamente cuando se produce el evento para el cual fueron definidos.

## ¿Por qué utilizarlos?

Los triggers permiten automatizar controles y mantener la trazabilidad de las operaciones realizadas sobre la base de datos.

Entre sus principales ventajas se encuentran:

- Auditoría: permiten registrar quién realizó una modificación o eliminación y cuándo ocurrió.
- Trazabilidad: conservan información sobre los valores anteriores y posteriores a una modificación.
- Integridad: permiten controlar operaciones que podrían afectar información importante.
- Automatización: ejecutan acciones sin necesidad de que el usuario las invoque directamente.
- Control de operaciones: permiten impedir determinadas acciones no autorizadas o no permitidas por las reglas del sistema.

## Funcionamiento en SQL Server

SQL Server proporciona dos tablas lógicas especiales para trabajar con triggers:

- inserted: contiene los nuevos valores generados por una operación "INSERT" o los valores posteriores a una modificación "UPDATE".
- deleted: contiene los valores eliminados por una operación "DELETE" o los valores anteriores a una modificación "UPDATE".

Estas tablas permiten acceder a los datos involucrados en una operación y comparar los valores anteriores y posteriores.

Un trigger también puede responder a más de un evento. Por ejemplo, puede definirse para ejecutarse ante operaciones "UPDATE" y "DELETE", diferenciando cada caso mediante las tablas "inserted" y "deleted".

Caso de aplicación: Sistema de gestión comercial de joyería

## Problema de negocio:

En el sistema de gestión comercial de la joyería, los productos contienen información importante para el control del inventario, como el precio de venta y el stock disponible.

Las modificaciones o eliminaciones de estos datos pueden afectar la información comercial y el seguimiento de los productos. Por otra parte, la eliminación de compras podría provocar la pérdida del historial de adquisiciones realizadas a proveedores.

Para abordar estas situaciones, se implementan dos triggers con objetivos diferentes.

1. Auditoría de productos

Se crea una tabla auxiliar denominada "AuditoriaProducto", destinada a almacenar un historial de las modificaciones y eliminaciones realizadas sobre la tabla "Producto".

La información registrada incluye:

- Código del producto afectado.
- Tipo de operación realizada ("UPDATE" o "DELETE").
- Precio de venta anterior y nuevo.
- Stock anterior y nuevo.
- Fecha y hora de la operación.
- Usuario de SQL Server que realizó la operación.

Trigger: "tr_AuditarProducto"

Se implementa un trigger asociado a los eventos "UPDATE" y "DELETE" de la tabla "Producto".

Su funcionamiento depende del tipo de operación:

- UPDATE: obtiene los valores anteriores mediante "deleted" y los valores nuevos mediante "inserted". Luego, registra ambos estados en "AuditoriaProducto".
- DELETE: obtiene los datos anteriores mediante "deleted" y los almacena en la tabla de auditoría, permitiendo conservar información del producto eliminado.

De esta manera, se mantiene un historial de las operaciones realizadas sobre los productos, incluso cuando estos dejan de existir en la tabla principal.

2. Control de eliminación de compras

Problema de negocio:

Las compras representan adquisiciones realizadas a proveedores. Su eliminación podría afectar la trazabilidad y el historial comercial del sistema.

Trigger: "tr_BloquearEliminacionCompra"

Se implementa un trigger de tipo "INSTEAD OF DELETE" sobre la tabla "Compra".

Este trigger intercepta los intentos de eliminación, muestra un mensaje de advertencia y evita que la operación se realice.

Se utiliza este mecanismo para proteger el historial de compras y evitar la pérdida de información comercial.

Demostración y pruebas

Para comprobar el funcionamiento de los triggers se proponen las siguientes pruebas:

Prueba| Operación| Resultado esperado
1| Modificar el precio de un producto.| Se registra el precio anterior y el nuevo.
2| Modificar el stock de un producto.| Se registra el stock anterior y el nuevo.
3| Eliminar un producto de prueba.| Se conserva su información anterior en la tabla de auditoría.
4| Intentar eliminar una compra.| Se muestra un mensaje y la eliminación es bloqueada.

Para verificar los resultados se consulta la tabla "AuditoriaProducto" y se comprueba que las operaciones de modificación y eliminación hayan quedado registradas correctamente.

## Conclusión

La implementación de triggers permite mejorar la trazabilidad, el control y la confiabilidad de la base de datos del sistema de gestión comercial de la joyería.

El trigger de auditoría permite conservar un historial de las modificaciones y eliminaciones realizadas sobre los productos, mientras que el trigger de control de eliminación protege el historial de compras frente a operaciones no permitidas.

De esta manera, se incorporan mecanismos automáticos que contribuyen a preservar la información y mantener un mayor control sobre las operaciones realizadas en el sistema.