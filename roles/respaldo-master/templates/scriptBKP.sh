#!/bin/bash

# Configuración de la base de datos
DB_HOST="localhost"
DB_USER="root"
DB_PASSWORD="root"
DB_NAME="laravel"

# Directorio de respaldo
BACKUP_DIR="/home/bkp/SQL"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$TIMESTAMP.sql"

mkdir -p "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR/logsSQL"

# Comando para respaldar la base de datos
mysqldump --host=$DB_HOST --user=$DB_USER --password=$DB_PASSWORD $DB_NAME > $BACKUP_FILE

# Verificar si el respaldo se completó exitosamente
if [ $? -eq 0 ]; then
    echo "Respaldo completado con éxito. Archivo: $BACKUP_FILE" >> $BACKUP_DIR/logsSQL
else
    echo "Error en el respaldo" >> $BACKUP_DIR/logsSQL
    exit 1
fi
# Mantener solo los últimos 5 archivos de respaldo
cd $BACKUP_DIR
ls -t | tail -n +6 | xargs -d '\n' rm -f

if [ $? -eq 0 ]; then
    echo "Mantenimiento de archivos de respaldo completado" >> $BACKUP_DIR/logsSQL
else
    echo "Error en Mantenimiento de archivos de respaldo" >> $BACKUP_DIR/logsSQL
    exit 2
fi

# Carpeta de destino para los logs
destination_folder="/home/bkp"

# Carpeta donde se encuentran los logs de inicio de sesión y MySQL
log_folder="/var/log"

# Duración en días de retención de logs
retention_days=15

# Fecha límite para retener los logs
retention_date=$(date -d "-$retention_days days" +%Y-%m-%d)

# Patrones de nombres de archivos de logs
login_log_pattern="auth.log*"
mysql_log_pattern="mysql.log*"

# Mover los logs de inicio de sesión
find "$log_folder" -name "$login_log_pattern" -type f -mtime -$retention_days -exec mv {} "$destination_folder" \;

# Mover los logs de MySQL
find "$log_folder" -name "$mysql_log_pattern" -type f -mtime -$retention_days -exec mv {} "$destination_folder" \;

# Eliminar los archivos más antiguos que la fecha límite de retención
find "$destination_folder" -type f -name "$login_log_pattern" -mtime +$retention_days -exec rm {} \;
find "$destination_folder" -type f -name "$mysql_log_pattern" -mtime +$retention_days -exec rm {} \;