#!/usr/bin/env sh
APPLICATION="/opt/CommuniGate"
BASEFOLDER="/var/CommuniGate"
SUPPLPARAMS=
[ -f ${APPLICATION}/CGServer ] || exit 0
ulimit -c 2097151
umask 0
rm -f /var/CommuniGate/ProcessID
cp /TrustedCerts.settings /var/CommuniGate/Settings/
if [ -d ${BASEFOLDER} ] ; then
    echo "${BASEFOLDER} already exists..."
else
    echo "Creating the CommuniGate Base Folder..."
    mkdir ${BASEFOLDER}
    chgrp mail ${BASEFOLDER}
    chmod 2770 ${BASEFOLDER}
fi
echo "Starting CommuniGate Pro"
exec ${APPLICATION}/CGServer \
    --Base ${BASEFOLDER} \
#   --Daemon ${SUPPLPARAMS} \
#	--ClusterBackend
#	--ClusterFrontend

#    touch /var/lock/subsys/CommuniGate