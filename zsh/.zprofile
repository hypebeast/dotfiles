###
# brew 
###
if [[ "$OSTYPE" == darwin* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

###
# pyenv
###
if [[ "$OSTYPE" == darwin* ]]; then
  eval "$(pyenv init --path)"
else
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi
