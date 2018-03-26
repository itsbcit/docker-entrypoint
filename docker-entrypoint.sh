#!/bin/sh

set -eo pipefail
shopt -s nullglob

for f in /docker-entrypoint.d/*.sh; do
    echo "$0: running $f"; . "$f"
done

exec "$@"
