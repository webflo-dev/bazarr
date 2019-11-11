#!/bin/sh

now=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
version=$1

docker build --no-cache=true \
    --build-arg BUILD_DATE=$now \
    --build-arg VERSION=$version \
    -t webflo/bazarr:latest .
