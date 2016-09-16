docker rm -f websafety-config websafety-root
docker rmi -f websafety-root
docker build --force-rm --no-cache --rm=true -t websafety-root .
docker build -t websafety-root .
