#!/bin/bash

# add timestamp as filename
basefilename=_backup
filename=${basefilename}_$(date +%Y-%m-%d_%H-%M-%S).tar.gz

mysql_backup_filename="mysql"${filename}
images_backup_filename="images"${filename}

# tar up the db files
tar -zcvf ${mysql_backup_filename} /var/lib/mysql/
# tar up the images dir
tar -zcvf ${images_backup_filename} /var/www/html/images

# backup database to NAS!
cp ${mysql_backup_filename} /backup/NAS/wiki/
# backup images to NAS!
cp ${images_backup_filename} /backup/NAS/wiki/
