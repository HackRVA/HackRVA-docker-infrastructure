#!/usr/bin/bash

cd ..

# Set to not use certbot
echo "false" > gateway/use_certbot

# Prepare the repository for building
# Copy the LocalSettings.php file for the wiki

# Build the docker services
docker-compose build

