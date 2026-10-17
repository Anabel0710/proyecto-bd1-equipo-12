Etapa 4: Reporte Agregado de Ventas por Categoría



1\. Necesidad de información que resuelve

La dirección de la joyería requiere evaluar las ventas por rubro durante un período determinado (mes de octubre de 2026). La finalidad es conocer qué categorías de productos concentran la mayor demanda, cuántas operaciones comerciales se concretaron y qué suma de dinero aportó cada una al negocio.



2\. Estrategia SQL utilizada

* Combinación de tablas ('INNER JOIN'): Se relacionan las tablas 'Categoria', 'Producto', 'DetalleComprobante' y 'Comprobante' para asociar las líneas de venta con su rubro correspondiente.
* Filtrado previo (WHERE):  Se acota el rango de fechas de las facturas antes de agrupar, reduciendo la cantidad de registros a procesar.
* Agrupamiento (GROUP BY): Se segmenta la información por el código y el nombre de la categoría. Todas las columnas del 'SELECT' que no forman parte de una función de cálculo se incluyen en esta cláusula.
* Funciones de agregación: 

\*COUNT(DISTINCT comp.idComprobante)': Cuenta la cantidad de 	comprobantes distintos emitidos para la categoría.

\*SUM(dc.Cantidad): Suma el total de piezas físicas despachadas.

\*SUM(dc.Cantidad \* dc.PrecioUnitario)': Totaliza los ingresos 	económicos generados.

* Ordenamiento: Se ordenan los rubros de mayor a menor según la recaudación obtenida (ORDER BY TotalRecaudado DESC).



USE BD\_Joyeria\_Practica;

GO



SELECT 

  cat.NombreCategoria AS Categoria,

   COUNT(DISTINCT comp.idComprobante) AS OperacionesRealizadas,

   SUM(dc.Cantidad) AS UnidadesVendidas,

   SUM(dc.Cantidad \* dc.PrecioUnitario) AS TotalRecaudado

FROM Categoria cat

INNER JOIN Producto p ON cat.idCategoria = p.idCategoria

INNER JOIN DetalleComprobante dc ON p.CodigoProducto = dc.CodigoProducto

INNER JOIN Comprobante comp ON dc.idComprobante = comp.idComprobante

WHERE comp.FechaComprobante >= '20261001' 

 AND comp.FechaComprobante <= '20261031 23:59:59'

GROUP BY cat.idCategoria, cat.NombreCategoria

ORDER BY TotalRecaudado DESC;

GO



4\. Resultado esperado

Una tabla de resumen donde cada fila muestra una categoría de joyas, detallando la cantidad de comprobantes en los que participó, las unidades vendidas en el mes y el monto total facturado.
