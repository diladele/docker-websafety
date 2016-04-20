DIR=`pwd`
docker run \
    --name websafety \
    -p 80:80 -p 8080:3128 \
    -t diladele-websafety:4.4.0

#    -v $DIR/../websafety-data/etc:/opt/qlproxy/etc:ro \
#    -v $DIR/../websafety-data/var/spool:/opt/qlproxy/var/spool:ro \
#    -v $DIR/../websafety-data/var/log:/opt/qlproxy/var/log \
#    -v $DIR/../websafety-data/var/monitor:/opt/qlproxy/var/monitor \
#    -v $DIR/../websafety-data/var/temp:/opt/qlproxy/var/temp \
#