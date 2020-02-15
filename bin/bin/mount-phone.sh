#!/bin/bash

# A script to automatically mount phone through sshfs and perform backups and other related tasks. It mounts the phone when it is found to be connected to the home network. It is invoked through .xinitrc.

# Variables
phoneName="8B2X129GV"
phoneUser="root"
phoneIP="192.168.1.102"
phoneDirectory="/sdcard/" #The phone directory to mount
phonePort="31946"
mountPoint="/mnt/${phoneName}/"
backupLocation="/home/adam/.${phoneName}-backup/"
mirrorLocation="/home/adam/.${phoneName}-mirror/"
logFile="/home/adam/.mount-phone.log"

# Move the old log to allow a new one to be generated, and redirect all output to the new file
mv $logFile $logFile~
exec &> $logFile

# Main loop
while :
do

  # Is the phone mounted? Returns 0 if yes, 2 if no
	if [ $( ls $mountPoint* &> /dev/null; echo $? ) -eq 2 ]; then

    # If phone is not mounted, ping the phone to determine whether it is connected to the network. If not, continue until it is
		ping -c 1 $phoneIP &>/dev/null
		until [ $? -eq 0 ]; do
			echo $(date +%k:%M) "Phone not found on network, searching again"
			ping -c 1 $phoneIP &>/dev/null
		done
		echo $(date +%k:%M) "Phone found on network... Attempting to mount"

		# Mount the phone
		sshfs $phoneUser@$phoneIP:$phoneDirectory -p $phonePort $mountPoint -o ServerAliveInterval=5,ServerAliveCountMax=3 &>/dev/null

		# A message if mounting successful
		if [ $? = 0 ]; then
			echo $(date +%k:%M) "Phone mounted to $mountPoint"

			# Backup the files on the phone
			echo $(date +%k:%M) "Starting back ups..."

			# Main backup of all files; exclude photos as they are stored at full resolution on Google Photos and are backed up seperately locally
			rsync --recursive --archive --human-readable --compress $mountPoint $backupLocation --exclude "DCIM" &&\
			# Sync these folders, possibly deleting files locally if necessary
			rsync --recursive --archive --human-readable --compress --delete $mountPoint $mirrorLocation --exclude "DCIM" &&\
			rsync --recursive --archive --human-readable --compress "$mountPoint"DCIM/Camera/* /home/adam/Pictures/photos/.Camera &&\
			rsync --recursive --archive --human-readable --compress "$mountPoint"DCIM/ /home/adam/Pictures/photos --exclude "Camera" --exclude "Screenshots" --exclude "Video trimmer" &&\
			rsync --recursive --archive --human-readable --compress "$mountPoint"S\ Health/GPX/ /home/adam/Documents/outdoors/gps-tracks &&\
			rsync --recursive --archive --human-readable --compress "$mountPoint"Pictures/ /home/adam/Pictures/8B2X129GV

			# Print messages dictating the success or failure of the backups
			if [ $? -gt 0 ]; then
				echo $(date +%k:%M) "Backups failed"
			else
				echo $(date +%k:%M) "Backups successful"
			fi

# Other tasks to perform after mounting and backups are complete

# Delete any duplicate photos after they have been moved to an album
		/home/adam/bin/delete-duplicate-photos.sh

# An error message if mounting failed
		else
			echo $(date +%k:%M) "Error mounting phone to $mountPoint, try running \"sshfs $phoneUser@$phoneIP:$phoneDirectory -p $phonePort $mountPoint -d -o sshfs_debug\" for more details"
		fi

# If the phone is already mounted, print a message saying this
	else
		echo $(date +%k:%M) "Phone already mounted at $mountPoint"
	fi

sleep 30

done
