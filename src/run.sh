docker run -it --name websafety-config diladele/websafety:4.7 /usr/local/bin/firstrun.sh
docker run -d --name websafety --volumes-from websafety-config -p 8000:80 -p 3128:3128 -t diladele/websafety:4.7
