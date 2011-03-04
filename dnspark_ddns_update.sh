#!/bin/bash
USERNAME=mycroft
PASSWORD=dakota6
HOSTNAME=fish.microft.org
IP=123.123.123.123


curl "https://$USERNAME:$PASSWORD@www.dnspark.net/api/dynamic/update.php?hostname=$HOSTNAME&ip=$IP&mx=ON&mxpri=5"

