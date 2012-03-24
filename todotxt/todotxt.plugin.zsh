# todo.sh: https://github.com/ginatrapani/todo.txt-cli
function t() { 
  if [ $# -eq 0 ]; then
    todo.sh ls
  else
    todo.sh $*
  fi
}

alias n="t ls @next"
alias ta="t lsp A"
alias tb="t lsp B"
alias tc="t lsp C"
