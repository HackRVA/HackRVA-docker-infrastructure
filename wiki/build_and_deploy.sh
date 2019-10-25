#!/bin/bash
VERSION=`cat VERSION`
# build the docker image
docker build . -t hackrva/wiki:${VERSION}

docker push hackrva/wiki:${VERSION}