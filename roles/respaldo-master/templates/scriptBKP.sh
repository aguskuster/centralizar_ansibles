#!/bin/bash

# Configuración de la base de datos
DB_HOST="localhost"
DB_NAME="laravel"

# Directorio de respaldo
BACKUP_DIR="/home/bkp/SQL"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$TIMESTAMP.sql"
BACKUP_LOGFILE="/home/bkp/logsSQL/$TIMESTAMP"

mkdir -p "$BACKUP_DIR"
mkdir -p "/home/bkp/logsSQL"

# Comando para respaldar la base de datos
mysqldump --host=$DB_HOST $DB_NAME > $BACKUP_LOGFILE

# Verificar si el respaldo se completó exitosamente
if [ $? -eq 0 ]; then
    echo "Respaldo completado con éxito. Archivo: $BACKUP_FILE" >> "BACKUP_LOGFILE"
else
    echo "Error en el respaldo" >> "BACKUP_LOGFILE"
    exit 1
fi
# Mantener solo los últimos 5 archivos de respaldo
cd $BACKUP_DIR
ls -t | tail -n +6 | xargs -d '\n' rm -f

if [ $? -eq 0 ]; then
    echo "Mantenimiento de archivos de respaldo completado" >> "BACKUP_LOGFILE"
else
    echo "Error en Mantenimiento de archivos de respaldo" >> "BACKUP_LOGFILE"
    exit 2
fi

sudo rsync -a /var/log/secure /home/bkp/
sudo rsync -a /var/log/mariadb/mariadb.log /home/bkp/
