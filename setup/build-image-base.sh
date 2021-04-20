#!/bin/sh

CWD=$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)
CWD=${CWD%"setup"}

IMAGE_NAME=gagres/auction:app-base

docker build -t $IMAGE_NAME -f ${CWD}/setup/docker/base.Dockerfile ${CWD}/setup/docker
