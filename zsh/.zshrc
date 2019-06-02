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
