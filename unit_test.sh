#!/bin/bash

set -e

DOCKER_RUNUID=1000100000

if [ -z "$1" ];then
    echo ${0} runuser
    exit 1
fi

case "$1" in
    root) DENV="";                DUSER="";                        DWHO="root" ;;
    none) DENV="-e RUNUSER=none"; DUSER="--user ${DOCKER_RUNUID}"; DWHO="" ;;
    *)    DENV="-e RUNUSER=${1}"; DUSER="--user ${DOCKER_RUNUID}"; DWHO=$1 ;;
esac

# Create test harness Docker container
container_name=$(docker run -d ${DENV} ${DUSER} bcit/docker-entrypoint:latest /bin/sh -c "tail -f /dev/null")

# Capture username of container runner
container_dwho=$(docker exec ${container_name} whoami || exit 0 )

# Clean up harness container
docker kill $container_name >/dev/null
docker rm $container_name >/dev/null

# Compare container reported user
if [ "$container_dwho" = "$DWHO" ];then
    echo Success
else
    echo 10-resolve-userid.sh failed. Got whoami=\"${container_dwho}\", expecting whoami=\"${DWHO}\"
    exit 1
fi

