docker run -it --name websafety-config diladele/websafety:4.7-beta /usr/local/bin/firstrun.sh
docker run -d --name websafety-runtime --volumes-from websafety-config -p 8881:80 -p 8882:3128 -t diladele/websafety:4.7-beta
