docker rm -f websafety-config websafety
docker rmi -f diladele/websafety:4.7-beta
docker build --force-rm --no-cache --rm=true -t diladele/websafety:4.7-beta .
