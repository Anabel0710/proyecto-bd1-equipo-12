# Sistema de Gestión Comercial y Control de Inventario para Joyería

Proyecto desarrollado para la asignatura **Bases de Datos I** de la Licenciatura en Sistemas de Información de la FaCENA – UNNE.

## Equipo

**Equipo 12**

### Integrantes

* Rodriguez Mercedes Antonella
* Gonzalez Rocío Anabel
* Delgado Maria Florencia
* Demetri Luciana Itati

## Descripción del proyecto

El proyecto consiste en el diseño, normalización e implementación de una base de datos relacional (**`BD_JoyeriaAlba`**) para **Joyería ALBA**, un comercio especializado en la venta de piezas de alta gama como anillos, aretes, pulseras, relojes y collares.

El sistema permite registrar y organizar de forma íntegra las operaciones comerciales e internas de la joyería: administración del catálogo de productos, control de existencias disponibles y auditoría de ajustes manuales de inventario, gestión de órdenes de compra a proveedores mayoristas y su recepción física en depósito, registro de clientes y personal del local, y emisión de comprobantes de venta preservando los precios históricos de cada transacción.

## Objetivos

* Administrar el catálogo de joyas, sus categorías y géneros.
* Controlar el stock actual, el stock mínimo y los ajustes manuales de inventario de cada producto.
* Evitar ventas cuando no exista stock suficiente y auditar automáticamente cambios sensibles.
* Administrar usuarios, roles y permisos de acceso según el principio de mínimo privilegio.
* Gestionar proveedores, órdenes de compra de mercadería y su recepción en depósito.
* Registrar comprobantes de venta con uno o varios productos asociados a clientes y vendedores.
* Conservar el precio unitario histórico de cada operación comercial (compras y ventas).
* Asociar cada operación con su medio de pago, condición frente al IVA y tipo de comprobante correspondiente.
* Mantener la integridad referencial, seguridad transaccional y consistencia de la información.
* Alcanzar la Tercera Forma Normal (3FN) y optimizar consultas masivas mediante índices.

## Arquitectura del Modelo de Datos (`BD_JoyeriaAlba` – 18 Tablas)

| Módulo Funcional | Tablas que lo componen | Propósito principal |
| :--- | :--- | :--- |
| **1. Seguridad y Usuarios** | `Rol`, `Usuario` | Gestión de perfiles, credenciales, datos personales y estado del personal y usuarios |
| **2. Catálogo e Inventario** | `Genero`, `Categoria`, `Producto`, `AjusteStock` | Clasificación de alhajas, precios vigentes, control de existencias y trazabilidad de mermas/ajustes |
| **3. Compras y Recepción** | `Proveedor`, `EstadoCompra`, `MedioPago`, `Compra`, `DetalleCompra`, `Recepcion`, `DetalleRecepcion` | Pedidos a mayoristas, seguimiento de estados y control de ingreso físico de mercadería a depósito |
| **4. Clientes y Facturación** | `CondicionIVA`, `TipoComprobante`, `Cliente`, `Comprobante`, `DetalleComprobante` | Gestión fiscal de compradores y emisión de facturas/tickets en mostrador con precio histórico |

## Etapas del proyecto

### Etapa 1 – Requerimientos

Contiene la descripción del caso de estudio, el alcance funcional del sistema, las reglas de negocio y las decisiones iniciales de diseño.

### Etapa 2 – Modelado conceptual y lógico

Contiene:
* Diagrama Entidad-Relación (DER) conceptual.
* Diagrama y especificación del Modelo Relacional de 18 tablas con identificación de claves primarias, foráneas y únicas.
* Proceso de normalización paso a paso (1FN, 2FN y 3FN).
* Decisiones de diseño del modelo de datos.

### Etapa 3 – Implementación

Contiene los scripts DDL (`crear_bd.sql`) y DML (`datos_prueba.sql`) necesarios para crear y poblar las 18 tablas de la base de datos `BD_JoyeriaAlba` en Microsoft SQL Server (con un mínimo de 8 a 10 registros por tabla), junto con la documentación de las restricciones de integridad y las pruebas de validación.

### Etapa 4 – Consultas

Contiene los casos de uso operativos y las consultas SQL correspondientes a control de stock crítico, auditoría de ajustes, cumplimiento de proveedores, emisión de comprobantes de venta, informes agregados de ventas por categoría y consultas de negocio avanzadas.

### Etapa 5 – Temas técnicos

Contiene el desarrollo teórico, implementación práctica en T-SQL y capturas de evidencia en SQL Server Express de:
1. Procedimientos almacenados y funciones definidas por el usuario (UDF).
2. Transacciones simples y transacciones anidadas (`BEGIN TRAN`, `COMMIT`, `ROLLBACK`, `TRY...CATCH`).
3. Triggers de auditoría y protección de borrado histórico (`inserted`, `deleted`, `INSTEAD OF`).
4. Seguridad a nivel de usuarios, roles personalizados y encapsulamiento mediante procedimientos.
5. Optimización de consultas mediante índices agrupados simples y compuestos sobre un volumen masivo de 1.000.000 de registros.

## Estructura del repositorio

