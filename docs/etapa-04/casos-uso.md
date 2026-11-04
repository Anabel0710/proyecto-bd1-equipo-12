# Etapa IV: Casos de Uso y Consultas de Negocio

En este documento se presentan las necesidades de información habituales que se le presentan al personal de la joyería en su día a día (sin incluir ventas directas), explicando cómo se resuelven mediante consultas SQL diseñadas sobre el modelo de datos `BD_JoyeriaAlba`.

---

## Caso de Uso 1: Control de Stock y Detección de Existencias Bajas

### 1. Necesidad de información que resuelve
El encargado del depósito o el dueño del local necesita identificar rápidamente qué piezas de joyería cuentan con pocas unidades disponibles para planificar las compras antes de que se agoten por completo. Para ello, se busca listar los artículos cuyo stock físico sea menor o igual a un umbral operativo de 10 unidades.

### 2. Estrategia SQL utilizada
* **Tablas involucradas:** `Producto`, `Categoria` y `Genero`.
* **Relaciones:** Se combinan mediante `INNER JOIN` para mostrar el nombre descriptivo de la categoría (anillo, pulsera, collar, etc.) y a qué género corresponde, en lugar de mostrar los códigos numéricos foráneos.
* **Filtros:** Se aplica una condición en la cláusula `WHERE` evaluando `StockActual <= 10` y verificando que el artículo figure con estado `'Disponible'`.
* **Cálculo:** Se calcula la columna `UnidadesParaNivelOptimo` ($15 - \text{StockActual}$) para estimar cuántas unidades faltan para alcanzar un lote ideal de 15 piezas.
* **Ordenamiento:** Se ordenan de forma ascendente según las unidades disponibles (`ORDER BY StockActual ASC`) para que los productos más urgentes aparezcan primero.

### 3. Código SQL
```sql
USE BD_JoyeriaAlba;
GO

SELECT
    p.CodigoProducto,
    p.Nombre AS Producto,
    c.NombreCategoria AS Categoria,
    g.NombreGenero AS Genero,
    p.StockActual,
    p.StockMinimo,
    (15 - p.StockActual) AS UnidadesParaNivelOptimo
FROM Producto p
INNER JOIN Categoria c ON p.idCategoria = c.idCategoria
INNER JOIN Genero g ON p.idGenero = g.idGenero
WHERE p.StockActual <= 10 
  AND p.Estado = 'Disponible'
ORDER BY p.StockActual ASC;
GO
```

### 4. 
**Resultado obtenido:**  
La consulta devuelve un listado de los 4 productos con menor existencia física en el local (Cadena Singapur con 5 unidades, Collar de Perlas con 6, Alianza Tradicional con 8 y Reloj Cronógrafo con 10). Muestra de forma clara la categoría, el género correspondiente y calcula con exactitud las unidades necesarias para reponer y alcanzar un nivel de stock seguro, facilitando la toma de decisiones para compras.

---

## Caso de Uso 2: Auditoría y Seguimiento de Ajustes Manuales de Stock

### 1. Necesidad de información que resuelve
Ante diferencias de inventario, roturas en exhibición o pérdidas de piezas valiosas, la administración necesita auditar quién realizó modificaciones directas en el stock, en qué fecha exacta, sobre qué joya y con qué justificación comercial o técnica.

### 2. Estrategia SQL utilizada
* **Tablas involucradas:** `AjusteStock`, `Usuario` y `Producto`.
* **Relaciones:** Se utiliza `INNER JOIN` entre la tabla de movimientos de ajuste, el empleado responsable (`Usuario`) y la pieza involucrada (`Producto`).
* **Columnas seleccionadas:** Identificador del ajuste, fecha del movimiento, nombre y apellido del usuario responsable, nombre de usuario de login, nombre del producto, cantidad alterada (`CantidadAjuste`, positiva o negativa) y el motivo ingresado en `Observacion`.
* **Ordenamiento:** Cronológico descendente (`ORDER BY FechaAjuste DESC`) para auditar en primer lugar las modificaciones más recientes.

