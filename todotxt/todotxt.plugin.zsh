###
# todo.sh: https://github.com/ginatrapani/todo.txt-cli
###

function txt() { 
  if [ $# -eq 0 ]; then
    todo.sh ls
  else
    todo.sh $*
  fi
}

alias n="txt ls @next"
alias ta="txt lsp A"
alias tb="txt lsp B"
alias tc="txt lsp C"
