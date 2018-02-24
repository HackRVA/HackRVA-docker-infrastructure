#!/usr/bin/bash

cd ..

# Indicate that we should use certbot
echo "true" > gateway/use_certbot

docker-compose build