### 3. Código SQL
```sql
USE BD_JoyeriaAlba;
GO

SELECT
    a.idAjuste,
    a.FechaAjuste,
    CONCAT(u.Nombre, ' ', u.Apellido) AS EmpleadoResponsable,
    u.Usuario AS LoginUsuario,
    p.Nombre AS ProductoAfectado,
    a.TipoAjuste,
    a.CantidadAjuste,
    a.Observacion
FROM AjusteStock a
INNER JOIN Usuario u ON a.idUsuario = u.idUsuario
INNER JOIN Producto p ON a.CodigoProducto = p.CodigoProducto
ORDER BY a.FechaAjuste DESC;
GO
```

### 4. 
**Resultado obtenido:**  
Se obtiene una sábana de auditoría ordenada cronológicamente de manera descendente. Permite identificar al personal responsable de cada modificación manual (como Valeria Gómez, Lucía Fernández o Marcos Duarte), el artículo comprometido, la cantidad debitada o acreditada en el inventario y el motivo asentado (ej. rotura en exhibición, pérdida de engarce o conciliación física).
---

## Caso de Uso 3: Verificación de Cumplimiento de Entregas de Proveedores

### 1. Necesidad de información que resuelve
El área de compras necesita controlar el estado de las órdenes emitidas a proveedores de joyería, contrastando las cantidades pactadas contractualmente contra las piezas efectivamente recibidas e ingresadas a depósito, detectando entregas pendientes o faltantes.

### 2. Estrategia SQL utilizada
* **Tablas involucradas:** `Compra`, `Proveedor`, `DetalleCompra`, `Producto`, `DetalleRecepcion` y `Recepcion`.
* **Relaciones principales:** `INNER JOIN` entre la orden de compra, el proveedor correspondiente, sus renglones de pedido y la joya solicitada.
* **Preservación de registros no recibidos:** Se implementa `LEFT JOIN` hacia `DetalleRecepcion` y `Recepcion`. De este modo, si una orden de compra aún no tuvo remito de recepción ingresado, no desaparece del reporte.
* **Tratamiento de nulos y cálculo:** Mediante `ISNULL(dr.CantidadRecibida, 0)` se asume 0 para aquellas piezas sin entrega registrada, calculando la diferencia pendiente como `(dc.Cantidad - ISNULL(dr.CantidadRecibida, 0))`.
* **Ordenamiento:** Secuencial por número de orden de compra (`ORDER BY c.idCompra ASC`).

### 3. Código SQL
```sql
USE BD_JoyeriaAlba;
GO

SELECT
    c.idCompra AS NroOrdenCompra,
    pr.RazonSocial AS Proveedor,
    p.Nombre AS Producto,
    dc.Cantidad AS CantidadPedida,
    ISNULL(dr.CantidadRecibida, 0) AS CantidadRecibida,
    (dc.Cantidad - ISNULL(dr.CantidadRecibida, 0)) AS DiferenciaFaltante,
    r.FechaRecepcion
FROM Compra c
INNER JOIN Proveedor pr ON c.idProveedor = pr.idProveedor
INNER JOIN DetalleCompra dc ON c.idCompra = dc.idCompra
INNER JOIN Producto p ON dc.CodigoProducto = p.CodigoProducto
LEFT JOIN DetalleRecepcion dr ON dc.idDetalleCompra = dr.idDetalleCompra
LEFT JOIN Recepcion r ON dr.idRecepcion = r.idRecepcion
ORDER BY c.idCompra ASC;
GO
```

### 4. 
**Resultado obtenido:**  
El listado cruza de forma integral las órdenes de compra con los comprobantes de recepción física en depósito. En las operaciones registradas se constata un cumplimiento del 100% por parte de los proveedores (como Metales Argentinos o Piedras & Gemas Norte), reflejando una diferencia de 0 unidades pendientes de entrega y registrando la fecha formal en la que ingresaron los lotes.
