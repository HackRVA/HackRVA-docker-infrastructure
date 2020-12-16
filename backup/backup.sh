#!/bin/bash

# add timestamp as filename
basefilename=mysql_backup
filename=${basefilename}_$(date +%Y-%m-%d_%H-%M-%S).tar.gz

# tar up the db files
tar -zcvf ${filename} /var/lib/mysql/
# tar up the images dir
tar -zcvf ${filename}"_images" /var/www/html/images

# backup database to NAS!
cp ${filename} /backup/NAS/wiki/
# backup images to NAS!
cp ${filename}"_images" /backup/NAS/wiki/
