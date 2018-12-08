#!/bin/bash

# A script to deal with backups

# It would be good practice to keep a list of installed packages
dpkg -l | awk '/^[hi]i/{print $2}' > ~/.installed-packages

# Backup important files from root
rsync --archive --delete --verbose /etc/apt /etc/fstab /etc/X11 ~/.etc\~

# We only want to start the backup if the backup media is mounted
if [ $(ls /mnt/backup/* &> /dev/null; echo $?) -eq 0 ]; then

	  # Do this if the partition is mounted
    rsync --archive --delete --exclude={"adam/.android-backup","adam/.android-mirror","adam/.cache","adam/.mount-phone.log","adam/.mozilla","adam/.macromedia"} --verbose /home/adam /mnt/backup/home

fi
