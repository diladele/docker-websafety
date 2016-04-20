#!/bin/bash
#
# Restarts Diladele Web Safety and Squid Proxy, usually called by the Web UI
#
# returns:
#       0 - on success
#      !0 - on various errors
#

echo "Restarting Diladele Web Safety and Squid..."
supervisorctl restart qlproxy squid wsmgr
res=$?
if [ $res -ne 0 ]; then
    echo "Cannot restart, error $res"
    exit 1
fi


# dump success
echo "Restart successful!"
exit 0
