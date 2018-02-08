#!/bin/bash
set -e

ZCLUSER_HOME="/home/zcluser/"
PATHS=(".zclassic" ".zcash-params" "zcl_electrum_db" "certs")

chown zcluser /home/zcluser

for p in ${PATHS[*]}; do
  [[ -d  "$PTH" ]] && chown zcluser $PTH
done

if [ "$CUSTOM_USER" = "zcluser" ]; then
    sudo -H -u $CUSTOM_USER -E /bin/bash -c "$@"
else
    exec "$@"
fi
