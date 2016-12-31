#!/bin/bash
#
# Reloads Diladele Web Safety and Squid Proxy, usually called by the Web UI
#
# returns:
#        0 - on success
#       !0 - on various errors
#

echo "Reloading Diladele Web Safety ICAP Daemon..."
sv hup wsicap

echo "Reloading Diladele Web Safety Monitoring Daemon..."
sv hup wsmgr

echo "Reloading Squid Proxy Server..."
sv hup squid

# dump success
echo "Reload successful!"
exit 0
