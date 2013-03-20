#!/bin/bash
HOSTNAME=$1
IP=$2
USERNAME=$3
PASSWORD=$4

CURRENTIP=`host $HOSTNAME | grep -o "\([0-9]\+\.\)\{3\}[0-9]\+"`

if [ "$IP" != "$CURRENTIP" ]
then
    CURL=`which curl`
    $CURL "https://$USERNAME:$PASSWORD@www.dnspark.net/api/dynamic/update.php?hostname=$HOSTNAME&ip=$IP&mx=ON&mxpri=5"
else
    echo 'no change'
fi
