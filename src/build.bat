REM rebuild our project
docker rmi -f diladele/websafety:8.5
docker build --force-rm --no-cache --rm=true -t diladele/websafety:8.5 .
