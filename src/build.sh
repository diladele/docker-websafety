# delete all containers
docker rm -f `docker ps -a -q`

# delete all images
docker rmi -f `docker images -q`

# rebuild our project
docker rm -f websafety-config websafety
docker rmi -f diladele/websafety:6.4
docker build --force-rm --no-cache --rm=true -t diladele/websafety:6.4 .
