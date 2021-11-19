# rebuild our project
docker rmi -f diladele/websafety:8.0
docker build --force-rm --no-cache --rm=true -t diladele/websafety:8.0 .
