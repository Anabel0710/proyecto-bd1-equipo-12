## =====OPTIMIZACIÓN DE CONSULTAS A TRAVÉS DE INDICES=====

Este proceso se basa en la optimización de costos, donde el motor evalúa múltiples planes equivalentes y selecciona el que consume la menor cantidad de recursos. El proceso de procesamiento de consultas sigue la secuencia: Parsing y Traducción, Optimización, Ejecución. 

Índice: es una estructura de datos secundaria en disco que permite al motor localizar registros específicos sin tener que recorrer toda la tabla. 

Agrupado: define el orden físico de almacenamiento de los datos en la tabla. Solo puede existir uno por tabla (asociado generalmente a la PRIMARY KEY).

No Agrupado: estructura separada de los datos de la tabla que contiene punteros hacia la tabla base. 

Índice de Cobertura: índice no agrupado que incluye (mediante la clausula INCLUDE) todas las columnas que solicita una consulta. Permite responder la búsqueda directamente desde el índice sin tocar la tabla base. 

## METRICAS DE RENDIMIETO

Para medir el impacto de un índice se analizan las siguientes métricas:

  1.Plan de Ejecución: evolución de un TABLE SCAN hacia un CLAUSTERED INDEX SEEK o INDEX SEEK (búsqueda directa puntual o por rango). 

  2.Lecturas Lógicas: cantidad de paginas de memoria de 8KB leídas por el motor para resolver la consulta. 

  3.Tiempos de CPU y Transcurrido: milisegundos requeridos por el procesador y tiempo total de ejecución.  

## Utilizar los índices aporta estos beneficios:
**Mejoran el rendimiento de las consultas de búsqueda.
**Reducen los tiempos de respuesta en tablas con grandes volúmenes de datos.
**Disminuyen la cantidad de lecturas que realiza el motor de base de datos.
**Permiten optimizar filtros por fechas, códigos, clientes, productos, entre otros. 
**Facilitan la escalabilidad de sistemas con grandes cantidades de información.
