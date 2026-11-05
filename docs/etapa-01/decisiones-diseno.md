# Decisiones Preliminares de Diseño (Etapa 1)

A partir del relevamiento de requerimientos y reglas de negocio de la joyería, se establecieron los siguientes lineamientos iniciales para el diseño de la base de datos:

1. **Identificación unívoca de entidades:** Todas las entidades principales del sistema contarán con claves primarias numéricas autoincrementales (`IDENTITY`), complementadas con restricciones de unicidad (`UNIQUE`) para atributos naturales como el DNI, CUIT, correo electrónico y nombres de catálogos.
2. **Inmutabilidad de precios históricos:** El precio unitario de cada joya se registrará dentro del detalle de cada operación comercial para independizar la facturación histórica de las actualizaciones futuras del catálogo de productos.
3. **Integridad de existencias:** El control de stock se validará directamente desde la base de datos mediante restricciones de dominio (`CHECK`) para impedir saldos negativos y rutinas transaccionales que descuenten automáticamente las unidades vendidas.
4. **Preservación del historial operativo:** No se permitirá la eliminación física de productos, clientes, usuarios ni proveedores que posean operaciones asociadas; en su lugar se utilizarán estados lógicos (`Activo` / `Inactivo` / `Disponible`).
5. **Enfoque en el circuito comercial e inventario:** Durante la evolución hacia el modelado lógico (Etapa 2 y Etapa 3) se priorizará el circuito completo de inventario, abastecimiento con proveedores y ventas a clientes, descartando módulos accesorios como la bandeja de consultas web.
