#!/bin/bash

# add timestamp as filename
basefilename=_backup
filename=${basefilename}_$(date +%Y-%m-%d_%H-%M-%S).tar.gz

mysql_backup_filename=mysql${basefilename}_$(date +%Y-%m-%d_%H-%M-%S).sql
images_backup_filename="images"${filename}

# tar up the db files
mysqldump --default-character-set=binary -h database -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > ${mysql_backup_filename}
tar -zcvf ${mysql_backup_filename}.tar.gz ${mysql_backup_filename}

# tar up the images dir
tar -zcvf ${images_backup_filename} /var/www/html/images

# backup database to NAS!
cp ${mysql_backup_filename}.tar.gz /backup/NAS/wiki/
# backup images to NAS!
cp ${images_backup_filename} /backup/NAS/wiki/
