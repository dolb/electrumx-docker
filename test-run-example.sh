CONTAINER="electrumx-docker"

echo "This is a sample script building docker container on the host you are connected to"

[[ ! "$1" ]] && echo "Specify container volumes directory ie. './docker-example.sh /data'" && exit 1

[[ "$(docker ps | grep $CONTAINER)" ]] && docker stop $CONTAINER

docker rm $CONTAINER

echo "Running container with volumes stored in $1"

docker run -d \
  -v $1/zcl_electrum_db:/home/zcluser/zcl_electrum_db \
  -v $1/.zclassic:/home/zcluser/.zclassic \
  -v $1/.zcash-params:/home/zcluser/.zcash-params \
  -p 50002:50002 \
  --name $CONTAINER \
  $CONTAINER electrumx-server
