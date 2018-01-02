############################################
# fzf (https://github.com/junegunn/fzf) 
#
# Sebastian Ruml, <sebastian@sebastianruml.name>
############################################

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set default options for Ctrl-R
export FZF_CTRL_R_OPTS='--exact'

# Set default options for Alt-C
export FZF_ALT_C_OPTS="--exact --preview 'tree -C {} | head -200'"

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
vf() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}

# fuzzy grep open via ag
vg() {
    local file

    file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1}')"

    if [[ -n $file  ]]
    then
        ${EDITOR} $file
    fi
}

# cdf - cd into the directory of the selected file
cdf() {
 local file
 local dir
 file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# fh - repeat history
fh() {
    eval $( ([ -n "$ZSH_NAME"  ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//' )
}

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Find bookmarks and open it with surfraw
fzf-surfraw() {
    surfraw "$(cat ~/.config/surfraw/bookmarks | sed '/^$/d' | sort -n | fzf -e)"
}
alias fbk=fzf-surfraw

# jump to resently used directory
j() {
    [ $# -gt 0  ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

