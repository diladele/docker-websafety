docker run -it --name websafety-config -t websafety-root  /opt/qlproxy/bin/certmgr -action="regenerate-certificate-storage"
docker run -d --name websafety-runtime --volumes-from websafety-config -p 80:80 -p 8080:3128 -t websafety-root
