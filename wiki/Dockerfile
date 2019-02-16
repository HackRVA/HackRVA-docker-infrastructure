# Start from a mediawiki base installation
FROM mediawiki:stable

# Grab the local settings from a gitignore'd location
COPY ./LocalSettings.php /var/www/html/LocalSettings.php

#increase upload filesize
RUN touch /usr/local/etc/php/conf.d/uploads.ini \
    && echo "upload_max_filesize = 40M;" >> /usr/local/etc/php/conf.d/uploads.ini

# Load the wiki images from a volume
VOLUME /var/www/html/images

