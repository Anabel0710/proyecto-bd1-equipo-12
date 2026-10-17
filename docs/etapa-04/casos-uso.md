\# Etapa 4: Casos de Uso y Consultas de Negocio



En este documento se presentan las necesidades de información habituales que se le presentan al personal de la joyería en su día a día (sin incluir ventas directas), explicando cómo se resuelven mediante consultas SQL.



Caso de Uso 1: Control de stock crítico para reposición de mercadería



1\. Necesidad de información que resuelve

El encargado del depósito o el dueño necesita saber urgentemente qué joyas se están agotando para no quedarse sin mercadería. Para eso, debe ver todos los productos cuya cantidad disponible sea menor o igual al stock mínimo de seguridad definido para el local.



2\. Estrategia SQL utilizada

* Tablas involucradas: 'Producto', 'Categoría' y 'Genero'.
* Relaciones: Se combinan con 'INNER JOIN' para mostrar el nombre real de la categoría (anillo, pulsera, etc.) y a qué género corresponde en lugar de mostrar números de ID.
* Filtros: Se aplica una condición en el 'WHERE' comparando si 'StockActual <= StockMinimo', asegurando además que el producto esté con estado 'Disponible'.
* Ordenamiento:\*\* Se ordenan de menor a mayor por existencia actual (`ORDER BY StockActual ASC`).



Código SQL

```sql

USE BD\_Joyeria\_Practica;

GO



SELECT 

&#x20;   p.CodigoProducto,

&#x20;   p.Nombre AS Producto,

&#x20;   c.NombreCategoria AS Categoria,

&#x20;   g.NombreGenero AS Genero,

&#x20;   p.StockActual,

&#x20;   p.StockMinimo,

&#x20;   (p.StockMinimo - p.StockActual) AS UnidadesAFaltantes

FROM Producto p

INNER JOIN Categoria c ON p.idCategoria = c.idCategoria

INNER JOIN Genero g ON p.idGenero = g.idGenero

WHERE p.StockActual <= p.StockMinimo 

&#x20; AND p.Estado = 'Disponible'

ORDER BY p.StockActual ASC;



USE BD\_Joyeria\_Practica;

GO



SELECT 

&#x20;   -- 1. Datos del Encabezado

&#x20;   c.idComprobante AS NroFactura,

&#x20;   tc.TipoComprobante,

&#x20;   c.FechaComprobante,

&#x20;   -- Usamos CONCAT e ISNULL para armar el nombre prolijo

&#x20;   CONCAT(cli.Nombre, ' ', ISNULL(cli.Apellido, '')) AS NombreCliente,

&#x20;   cli.DNI\_CUIT AS DocumentoCliente,

&#x20;   CONCAT(u.Nombre, ' ', u.Apellido) AS AtendidoPor,

&#x20;   mp.NombreMedioPago AS MetodoPago,



&#x20;

3\. Resultado esperado

Una lista clara con el código del producto, su nombre, categoría, a quién va dirigido, cuánto stock queda y cuánto es el mínimo tolerable, facilitando armar la lista de reposición de inmediato.





Caso de Uso 2: Auditoría y seguimiento de ajustes manuales de stock



1\. Necesidad de información que resuelve

Ante la pérdida, rotura o diferencia física de piezas valiosas de joyería, la administración necesita auditar quién hizo modificaciones manuales de stock, en qué fecha exacta, qué producto se vio afectado y cuál fue el motivo ingresado.



2\. Estrategia SQL utilizada

* Tablas involucradas: 'AjusteStock', 'Usuario' y 'Producto'.
* Relaciones: 'INNER JOIN' entre los ajustes, el empleado responsable (Usuario) y la joya implicada (Producto).
* Columnas seleccionadas: Fecha del ajuste, nombre y apellido del usuario que lo cargó, nombre de la joya, si sumó o restó unidades ('CantidadAjuste') y el texto de la observación.
* Ordenamiento: En orden cronológico descendente ('ORDER BY FechaAjuste DESC') para revisar primero los movimientos más recientes.



SELECT 

&#x20;   a.idAjuste,

&#x20;   a.FechaAjuste,

&#x20;   CONCAT(u.Nombre, ' ', u.Apellido) AS EmpleadoResponsable,

&#x20;   u.Usuario AS LoginUsuario,

&#x20;   p.Nombre AS ProductoAfectado,

&#x20;   a.TipoAjuste,

&#x20;   a.CantidadAjuste,

&#x20;   a.Observacion

FROM AjusteStock a

INNER JOIN Usuario u ON a.idUsuario = u.idUsuario

INNER JOIN Producto p ON a.CodigoProducto = p.CodigoProducto

ORDER BY a.FechaAjuste DESC;



\### 3. Resultado esperado

Un registro transparente de novedades de depósito que permite detectar irregularidades o fallas de manipulación de mercadería sin depender de anotaciones en papel.





Caso de Uso 3: Verificación de cumplimiento de entregas de proveedores



1\. Necesidad de información que resuelve

El área de compras necesita comprobar si los pedidos realizados a los proveedores llegaron completos o si hubo faltantes en los paquetes recibidos en el local.



2\. Estrategia SQL utilizada

* Tablas involucradas: 'Compra', 'Proveedor', 'DetalleCompra', 'Recepcion' y 'DetalleRecepcion'.
* Relaciones: Se cruzan las cabeceras y detalles de las compras con sus respectivos remitos de recepción física.
* Comparación: Se contrasta en una columna la 'Cantidad' pedida originalmente contra la 'CantidadRecibida' registrada en el depósito.
* Filtros: Se puede evaluar órdenes puntuales o filtrar aquellas donde la cantidad recibida sea menor a la solicitada.



SELECT 

&#x20;   c.idCompra AS NroOrdenCompra,

&#x20;   pr.RazonSocial AS Proveedor,

&#x20;   p.Nombre AS Producto,

&#x20;   dc.Cantidad AS CantidadPedida,

&#x20;   dr.CantidadRecibida,

&#x20;   (dc.Cantidad - dr.CantidadRecibida) AS DiferenciaFaltante,

&#x20;   r.FechaRecepcion

FROM Compra c

INNER JOIN Proveedor pr ON c.idProveedor = pr.idProveedor

INNER JOIN DetalleCompra dc ON c.idCompra = dc.idCompra

INNER JOIN DetalleRecepcion dr ON dc.idDetalleCompra = dr.idDetalleCompra

INNER JOIN Recepcion r ON dr.idRecepcion = r.idRecepcion

INNER JOIN Producto p ON dc.CodigoProducto = p.CodigoProducto

ORDER BY c.idCompra ASC;



&#x20;3. Resultado esperado

Un listado donde se visualiza el número de orden de compra, el proveedor, el producto entregado, cuántas piezas se pidieron y cuántas entraron realmente a stock, permitiendo hacer reclamos comerciales precisos.





