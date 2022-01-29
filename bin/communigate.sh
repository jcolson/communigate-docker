#!/usr/bin/env sh
rm -f /var/CommuniGate/ProcessID
/etc/init.d/CommuniGate start
sleep 5
trap "echo Caught Trap && /etc/init.d/CommuniGate stop" 1 2 3 6 15
tail --pid=`cat /var/CommuniGate/ProcessID` -f /dev/null
