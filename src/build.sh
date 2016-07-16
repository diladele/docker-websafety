docker rmi -f websafety
docker build --force-rm --no-cache --rm=true -t websafety .
docker build -t websafety .
