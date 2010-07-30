#!/bin/bash
# Requirements:
#  bash commands: dd md5sum sha512sum cut od head
USERNAME=${1:?username?}
SERVICE=${2:?service?}
KEYFILE=${3}
if [ ! $KEYFILE ]; then 
    echo "Using default key file"
    KEYFILE=~/password_keyfile
fi
if [ ! -e $KEYFILE ]; then
    echo "Key file ($KEYFILE) does not exist."
    echo -n "Do you wish to generate it? [y/N] ";
    read GENFILE
    echo
    if [[ $GENFILE == y* || $GENFILE == Y*  ]]; then
        echo "Generating key file"
        dd if=/dev/urandom of=$KEYFILE bs=100 count=104857
    else
        echo "Exiting"
        exit
    fi
fi
echo 
read -s -p "Enter Passphrase " PASSPHRASE 
echo
KNOW=`echo "$PASSPHRASE:$USERNAME@$SERVICE" | md5sum | od | head -n 1 `
SKIP=`echo $KNOW | cut -b 9-14`
COUNT=`echo $KNOW | cut -b 16-21`
echo -n "Your password is: "
BASE=`dd if=$KEYFILE bs=100 skip=$SKIP count=$COUNT 2>/dev/null | sha512sum `
echo $BASE | cut -b 1-10
echo "$USERNAME $SERVICE" >> ~/Dropbox/services.txt
sleep 10 
clear
