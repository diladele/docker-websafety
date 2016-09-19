#!/bin/bash
/opt/qlproxy/bin/certmgr -action="regenerate-certificate-storage"
cd /opt/qlproxy/var/spool
mv adblock adblock.a && mv adblock.a adblock
mv adult adult.a && mv adult.a adult
mv categories categories.a && mv categories.a categories
mv categories_custom categories_custom.a && mv categories_custom.a categories_custom
mv privacy privacy.a && mv privacy.a privacy
