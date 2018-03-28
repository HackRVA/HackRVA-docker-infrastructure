#!/usr/bin/bash

cd ..

# Create the persist directories
if [ ! -d ./persist ]; then
  mkdir persist
fi

if [ ! -d ./persist/mysql ]; then
  mkdir persist/mysql
fi

if [ ! -d ./persist/images ]; then
  mkdir persist/images
fi
#give docker permission to write to persist
chown -R www-data:www-data persist/images

# Indicate that we should use certbot
echo "true" > gateway/use_certbot

docker-compose build

