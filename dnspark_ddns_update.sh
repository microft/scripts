#!/bin/bash
# this script updates a dynamic dns register at dns park
HOSTNAME=$1
IP=$2
USERNAME=$3
PASSWORD=$4

CURL=`which curl`
$CURL "https://$USERNAME:$PASSWORD@www.dnspark.net/api/dynamic/update.php?hostname=$HOSTNAME&ip=$IP&mx=ON&mxpri=5"

