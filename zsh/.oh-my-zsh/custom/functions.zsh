#######################################
# Various ZSH Functions
# Last edit: Sat Jan 28 14:24:13 CET 2017
#######################################


# (f)ind by (n)ame
# usage: fn foo 
# to find all files containing 'foo' in the name
function fn() { ls **/*$1* }

function fnd() { ls **/*$1*(/) }

# directory LS
function dls() {
 echo `ls -l | grep "^d" | awk '{ print $9 }' | tr -d "/"`
}

# A ecursive, case-insensitive grep that excludes binary files
function dgrep() {
    grep -iR "$@" * | grep -v "Binary"
}

# A recursive, case-insensitive grep that excludes binary files
# and returns only unique filenames
function dfgrep() {
    grep -iR "$@" * | grep -v "Binary" | sed 's/:/ /g' | awk '{ print $1 }' | sort | uniq
}

function psgrep() {
    if [ ! -z $1 ] ; then
        echo "Grepping for processes matching $1..."
        ps aux | grep $1 | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

# Kills any process that matches a regexp passed to it
function killit() {
    ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

# Makes a directory and changes to it.
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pushes an entry onto the directory stack and lists its contents.
function pushdls {
  builtin pushd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pops an entry off the directory stack and lists its contents.
function popdls {
  builtin popd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Prints columns 1 2 3 ... n.
function slit {
  awk "{ print ${(j:,:):-\$${^@}} }"
}

# Finds files and executes a command on them.
function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Displays user owned processes status.
function psu {
  ps -U "${1:-$USER}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

# Display markdown documents with lynx
function view-markdown() {
  local file=$1
  pandoc $file | lynx -stdin
}
alias vmk=view-markdown

# File download
function get() {
  local file=$1

  if (( $+commands[curl] )); then
    curl --continue-at - --location --progress-bar --remote-name --remote-time $1
  elif (( $+commands[wget] )); then
    wget --continue --progress=bar --timestamping $1
  fi
}

# CtrlP for zsh
function ctrlp() {
    </dev/tty vim -c CtrlP
}
zle -N ctrlp

bindkey "^p" ctrlp

# search for aliases
function find-alias () {
    if [[ $# -gt 0 ]]; then
        alias | grep -i $@
    else
        alias
    fi
}
alias fa=find-alias

# My personal wiki
function open-notes () {
    cd $HOME/Netlight/documents/work-notebook
    vim -c CtrlP
}
alias opn=open-notes

# recive infos about HTTP status codes
function status-code () {
    curl -s https://httpstatuses.com/$1 | lynx -stdin
}

function cdd() {
  cd "$(ls -d -- */ | fzf)" || echo "Invalid directory"
}

function j() {
  fname=$(declare -f -F _z)

  [ -n "$fname" ] || source "$DOTFILES_PATH/modules/z/z.sh"

  _z "$1"
}

function recent_dirs() {
  # This script depends on pushd. It works better with autopush enabled in ZSH
  escaped_home=$(echo $HOME | sed 's/\//\\\//g')
  selected=$(dirs -p | sort -u | fzf)

  cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}
