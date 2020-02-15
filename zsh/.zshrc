# Path to oh-my-zsh installation
export ZSH="/home/adam/.oh-my-zsh"

# Name of zsh theme
ZSH_THEME="adamrutter"

# oh-my-zsh plugins
plugins=(zsh-autosuggestions zsh-syntax-highlighting history-substring-search zsh-completions)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Command auto-correction
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# Command execution time format for history
HIST_STAMPS="dd.mm.yyyy"

# Change the history search colours
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=white,fg=black'

# Source .zsh_aliases
. ~/.zsh_aliases

# Set path
export PATH=/home/adam/bin:$PATH

# Don't check for new mail
MAILCHECK=0

# Function to shorten 'git add; git commit; git push'
function gitall() {
  git add .
  if [ -n "$1" ]
  then
    git commit -m "$1"
  else
    git commit -m "Update"
  fi
  git push
}

# Default editor
export EDITOR=/usr/bin/vim

# Environment variables for tldr
export TLDR_HEADER='green bold'
export TLDR_QUOTE='italic'
export TLDR_DESCRIPTION='default'
export TLDR_CODE='green'
export TLDR_PARAM='underline'

# Function to send tldr results to less
function tldr() {
  ~/bin/tldr-script $@ | less
}

# Function to sort results from du
function duh() {
  du --max-depth=1 --human-readable --all $@ | sort -h
}

# Remove '%' from the end of partial lines
export PROMPT_EOL_MARK=''

# Send a notification for completed commands
preexec () {
  CMD=$1
  CMD_START_DATE=$(date +%s)
  WINDOW_ID=$(sed -zn < /proc/$$/environ 's/^WINDOWID=\(.*\)/\1/p')
}

precmd () {
  EXIT_STATUS=$?
  if ! [[ -z $CMD_START_DATE ]]; then
    CMD_NOTIFY_THRESHOLD=5
    SPLIT_CMD=(`echo ${CMD}`)
    BLACKLIST=(
      'vim'
      'man'
      'tldr'
      'less'
      'htop'
    )
    CMD_END_DATE=$(date +%s)
    CMD_ELAPSED_TIME=$(($CMD_END_DATE - $CMD_START_DATE))

    if [[ $CMD_ELAPSED_TIME -gt $CMD_NOTIFY_THRESHOLD ]]; then
      # Check whether the command contains a blacklisted word...
      BLACKLISTED=0
      for i in ${SPLIT_CMD[@]}; do
        if [[ ${BLACKLIST[@]} =~ $i ]]; then
          BLACKLISTED=1
        fi
      done
      # ... And if it doesn't, send a notification
      if [[ $BLACKLISTED -eq 0 ]]; then
        # Set window as urgent
        wmctrl -b add,demands_attention -i -r "$WINDOW_ID"
        if [[ $EXIT_STATUS -eq 0 ]]; then
          notify-send "$CMD" "Completed in $CMD_ELAPSED_TIME seconds."
        else
          notify-send -u critical "$CMD" "Failed after $CMD_ELAPSED_TIME seconds with an exit status of $EXIT_STATUS."
        fi
      fi
    fi
  fi
}
