#!/bin/bash

CONTAINER_NAME="stacks-database-1"

usage() {
    echo "Usage: $0 <mysql_backup.tar.gz> <images_backup.tar.gz>"
    exit 1
}

if [ "$#" -ne 2 ]; then
    usage
fi

MYSQL_BACKUP_FILE="$1"
IMAGES_BACKUP_FILE="$2"

if [ ! -f "$MYSQL_BACKUP_FILE" ]; then
    echo "Error: MySQL backup file '$MYSQL_BACKUP_FILE' not found!"
    exit 1
fi

if [ ! -f "$IMAGES_BACKUP_FILE" ]; then
    echo "Error: Images backup file '$IMAGES_BACKUP_FILE' not found!"
    exit 1
fi

echo "Restoring MySQL data..."
tar -xzvf "$MYSQL_BACKUP_FILE"

MYSQL_DIR=$(tar -tzf "$MYSQL_BACKUP_FILE" | head -n 1 | cut -d '/' -f1)

cp -r $MYSQL_DIR /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql

echo "Restoring images..."
tar -xzvf "$IMAGES_BACKUP_FILE"

IMAGES_DIR=$(tar -tzf "$IMAGES_BACKUP_FILE" | head -n 1 | cut -d '/' -f1)

cp -r $IMAGES_DIR/www/html/images/* /var/www/html/images
chown -R www-data:www-data /var/www/html/images

rm -rf "$MYSQL_DIR"
rm -rf "$IMAGES_DIR"

echo "Restore completed successfully!"

