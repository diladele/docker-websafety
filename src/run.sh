docker run -it --name websafety-config diladele/websafety:5.0 /usr/local/bin/firstrun.sh
docker run -dt --name websafety --dns=8.8.8.8 --volumes-from websafety-config -p 8000:80 -p 3128:3128 diladele/websafety:5.0
