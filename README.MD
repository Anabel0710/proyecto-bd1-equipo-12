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

El proyecto consiste en el diseño, normalización e implementación de una base de datos relacional para una joyería comercial especializada en la venta de piezas de alta gama, como anillos, aretes, pulseras, relojes y collares.

El sistema permite registrar y organizar las operaciones comerciales e internas de la joyería, incluyendo la administración del catálogo de productos, el control de las existencias disponibles y ajustes de inventario, la gestión de compras a proveedores y recepción de mercadería, el registro de clientes y usuarios del sistema, la emisión de comprobantes de venta y la identificación del medio de pago utilizado.

Asimismo, permite conservar el precio unitario aplicado a cada producto en el momento de la operación, evitando que los cambios posteriores en los precios del catálogo modifiquen el historial de las ventas y compras realizadas.

## Objetivos

* Administrar el catálogo de joyas, sus categorías y géneros.
* Controlar el stock actual, el stock mínimo y los ajustes manuales de inventario de cada producto.
* Evitar ventas cuando no exista stock suficiente.
* Administrar usuarios y roles del personal y clientes registrados.
* Gestionar proveedores, órdenes de compra de mercadería y su recepción en depósito.
* Registrar comprobantes de venta con uno o varios productos asociados a clientes y vendedores.
* Conservar el precio unitario histórico de cada operación comercial.
* Asociar cada operación con su medio de pago y tipo de comprobante correspondiente.
* Controlar el estado de las órdenes de compra y de los artículos del catálogo.
* Mantener la integridad, seguridad y consistencia de la información.
* Alcanzar la Tercera Forma Normal (3FN).

## Etapas del proyecto

### Etapa 1 – Requerimientos

Contiene la descripción del caso, el alcance del sistema, las reglas de negocio y las decisiones iniciales de diseño.

### Etapa 2 – Modelado conceptual y lógico

Contiene:

* Diagrama Entidad-Relación en notación Peter Chen.
* Modelo relacional e identificación de claves primarias y foráneas.
* Proceso de normalización hasta la Tercera Forma Normal (3FN).
* Decisiones de diseño del modelo de datos.
* Manifiestos individuales de los integrantes.

### Etapa 3 – Implementación

Contiene los scripts DDL y DML necesarios para crear y poblar la base de datos en Microsoft SQL Server, junto con la documentación de las tablas, restricciones de integridad y pruebas de validación.

### Etapa 4 – Consultas

Contiene los casos de uso operativos y las consultas SQL correspondientes a emisión de comprobantes de venta, informes agregados de ventas por categoría y consultas de negocio avanzadas.

### Etapa 5 – Temas técnicos

Contiene la implementación y pruebas de procedimientos almacenados, funciones definidas por el usuario, transacciones simples y anidadas, triggers de auditoría, seguridad (usuarios y roles) y optimización de consultas mediante índices.

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

## Documentación disponible

### Etapa 1

* [Descripción del caso](docs/etapa-01/descripcion-caso.md)
* [Alcance del sistema](docs/etapa-01/alcance.md)
* [Reglas de negocio](docs/etapa-01/reglas-negocio.md)
* [Decisiones de diseño](docs/etapa-01/decisiones-diseno.md)

### Etapa 2

* [DER en notación Peter Chen](docs/etapa-02/der/der.png)
* [Modelo relacional](docs/etapa-02/modelo-relacional.md)
* [Proceso de normalización](docs/etapa-02/normalizacion.md)
* [Decisiones de diseño](docs/etapa-02/decisiones-diseno.md)

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
