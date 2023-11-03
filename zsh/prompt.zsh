autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "on %{$fg[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>&1
}

need_push () {
  if $(! $git staus -s &> /dev/null) || [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg[magenta]%}unpushed%{$reset_color%} "
  fi
}

directory_name() {
  echo "%{$fg[cyan]%}%0~%{$reset_color%}"
}

export PROMPT=$'\n'"%{$fg[magenta]%}┌─%{$reset_color%} [%{$fg[green]%} %D{%Y-%m-%d} %* %{$reset_color%}]:"$' $(directory_name) $(git_dirty)$(need_push)\n'"%{$fg[magenta]%}└─ %n@%m ➜ %{$reset_color%} "
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}