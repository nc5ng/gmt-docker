#!/bin/sh

PROGNAME="$(basename $0)"
DOCKER_GMT_VERSION=latest
DOCKER_GMT_IMAGE_NAME=nc5ng/gmt

error(){
    error_code=$1
    echo "ERROR: $2" >&2
    echo "($PROGNAME wrapper version: $VERSION, error code $error_code)" >&2
    exit $error_code
}



check_cmd(){
    which $1 > /dev/null 2>&1 || error 1 "$cmd not found!"
}


check_cmd docker

exec docker run -it --rm \
     --volume "$PWD:/wd" \
     --workdir /wd \
     "$DOCKER_GMT_IMAGE_NAME:$DOCKER_GMT_VERSION" "$@"



     
