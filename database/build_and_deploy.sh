#!/bin/bash
VERSION=`cat VERSION`
# build the docker image
docker build . -t hackrva/wiki-db:${VERSION}

docker push hackrva/wiki-db:${VERSION}