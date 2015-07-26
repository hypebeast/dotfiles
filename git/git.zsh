############################################
# Git Aliases
# Last edit: 2012.03.25
############################################

alias gs='git status'
alias gstsh='git stash'
alias gst='git stash'
alias gsh='git show'
alias gshw='git show'
alias gshow='git show'
alias gi='vi .gitignore'
alias gcim='git ci -m'
alias gci='git ci'
alias gco='git co'
alias gaa='git add -A'
alias ga='git add'
alias gau='git add -u'
alias guns='git unstage'
alias gunc='git uncommit'
alias gm='git merge'
alias gms='git merge --squash'
alias gam='git amend'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gbi='git rebase --interactive'
alias co='git co'
alias gf='git fetch'
alias gfch='git fetch'
alias gd='git diff'
alias gdv='git diff > diff; vim diff'
alias gdvc='git diff --cached > diff; vim diff'
alias gb='git b' # list all branches
alias gbr='git b -r' # list all remote branches
alias gdc='git diff --cached'
alias gpub='grb publish'
alias gtr='grb track'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias gpsh='git push'
alias gnb='git nb' # new branch aka checkout -b
alias grs='git reset'
alias grsh='git reset --hard'
alias gcln='git clean'
alias gclndf='git clean -df'
alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias gt='git t' # list all tags
alias gdm='git branch --merged | grep -E "(feature|bugfix|hotfix)" | xargs -n 1 git branch -d'

function git_included_tickets_in_release () {
    if [[ -n $1 && -n $2 && -n $3 ]] ; then
        git log $1..$2 | grep -i -o -e "$3-[0-9]*" | sort | uniq
    else
        print "Usage: tir last_tag_name new_tag_name jira_project_name(SZINT) (run gt to show all tags)"
    fi
}
alias tir=git_included_tickets_in_release
