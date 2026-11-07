# Diccionario de datos

Modelo físico de la base `veterinaria_db` (MySQL 8.0). 14 tablas.


## Cliente

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| Rut_Cliente | VARCHAR(12) | PK | NOT NULL | Identificador único del cliente (RUT) |
| Nombre | VARCHAR(100) | Atributo | NOT NULL | Nombre completo del cliente |
| Correo_Electronico | VARCHAR(100) | Atributo | NULL | Correo electrónico de contacto |
| Telefono | VARCHAR(15) | Atributo | NULL | Teléfono de contacto |

## Veterinario

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| Rut_Veterinario | VARCHAR(12) | PK | NOT NULL | Identificador único del médico veterinario |
| Nombre | VARCHAR(100) | Atributo | NOT NULL | Nombre del profesional |
| Especialidad | VARCHAR(60) | Atributo | NULL | Especialidad clínica |
| Telefono | VARCHAR(15) | Atributo | NULL | Teléfono de contacto del profesional |

## Cajero

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| Rut_Cajero | VARCHAR(12) | PK | NOT NULL | Identificador único del cajero |
| Nombre | VARCHAR(100) | Atributo | NOT NULL | Nombre completo del cajero |
| Turno | VARCHAR(20) | Atributo | NULL | Turno laboral asignado |

## Proveedor

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| Rut_Proveedor | VARCHAR(12) | PK | NOT NULL | Identificador del proveedor |
| Nombre_Proveedor | VARCHAR(100) | Atributo | NOT NULL | Razón social o nombre comercial |
| Telefono | VARCHAR(15) | Atributo | NULL | Teléfono comercial |
| Correo_Electronico | VARCHAR(100) | Atributo | NULL | Correo de contacto comercial |
| Direccion | VARCHAR(150) | Atributo | NULL | Dirección de la distribuidora |

## Mascota

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| ID_Mascota | INT | PK | NOT NULL | Identificador autoincremental de la mascota |
| Nombre | VARCHAR(50) | Atributo | NOT NULL | Nombre de la mascota |
| Especie | VARCHAR(30) | Atributo | NULL | Especie (Canino, Felino, etc.) |
| Raza | VARCHAR(50) | Atributo | NULL | Raza de la mascota |
| Fecha_Nacimiento | DATE | Atributo | NULL | Fecha estimada de nacimiento |
| Sexo | CHAR(1) | Atributo | NULL | Sexo ('M' o 'H') |
| Rut_Cliente | VARCHAR(12) | FK base | NOT NULL | RUT del dueño (referencia a Cliente) |

## Prestacion

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| ID_Prestacion | INT | PK | NOT NULL | Identificador autoincremental del servicio |
| Nombre_Prestacion | VARCHAR(100) | Atributo | NOT NULL | Nombre del procedimiento médico |
| Descripcion | VARCHAR(255) | Atributo | NULL | Descripción de la atención clínica |
| Precio | DECIMAL(10,2) | Atributo | NOT NULL | Arancel asignado al servicio |
| Duracion_Min | INT | Atributo | NULL | Duración estimada en minutos |

## Producto

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| ID_Producto | INT | PK | NOT NULL | Identificador autoincremental del producto |
| Nombre_Producto | VARCHAR(100) | Atributo | NOT NULL | Nombre del producto comercial |
| Precio_Unitario | DECIMAL(10,2) | Atributo | NOT NULL | Precio de venta |
| Stock | INT | Atributo | NOT NULL | Cantidad disponible en tienda |
| Fecha_Vencimiento | DATE | Atributo | NULL | Fecha de expiración del lote |
| Rut_Proveedor | VARCHAR(12) | FK base | NULL | Proveedor que suministra el producto |

## Cita

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| N_Cita | INT | PK | NOT NULL | Identificador único de la cita médica |
| Fecha_Hora | DATETIME | Atributo | NOT NULL | Fecha y hora reservada |
| Estado | VARCHAR(20) | Atributo | NOT NULL | Estado (pendiente, confirmada, atendida, cancelada, ausente) |
| ID_Mascota | INT | FK base | NOT NULL | Mascota citada (referencia a Mascota) |
| Rut_Veterinario | VARCHAR(12) | FK base | NOT NULL | Veterinario a cargo (referencia a Veterinario) |
| Bloque_Activo | DATETIME | Columna generada | NULL | Igual a Fecha_Hora si la cita está activa; NULL si está cancelada o ausente |

