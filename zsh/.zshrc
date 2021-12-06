_has(){
    command type "$1" > /dev/null 2>&1
}

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# shortcut to this dotfiles path is $ZSH
export DOTFILES=$HOME/.dotfiles

# your project folder that we can `c [tab]` to
export PROJECTS=~/Coding

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME=""

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# define plugins
declare -a plugins

common_plugins=(
    git
    github
    node
    npm
    themes
    fasd
    web-search
    wd
    cp
    dirhistory
    urltools
    vagrant
    grunt
    common-aliases
    copydir
    copyfile
    github
    docker
    docker-compose
    history-substring-search
    zsh-autosuggestions
    zsh-syntax-highlighting
    kubectl
)

linux_plugins=(
)

macos_plugins=(
    macos
    brew
)

if [[ "$OSTYPE" == linux* ]]; then
    plugins=($common_plugins $linux_plugins)
elif [[ "$OSTYPE" == darwin* ]]; then
    plugins=($common_plugins $macos_plugins)
else
    plugins=($common_plugins)
fi

# Load dircolors
if [[ "$OSTYPE" == darwin* ]]; then
  test -r ~/.dir_colors && eval $(gdircolors ~/.dir_colors)
else
  test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)
fi

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

#ZSH_THEME="powerlevel10k/powerlevel10k"

# Load pure prompt (https://github.com/sindresorhus/pure)
autoload -U promptinit; promptinit
prompt pure

# Things I don't want to publish to github
[[ -s "$HOME/.secrets" ]] && source "$HOME/.secrets"

# Source my secrets
if [ -d $HOME/.secrets ]; then
  for file in $HOME/.secrets/**/*.zsh; do
      source $file
  done
fi

#export PROMPT="$PROMPT\$(git-radar --zsh --fetch) "

# Set xterm to support 256 colors
if [[ "$COLORTERM" == xfce4-terminal ]]; then
    export TERM=xterm-256color
fi

#export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# GVM: THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.gvm/bin/gvm-init.sh" ]] && source "$HOME/.gvm/bin/gvm-init.sh"

export PATH="$HOME/.poetry/bin:$PATH"
