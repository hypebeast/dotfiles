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
export ZSH_THEME="spaceship"

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
    ruby
    github
    node
    npm
    sublime
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
    go
)

linux_plugins=(
)

macos_plugins=(
    osx
    brew
)

if [[ "$OSTYPE" == linux* ]]; then
    plugins=($common_plugins $linux_plugins)
elif [[ "$OSTYPE" == darwin* ]]; then
    plugins=($common_plugins $macos_plugins)
else
    plugins=($common_plugins)
fi

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Things I don't want to publish to github
[[ -s "$HOME/.secrets" ]] && source "$HOME/.secrets"

# Source my secrets
if [ -d $HOME/.secrets ]; then
  for file in $HOME/.secrets/**/*.zsh; do
      source $file
  done
fi

#export PROMPT="$PROMPT\$(git-radar --zsh --fetch) "

# Load dircolors
if [[ "$OSTYPE" == darwin* ]]; then
  eval `gdircolors ${DOTFILES}/libs/dircolors-solarized/dircolors.ansi-dark`
else
  eval `dircolors ${DOTFILES}/libs/dircolors-solarized/dircolors.ansi-dark`
fi

# Set xterm to support 256 colors
if [ "$COLORTERM" == "xfce4-terminal" ] ; then
    export TERM=xterm-256color
fi

# added by travis gem
[ -f /Users/sruml/.travis/travis.sh ] && source /Users/sruml/.travis/travis.sh

#export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Initialize rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# SZCMS settings
[ -s "/projects/szcms_tools/ENV.sh" ] && source /projects/szcms_tools/ENV.sh

# tmux-powerline
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
export TMUX_POWERLINE_SEG_WEATHER_LOCATION="676757"

# GVM: THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.gvm/bin/gvm-init.sh" ]] && source "$HOME/.gvm/bin/gvm-init.sh"

