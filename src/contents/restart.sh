#!/bin/bash
#
# Reloads Web Safety and Squid Proxy, usually called by the Web UI
#
# returns:
#        0 - on success
#       !0 - on various errors
#

echo "Restarting Web Safety ICAP Daemon..."
sv restart wsicapd

echo "Restarting Web Safety GSB Daemon..."
sv restart wsgsbd

echo "Restarting Web Safety Youtube guard Daemon..."
sv restart wsytgd

echo "Restarting Web Safety Monitoring Daemon..."
sv force-restart wsmond

echo "Reloading Squid Proxy Server..."
sv -w 15 restart squid

# dump success
echo "Restart successful!"
exit 0
