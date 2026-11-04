## Etapa 4: Consulta de Negocio Avanzada con Filtro Post-Agregación

1. Necesidad de información que resuelve

La gerencia necesita distinguir a aquellos vendedores que hayan superado un umbral de ventas de $100.000 en el período, con el fin de evaluar comisiones o premios por objetivos. La consulta debe calcular el total vendido por cada empleado y descartar a quienes no alcanzaron dicha meta.



2. Estrategia SQL utilizada

* Combinación de múltiples tablas (INNER JOIN): Se combinan cuatro entidades: 'Usuario' (empleados), 'Rol' (puesto laboral), 'Comprobante' (operación) y 'DetalleComprobante' (artículos y montos).
* Filtro de filas individuales (WHERE): Se limita la consulta únicamente a usuarios activos con el rol de 'Vendedor'.
* Agrupamiento (GROUP BY): Se consolida la información a nivel de cada vendedor mediante su identificador y nombre.
* Filtro de grupos (HAVING): Permite filtrar los resultados a partir de una condición sobre una suma ya calculada ('HAVING SUM(dc.Cantidad \* dc.PrecioUnitario) >= 100000.00'), lo cual no es posible realizar dentro de la cláusula 'WHERE'.
* Presentación ordenada: Se muestran en primer lugar los vendedores con mayor volumen de facturación.



USE BD\_Joyeria\_Practica;

GO



SELECT 

&#x20;   u.idUsuario AS LegajoVendedor,

&#x20;   CONCAT(u.Nombre, ' ', u.Apellido) AS Vendedor,

&#x20;   r.NombreRol AS Puesto,

&#x20;   COUNT(DISTINCT c.idComprobante) AS ComprobantesEmitidos,

&#x20;   SUM(dc.Cantidad \* dc.PrecioUnitario) AS TotalFacturado

FROM Usuario u

INNER JOIN Rol r ON u.idRol = r.idRol

INNER JOIN Comprobante c ON u.idUsuario = c.idUsuario

INNER JOIN DetalleComprobante dc ON c.idComprobante = dc.idComprobante

WHERE r.NombreRol = 'Vendedor' 

&#x20; AND u.Estado = 'Activo'

GROUP BY u.idUsuario, u.Nombre, u.Apellido, r.NombreRol

HAVING SUM(dc.Cantidad \* dc.PrecioUnitario) >= 100000.00

ORDER BY TotalFacturado DESC;

GO



4. Resultado esperado

Una nómina que incluye únicamente a los vendedores que alcanzaron o superaron el objetivo fijado de $100.000, reflejando la cantidad de comprobantes cerrados y el total recaudado por cada uno.