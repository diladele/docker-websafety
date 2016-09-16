docker run -it --name websafety-config -t websafety-root  /usr/local/bin/firstrun.sh
docker run -d --name websafety-runtime --volumes-from websafety-config -p 80:80 -p 8080:3128 -t websafety-root
