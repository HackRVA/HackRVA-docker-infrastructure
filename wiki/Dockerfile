# Start from a mediawiki base installation
FROM mediawiki:stable

# Grab the local settings from the NAS
COPY ./LocalSettings.php /var/www/html/LocalSettings.php

# Load the wiki data from a volume
VOLUME /var/www/html/images

