# backups
Backups are ran daily.

# restoring db

run the restore script 
e.g.
```bash
docker run --rm -it \
-v $PERSIST_DIR/mysql:/var/lib/mysql \
-v $PERSIST_DIR/images:/var/www/html/images \
-v $BACKUP_DIR:/backup/backups \
stacks-backup:latest \
bash restore.sh backups/mysql_2025-02-27_21-32-16.sql.tar.gz backups/images_backup_2025-02-27_01-00-01.tar.gz
```

this should spit out a .sql file and extract the images to `/var/www/html/images`

mount into the database container 
```bash
docker exec -it stacks-database-1 bash
```

restore the database
```bash
mysql -u root -p wiki < <path to the .sql file>
```

if the database user doesn't exist you will need to create the user and assign proper permissions.

you may need to run update on mediawiki depending on version differences
```bash
docker exec -it stacks-wiki-1 php maintenance/update.php --quick
```

