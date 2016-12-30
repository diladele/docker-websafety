docker rm -f websafety-config websafety
docker rmi -f diladele/websafety:4.8
docker build --force-rm --no-cache --rm=true -t diladele/websafety:4.8 .
