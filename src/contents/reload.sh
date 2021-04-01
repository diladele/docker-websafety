#!/bin/bash
#
# Reloads Web Safety and Squid Proxy, usually called by the Web UI
#
# returns:
#        0 - on success
#       !0 - on various errors
#

echo "Reloading Web Safety ICAP Daemon..."
sv hup wsicapd

echo "Reloading Web Safety GSB Daemon..."
sv hup wsgsbd

echo "Reloading Web Safety Youtube guard Daemon..."
sv hup wsytgd

echo "Reloading Web Safety Monitoring Daemon..."
sv hup wsmond

echo "Reloading Squid Proxy Server..."
sv hup squid

# dump success
echo "Reload successful!"
exit 0
