#!/bin/bash
#
# Reloads Diladele Web Safety and Squid Proxy, usually called by the Web UI
#
# returns:
#        0 - on success
#       !0 - on various errors
#

SQUID_NAME=squid
SQUID_PATH=/usr/sbin/$SQUID_NAME

echo "Reloading Diladele Web Safety ICAP Daemon..."
kill -HUP $(pidof qlproxyd)
res=$?
if [ $res -ne 0 ]; then
    echo "Cannot reload, error $res"
    exit 1
fi

echo "Reloading Diladele Web Safety Monitoring Daemon..."
kill -HUP $(pidof wsmgrd)
res=$?
if [ $res -ne 0 ]; then
    echo "Cannot reload, error $res"
    exit 1
fi

echo "Reloading Squid Proxy Server..."
$SQUID_PATH -k reconfigure
res=$?
if [ $res -ne 0 ]; then
    echo "Cannot reload, error $res"
    exit 1
fi

# dump success
echo "Reload successful!"
exit 0
