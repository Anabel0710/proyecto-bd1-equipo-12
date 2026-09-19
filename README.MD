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

El proyecto consiste en el diseño, normalización e implementación de una base de datos relacional para una joyería comercial especializada en la venta de piezas de alta gama, como anillos, aretes, pulseras y collares.

El sistema permitirá registrar y organizar las operaciones comerciales de la joyería, incluyendo la administración del catálogo de productos, el control de las existencias disponibles, el registro de clientes y usuarios, el procesamiento de órdenes de compra y la identificación del método de pago utilizado.

También permitirá conservar el precio unitario aplicado a cada producto en el momento de la venta, evitando que los cambios posteriores en los precios del catálogo modifiquen el historial de las operaciones realizadas.

## Objetivos

* Administrar el catálogo de joyas y sus categorías.
* Controlar el stock actual y el stock mínimo de cada producto.
* Evitar ventas cuando no exista stock suficiente.
* Registrar clientes y usuarios mediante un email único.
* Registrar órdenes con uno o varios productos.
* Conservar el precio unitario histórico de cada venta.
* Asociar cada orden con un método de pago.
* Controlar el estado de las órdenes.
* Devolver el stock cuando una orden sea cancelada.
* Registrar las consultas enviadas por clientes o visitantes.
* Mantener la integridad y consistencia de la información.
* Alcanzar la Tercera Forma Normal.

## Etapas del proyecto

### Etapa 1 – Requerimientos

Contiene la descripción del caso, el alcance del sistema y las reglas de negocio.

### Etapa 2 – Modelado conceptual y lógico

Contiene:

* Diagrama Entidad-Relación en notación Peter Chen.
* Modelo relacional.
* Identificación de claves primarias y foráneas.
* Proceso de normalización hasta la Tercera Forma Normal.
* Manifiestos individuales de los integrantes.

### Etapa 3 – Implementación

Contendrá los scripts DDL y DML necesarios para crear y poblar la base de datos.

### Etapa 4 – Consultas

Contendrá las consultas SQL correspondientes a comprobantes, reportes agregados y casos de negocio avanzados.

### Etapa 5 – Temas técnicos

Contendrá procedimientos, funciones, transacciones, triggers de auditoría, seguridad e índices.

## Estructura del repositorio

```text
proyecto-bd1-equipo-12/
│
├── docs/
│   ├── etapa-01/
│   ├── etapa-02/
│   │   ├── der/
│   │   ├── modelo-relacional/
│   │   └── manifiesto-individual/
│   ├── etapa-03/
│   ├── etapa-04/
│   └── etapa-05/
│
├── sql/
│   ├── ddl/
│   ├── dml/
│   ├── consultas/
│   └── tecnico/
│
└── README.md
```

## Documentación disponible

### Etapa 1

* [Descripción del caso](docs/etapa-01/descripcion-caso.md)
* [Alcance del sistema](docs/etapa-01/alcance.md)
* [Reglas de negocio](docs/etapa-01/reglas-negocio.md)

### Etapa 2

* [DER en notación Peter Chen](docs/etapa-02/der/joyeria-der.png)
* [Modelo relacional](docs/etapa-02/modelo-relacional.md)
* [Proceso de normalización](docs/etapa-02/normalizacion.md)

## Estado del proyecto

* [x] Etapa 1 – Requerimientos.
* [x] DER en notación Peter Chen.
* [x] Primera versión del modelo relacional.
* [x] Primera versión del proceso de normalización.
* [ ] Revisión final de la Etapa 2.
* [ ] Etapa 3 – Implementación.
* [ ] Etapa 4 – Consultas.
* [ ] Etapa 5 – Temas técnicos.

## Herramientas utilizadas

* ERDPlus para la elaboración del DER y del modelo relacional.
* Visual Studio Code para la organización y edición de los archivos.
* Git para el control de versiones.
* GitHub para el almacenamiento, colaboración y trazabilidad del proyecto.
* Google Meet para las reuniones de trabajo del equipo.
