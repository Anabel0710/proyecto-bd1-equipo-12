Etapa 4: Emisión de Comprobante de Venta

1\. Necesidad de información que resuelve

Permite generar el comprobante o factura para el cliente al momento de concretar una compra. La consulta reúne en una sola salida los datos generales de la operación (número, fecha, cliente, vendedor y medio de pago) junto con el desglose de los productos adquiridos, calculando el subtotal por artículo y el importe total general a abonar.

2\. Estrategia SQL utilizada

* Combinación de tablas ('INNER JOIN'): Se integran las tablas 'Comprobante', 'DetalleComprobante', 'Cliente', 'Usuario', 'MedioPago', 'TipoComprobante' y 'Producto' mediante sus claves foráneas para obtener los nombres reales de clientes, vendedores, formas de pago y joyas.
* Funciones de presentación: Se utiliza 'CONCAT()' para unificar el nombre del cliente y del empleado, e 'ISNULL()' para los casos en que el cliente sea una empresa y no posea apellido.
* Cálculo de subtotal: Se multiplica directamente la cantidad por el precio unitario (dc.Cantidad \* dc.PrecioUnitario) en cada renglón.
* Cálculo de total acumulado: Se incorpora una subconsulta sobre la tabla 'DetalleComprobante' con la función 'SUM()', lo que permite calcular el importe total sin alterar el detalle de los productos.
* Filtro puntual ('WHERE'): Se filtra por el identificador del comprobante deseado ('WHERE c.idComprobante = 1') para emitir una operación específica.

USE BD\_Joyeria\_Practica;

GO


SELECT 

 c.idComprobante AS NroComprobante,

 tc.TipoComprobante,

 c.FechaComprobante,

 CONCAT(cli.Nombre, ' ', ISNULL(cli.Apellido, '')) AS Cliente,

cli.DNI\_CUIT AS DocumentoFiscal,

 CONCAT(u.Nombre, ' ', u.Apellido) AS AtendidoPor,

mp.NombreMedioPago AS FormaPago,

 p.Nombre AS Producto,

 dc.Cantidad,

 dc.PrecioUnitario,

 (dc.Cantidad \* dc.PrecioUnitario) AS SubtotalRenglon,

 (

SELECT SUM(d2.Cantidad \* d2.PrecioUnitario) 

 FROM DetalleComprobante d2 

 WHERE d2.idComprobante = c.idComprobante

 ) AS ImporteTotalGeneral

FROM Comprobante c

INNER JOIN TipoComprobante tc ON c.idTipoComprobante = tc.idTipoComprobante

INNER JOIN MedioPago mp ON c.idMedioPago = mp.idMedioPago

INNER JOIN Cliente cli ON c.idCliente = cli.idCliente

INNER JOIN Usuario u ON c.idUsuario = u.idUsuario

INNER JOIN DetalleComprobante dc ON c.idComprobante = dc.idComprobante

INNER JOIN Producto p ON dc.CodigoProducto = p.CodigoProducto

WHERE c.idComprobante = 1;

GO



4\. Resultado esperado

Una grilla donde cada fila representa una joya vendida dentro de la operación, indicando su cantidad, precio unitario, subtotal y el monto total final del comprobante.
