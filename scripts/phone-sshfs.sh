#!/bin/bash

phoneUser="root"
phoneIP="192.168.1.101"
phoneDirectory="/sdcard/" #The phone directory to mount
phonePort="40713"
mountPoint="/mnt/sma520f/"

if [ $( ls $mountPoint* &> /dev/null; echo $? ) -eq 2 ]; then
##Do this if not mounted
	echo ""
#	echo "%{A:sshfs $phoneUser@$phoneIP:$phoneDirectory -p $phonePort $mountPoint; echo -ne '\007':}Not mounted%{A}"
else
#Do this if mounted
	echo ""
#	echo "%{A:fusermount -u $mountPoint; echo -ne '\007':}Mounted%{A}"
fi
