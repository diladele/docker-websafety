#!/bin/bash
#
# Reloads Diladele Web Safety and Squid Proxy, usually called by the Web UI
#
# returns:
#        0 - on success
#       !0 - on various errors
#

echo "Reloading Diladele Web Safety ICAP Daemon..."
sv restart wsicap

echo "Reloading Diladele Web Safety Monitoring Daemon..."
sv restart wsmgr

echo "Reloading Squid Proxy Server..."
sv -w 15 restart squid

# dump success
echo "Reload successful!"
exit 0