```text
proyecto-bd1-equipo-12/
│
├── docs/
│   ├── etapa-01/
│   │   ├── descripcion-caso.md
│   │   ├── alcance.md
│   │   ├── reglas-negocio.md
│   │   └── decisiones-diseno.md
│   │
│   ├── etapa-02/
│   │   ├── der/
│   │   │   └── der.png
│   │   ├── modelo-relacional/
│   │   │   └── JoyeriaAlba.png
│   │   ├── modelo-relacional.md
│   │   ├── normalizacion.md
│   │   └── decisiones-diseno.md
│   │
│   ├── etapa-03/
│   │   ├── implementacion.md
│   │   ├── restricciones-integridad.md
│   │   └── pruebas-validacion.md
│   │
│   ├── etapa-04/
│   │   ├── casos-uso.md
│   │   ├── comprobante-venta.md
│   │   ├── informe-ventas.md
│   │   └── consulta-avanzada.md
│   │
│   └── etapa-05/
│       ├── procedimientos-funciones.md
│       ├── transacciones.md
│       ├── triggers-auditoria.md
│       ├── seguridad.md
│       └── indices-optimizacion.md
│
├── sql/
│   ├── ddl/
│   │   └── crear_bd.sql
│   ├── dml/
│   │   └── datos_prueba.sql
│   ├── consultas/
│   │   ├── casos_uso.sql
│   │   ├── comprobante_venta.sql
│   │   ├── informe_ventas.sql
│   │   └── consulta_avanzada.sql
│   └── tecnico/
│       ├── procedimientos/
│       ├── funciones/
│       ├── transacciones/
│       ├── triggers/
│       ├── seguridad/
│       └── indices/
│
└── README.MD
```

## Guía de Instalación y Ejecución en SQL Server

Para reproducir y probar el proyecto completo en **SQL Server Management Studio (SSMS)**, ejecutar los scripts en el siguiente orden:

1. **Creación de la Base de Datos y Tablas (DDL):**
   * Abrir y ejecutar [`sql/ddl/crear_bd.sql`](sql/ddl/crear_bd.sql) (crea automáticamente `BD_JoyeriaAlba` y sus 18 tablas con todas las restricciones).
2. **Carga de Lotes de Datos de Prueba (DML):**
   * Abrir y ejecutar [`sql/dml/datos_prueba.sql`](sql/dml/datos_prueba.sql) (inserta entre 8 y 10 registros válidos en cada una de las 18 tablas).
3. **Ejecución de Consultas y Reportes (Etapa 4):**
   * Ejecutar cualquiera de los scripts dentro de [`sql/consultas/`](sql/consultas/).
4. **Pruebas de Programación y Administración Avanzada (Etapa 5):**
   * Ejecutar los scripts dentro de [`sql/tecnico/`](sql/tecnico/) (primero `funciones/funciones.sql` y `procedimientos/procedimientos.sql`, y luego `transacciones/`, `triggers/`, `seguridad/` e `indices/`).

## Documentación disponible

### Etapa 1
* [Descripción del caso](docs/etapa-01/descripcion-caso.md)
* [Alcance del sistema](docs/etapa-01/alcance.md)
* [Reglas de negocio](docs/etapa-01/reglas-negocio.md)
* [Decisiones de diseño](docs/etapa-01/decisiones-diseno.md)

### Etapa 2
* [DER en notación Peter Chen](docs/etapa-02/der/der.png)
* [Diagrama del Modelo Relacional (18 tablas)](docs/etapa-02/modelo-relacional/JoyeriaAlba.png)
* [Especificación del Modelo Relacional](docs/etapa-02/modelo-relacional.md)
* [Proceso de normalización (1FN, 2FN y 3FN)](docs/etapa-02/normalizacion.md)
* [Decisiones de diseño del modelo](docs/etapa-02/decisiones-diseno.md)

### Etapa 3
* [Implementación del modelo](docs/etapa-03/implementacion.md)
* [Restricciones de integridad](docs/etapa-03/restricciones-integridad.md)
* [Pruebas y validación](docs/etapa-03/pruebas-validacion.md)
* [Script DDL – Creación de base de datos](sql/ddl/crear_bd.sql)
* [Script DML – Datos de prueba](sql/dml/datos_prueba.sql)

### Etapa 4
* [Casos de uso](docs/etapa-04/casos-uso.md)
* [Comprobante de venta](docs/etapa-04/comprobante-venta.md)
* [Informe de ventas](docs/etapa-04/informe-ventas.md)
* [Consulta avanzada](docs/etapa-04/consulta-avanzada.md)

### Etapa 5
* [Procedimientos y funciones almacenadas](docs/etapa-05/procedimientos-funciones.md)
* [Transacciones y transacciones anidadas](docs/etapa-05/transacciones.md)
* [Triggers de auditoría](docs/etapa-05/triggers-auditoria.md)
* [Seguridad de usuarios y roles](docs/etapa-05/seguridad.md)
* [Índices y optimización de consultas](docs/etapa-05/indices-optimizacion.md)

## Estado del proyecto

* [x] Etapa 1 – Requerimientos.
* [x] DER en notación Peter Chen.
* [x] Primera versión del modelo relacional.
* [x] Primera versión del proceso de normalización.
* [x] Revisión final de la Etapa 2.
* [x] Etapa 3 – Implementación.
* [x] Etapa 4 – Consultas.
* [x] Etapa 5 – Temas técnicos.

## Herramientas utilizadas

* Microsoft SQL Server y SQL Server Management Studio (SSMS) para la implementación, consultas y pruebas técnicas de la base de datos.
* ERDPlus para la elaboración del DER y del modelo relacional.
* Visual Studio Code para la organización y edición de los archivos.
* Git para el control de versiones.
* GitHub para el almacenamiento, colaboración y trazabilidad del proyecto.
* Google Meet para las reuniones de trabajo del equipo.
* Gemini (Inteligencia Artificial) como herramienta de apoyo, consulta y orientación durante el desarrollo del proyecto.
