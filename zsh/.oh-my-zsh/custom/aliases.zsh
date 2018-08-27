#######################################
## Set ZSH config options
##
## Sebastian Ruml, <sebastian@sebastianruml.name>
## Last Edit: Sat Jan 28 18:09:06 CET 2017
#######################################

# unset some aliases from oh-my-zsh
unalias sp

# ls
alias lr='ls -alhtr'
alias l='ls -alh'
alias ll='ls -lFh'

# Aliases for the wonderful tree command
alias t1='tree -d -L 1'
alias t2='tree -d -L 2'
alias t3='tree -d -L 3'
alias t3='tree -d -L 3'
alias t4='tree -d -L 4'

# PS
alias psa="ps aux"
alias psg="ps aux | grep -i"

# Various custom aliases
alias -g EG='|& egrep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g ETL='|& tail -20'
alias -g ET='|& tail'
alias -g F=' | fmt -'
alias -g HL='|& head -20'
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g LL="2>&1 | less"
alias -g LS='| less -S'
alias -g MM='| most'
alias -g M='| more'
alias -g NE="2> /dev/null"
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g PIPE='|'
alias -g R=' > /c/aaa/tee.txt '
alias -g RNS='| sort -nr'
alias -g S='| sort'
alias -g TL='| tail -20'
alias -g US='| sort -u'
alias -g VM=/var/log/messages
alias -g X0G='| xargs -0 egrep'
alias -g X0='| xargs -0'
alias -g XG='| xargs egrep'
alias -g X='| xargs'

# Go
alias go-pi='GOARCH=arm GOARM=5 GOOS=linux go'

# Resource Usage
alias df='df -kh'
alias du='du -kh'

if (( $+commands[htop] )); then
    alias top=htop
else
    alias topc='top -o cpu'
    alias topm='top -o vsize'
fi

# Serves a directory via HTTP.
alias http-serve='python -m SimpleHTTPServer'

# Pretty print JSON
alias pretty-json='python -m json.tool | pygmentize -l json'

# ag - case insensitve and always search hidden files
alias -g agi='ag -i --hidden'

# pt - case insensitve and always search hidden files
alias -g pti='pt -i --hidden'

# print the current date
alias -g now='date +%F'

# Linux specific aliases
if [[ $OSTYPE == linux* ]]; then
    alias open='xdg-open'
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi

# Create directory and change into it
function mkd() {
    mkdir -p "$1" && cd "$1"
}

# Midnight Commander
alias -g mc='mc --nosubshell'
