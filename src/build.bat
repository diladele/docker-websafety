REM rebuild our project
docker rmi -f diladele/websafety:7.6
docker build --force-rm --no-cache --rm=true -t diladele/websafety:7.6 .
