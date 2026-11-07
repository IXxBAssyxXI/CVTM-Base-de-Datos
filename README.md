# CVTM – Base de Datos: Centro Veterinario y Tienda de Mascotas

Implementación en **MySQL 8.0** de la base de datos `veterinaria_db` para un centro veterinario con tienda de mascotas (CVTM). Proyecto del ramo **Base de datos**, Facultad de Ingeniería, Universidad San Sebastián (Bellavista, Chile).

## Integrantes

- Bastian Aguilar Araya
- Nicolas Cifuentes Westhoff
- Benjamín González
- Neil Osorio Morán
- Eydan Seguel Perez

## Qué incluye

- **14 tablas**: Cliente, Veterinario, Cajero, Proveedor, Mascota, Prestacion, Producto, Cita, Venta, Ficha_Medica, Inventario, Detalle_Venta y Detalle_Prestacion.
- **16 claves foráneas** con `ON UPDATE CASCADE` y `ON DELETE RESTRICT` / `SET NULL` según el caso.
- **15 restricciones CHECK**, 2 `UNIQUE` (una cita origina como máximo una ficha médica) y 2 valores por defecto (`Cita.Estado = 'pendiente'`, `Producto.Stock = 0`).
- Datos de prueba, consultas de verificación y una batería de 23 pruebas que deben fallar (P1 a P23).

## Estructura

```
.
├── README.md
├── run_all.sh                         # ejecuta 01, 02 y 03 en orden
├── docs/
│   └── diccionario_datos.md           # modelo físico, tabla por tabla
└── sql/
    ├── 01_crear_tablas.sql            # Parte A: base de datos, tablas y PK
    ├── 02_restricciones.sql           # Parte B: FK, UNIQUE, CHECK, DEFAULT
    ├── 03_datos_prueba.sql            # 3 filas por tabla (39 en total)
    ├── 04_consultas_verificacion.sql  # 3 consultas JOIN de comprobación
    └── 05_pruebas_restricciones.sql   # Parte C: datos propios y pruebas P1–P23
```

## Cómo ejecutarlo

Requisitos: MySQL 8.0 y un cliente (consola `mysql` o MySQL Workbench).

```bash
git clone https://github.com/benjamingonzalezc/cvtm-veterinaria-db.git
cd cvtm-veterinaria-db
./run_all.sh root
```

O manualmente, **en este orden y cada script completo de una vez**:

| Paso | Script | Resultado esperado |
| --- | --- | --- |
| 1 | `sql/01_crear_tablas.sql` | `SHOW TABLES;` muestra 14 tablas |
| 2 | `sql/02_restricciones.sql` | 15 CHECK, 16 FOREIGN KEY, 14 PRIMARY KEY y 2 UNIQUE |
| 3 | `sql/03_datos_prueba.sql` | 3 filas en cada tabla |
| 4 | `sql/04_consultas_verificacion.sql` | Citas, fichas y ventas relacionadas |

Para comprobar las restricciones del paso 2:

```sql
SELECT CONSTRAINT_TYPE, COUNT(*)
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'veterinaria_db'
GROUP BY CONSTRAINT_TYPE;
```

### Parte C (pruebas de restricciones)

`05_pruebas_restricciones.sql` trae sus propios datos, pensados para provocar cada caso, así que **no se ejecuta sobre la base con los datos del paso 3**. Hay que recrear la base solo con los pasos 1 y 2 y luego ejecutarlo **sentencia por sentencia**: las pruebas P1 a P23 deben fallar y un error detiene un script completo.

Errores esperados: `1452` (FK al insertar), `1451` (RESTRICT al borrar), `1062` (UNIQUE), `3819` (CHECK), `1048` y `1364` (NOT NULL).

### Repetir una corrida

Los scripts no se pueden ejecutar dos veces sobre la misma base. Para reiniciar:

```sql
DROP DATABASE IF EXISTS veterinaria_db;
```

y volver al paso 1.

## Limitaciones conocidas del modelo

- No se verifica que `Subtotal = Cantidad × Precio`.
- `Stock` no se actualiza automáticamente con los movimientos de `Inventario`.
- La ficha médica no exige que la firme el mismo veterinario de la cita..
- -La colisión horaria solo se detecta cuando las citas comienzan a la misma hora exacta, no ante traslapes por duración.
- `UNIQUE (N_Cita)` limita a una ficha por cita, pero no obliga a que toda cita tenga ficha.

Estas reglas requerirían triggers o restricciones adicionales y se dejan documentadas como posibles mejoras.

## Documentación

El detalle de cada tabla (tipos, claves, nulidad y descripción) está en [`docs/diccionario_datos.md`](docs/diccionario_datos.md).
