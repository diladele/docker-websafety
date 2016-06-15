docker rmi -f diladele-websafety:4.5.0
docker build --force-rm --no-cache --rm=true -t diladele-websafety:4.5.0 .
docker build -t diladele-websafety:4.5.0 .