#cp interactive and recursive
alias 'cp'='cp -i -r'

#rm recursive
alias 'rm'='rm -r'

#mv interactive
alias 'mv'='mv -i'

#du human readable values and all files and directories for the current or given directory
alias 'du'='du --max-depth=1 --human-readable --all'

#ckan; ksp mod package manager #also deletes the registry file that can cause errors on startup
alias 'ckan'='rm /home/adam/Games/pc/kerbal-space-program/CKAN/registry.locked; /home/adam/Games/pc/kerbal-space-program/ckan.exe'

#shutdown
alias 'shutdown'='sudo shutdown now'

#show wine environment variables
alias 'wine-env'='printenv | grep WINE'

#urxvt
alias 'rxvt-unicode-256color'='urxvt'
