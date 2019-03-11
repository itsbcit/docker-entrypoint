#!/bin/sh

# for f in /docker-entrypoint.d/*.sh; do
#     echo "$0: running $f"; . "$f"
# done

if [ "$1" = "init-loop" ];then
    echo "Looping forever..." >&2
    while :; do sleep 1; done
else
    exec "$@"
fi
