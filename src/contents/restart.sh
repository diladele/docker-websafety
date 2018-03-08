#!/bin/bash
#
# Reloads Web Safety and Squid Proxy, usually called by the Web UI
#
# returns:
#        0 - on success
#       !0 - on various errors
#

echo "Restarting Web Safety ICAP Daemon..."
sv restart wsicap

echo "Restarting Web Safety Monitoring Daemon..."
sv restart wsmgr

echo "Restarting Web Safety GSB Daemon..."
sv restart wsgsb || true

echo "Reloading Squid Proxy Server..."
sv -w 15 restart squid

# dump success
echo "Reload successful!"
exit 0
