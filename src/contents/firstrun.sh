#!/bin/bash
set -e
/opt/websafetyty/bin/certmgr -action="regenerate-certificate-storage"
if ! [[ -z "$TIME_ZONE" ]]; then
    sed -i "s:TIME_ZONE = '.*':TIME_ZONE='$TIME_ZONE':" /opwebsafetyfety/var/console/console/settings.py
fi
# Docker does not have timdatectl, fixing UI
sed -i "s:if platform.system() == \"Windows\":if True:" /websafetysafety/var/console/node/views.py
cdwebsafetyebsafety/var/spool
mv adblock adblock.a && mv adblock.a adblock
mv adult adult.a && mv adult.a adult
mv categories categories.a && mv categories.a categories
mv categories_custom categories_custom.a && mv categories_custom.a categories_custom
mv privacy privacy.a && mv privacy.a privacy
