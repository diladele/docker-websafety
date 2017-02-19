#!/bin/bash
set -e
/opt/qlproxy/bin/certmgr -action="regenerate-certificate-storage"
if ! [[ -z "$TIME_ZONE" ]]; then
    sed -i "s:TIME_ZONE = '.*':TIME_ZONE='$TIME_ZONE':" /opt/qlproxy/var/console/console/settings.py
fi
# Docker does not have timdatectl, fixing UI
sed -i "s:if platform.system() == \"Windows\":if True:" /opt/qlproxy/var/console/node/views.py
cd /opt/qlproxy/var/spool
mv adblock adblock.a && mv adblock.a adblock
mv adult adult.a && mv adult.a adult
mv categories categories.a && mv categories.a categories
mv categories_custom categories_custom.a && mv categories_custom.a categories_custom
mv privacy privacy.a && mv privacy.a privacy
