#!/bin/bash

windows_menu_entry=$(grep -i 'windows' /boot/grub/grub.cfg | cut -d"'" -f2)
grub-reboot "$windows_menu_entry"
systemctl reboot
