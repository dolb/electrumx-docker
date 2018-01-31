#!/bin/bash
set -e

chown -R zcluser /home/zcluser

if [ "$CUSTOM_USER" = "zcluser" ]; then
    sudo -H -u $CUSTOM_USER -E /bin/bash -c "$@"
else
    exec "$@"
fi
