#!/bin/bash
VERSION=`cat VERSION`
# build the docker image
docker build . -t hackrva/gateway:${VERSION}

docker push hackrva/gateway:${VERSION}