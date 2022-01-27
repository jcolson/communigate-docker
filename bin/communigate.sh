#!/bin/sh
rm -f /var/CommuniGate/ProcessID
/etc/init.d/CommuniGate start
sleep 5
tail --pid=`cat /var/CommuniGate/ProcessID` -f /dev/null