## Venta

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| ID_Venta | INT | PK | NOT NULL | Identificador autoincremental de la venta |
| Fecha_Pago | DATE | Atributo | NOT NULL | Fecha de realización del pago |
| Monto_Venta | DECIMAL(10,2) | Atributo | NOT NULL | Monto total cancelado |
| Forma_Pago | VARCHAR(20) | Atributo | NULL | Medio de pago utilizado |
| Rut_Cliente | VARCHAR(12) | FK base | NULL | Cliente que compra (referencia a Cliente) |
| Rut_Cajero | VARCHAR(12) | FK base | NOT NULL | Cajero emisor (referencia a Cajero) |

## Ficha_Medica

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| ID_Ficha | INT | PK | NOT NULL | Identificador autoincremental de la ficha |
| Diagnostico | VARCHAR(255) | Atributo | NOT NULL | Diagnóstico emitido |
| Tratamiento | VARCHAR(255) | Atributo | NULL | Prescripción o tratamiento indicado |
| Observaciones | VARCHAR(255) | Atributo | NULL | Notas complementarias de seguimiento |
| Fecha_Registro | DATE | Atributo | NOT NULL | Fecha de confección de la ficha |
| N_Cita | INT | FK base | NOT NULL | Cita originaria (relación 1:0..1) |
| Rut_Veterinario | VARCHAR(12) | FK base | NOT NULL | Médico que firma el registro clínico |

## Inventario

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| ID_Movimiento | INT | PK | NOT NULL | Identificador autoincremental del movimiento |
| ID_Producto | INT | FK base | NOT NULL | Producto afectado (referencia a Producto) |
| Tipo_Movimiento | VARCHAR(20) | Atributo | NOT NULL | Operación ('entrada' o 'salida') |
| Cantidad | INT | Atributo | NOT NULL | Unidades involucradas |
| Fecha_Movimiento | DATETIME | Atributo | NOT NULL | Timestamp de la operación |
| Rut_Proveedor | VARCHAR(12) | FK base | NULL | Proveedor abastecedor (si es entrada) |

## Detalle_Venta

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| ID_Venta | INT | PK Compuesta | NOT NULL | Venta asociada (referencia a Venta) |
| ID_Producto | INT | PK Compuesta | NOT NULL | Producto vendido (referencia a Producto) |
| Cantidad | INT | Atributo | NOT NULL | Cantidad de unidades adquiridas |
| Subtotal | DECIMAL(10,2) | Atributo | NOT NULL | Cantidad x Precio unitario |

## Detalle_Prestacion

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| ID_Venta | INT | PK Compuesta | NOT NULL | Venta asociada (referencia a Venta) |
| ID_Prestacion | INT | PK Compuesta | NOT NULL | Servicio cobrado (referencia a Prestacion) |
| Cantidad | INT | Atributo | NOT NULL | Cantidad de prestaciones |
| Precio_Aplicado | DECIMAL(10,2) | Atributo | NOT NULL | Arancel efectivo cobrado |
| Subtotal | DECIMAL(10,2) | Atributo | NOT NULL | Cantidad x Precio aplicado |

## Historial_Responsable

| Atributo | Tipo de Dato (MySQL 8.0) | Clave / Rol | Nulidad | Descripción / Dominio |
|---|---|---|---|---|
| ID_Historial | INT | PK | NOT NULL | Identificador autoincremental del registro |
| ID_Mascota | INT | FK base | NOT NULL | Mascota asociada (referencia a Mascota) |
| Rut_Cliente | VARCHAR(12) | FK base | NOT NULL | Cliente responsable en ese período (referencia a Cliente) |
| Fecha_Inicio | DATE | Atributo | NOT NULL | Fecha desde la que es responsable |
| Fecha_Fin | DATE | Atributo | NULL | Fecha de término; NULL si es el responsable actual (≥ Fecha_Inicio) |
