# Start from a mediawiki base installation
FROM mediawiki:stable

# Grab the local settings from a gitignore'd location
COPY ./LocalSettings.php /var/www/html/LocalSettings.php

# Load the wiki images from a volume
VOLUME /var/www/html/images

