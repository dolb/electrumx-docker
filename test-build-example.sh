CONTAINER="0.1/electrumx-docker"

echo "This is a sample script building docker container on the host you are connected to"

[[ "$(docker ps | grep $CONTAINER)" ]] && docker stop $CONTAINER

echo "Building $CONTAINER"

echo "This might take some time - get some popcorn :)"

docker build -t $CONTAINER .
