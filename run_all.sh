#!/usr/bin/env bash
# Crea la base y carga estructura, restricciones y datos de prueba.
# Uso: ./run_all.sh [usuario]   (pide la contraseña por consola)
set -euo pipefail
USER_DB="${1:-root}"
cd "$(dirname "$0")/sql"
for f in 01_crear_tablas.sql 02_restricciones.sql 03_datos_prueba.sql; do
  echo ">> Ejecutando $f"
  mysql -u "$USER_DB" -p < "$f"
done
echo "Listo. Consultas de ejemplo en sql/04_consultas_verificacion.sql"
