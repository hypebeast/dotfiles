if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set PATH
fish_add_path -a $DOTFILES/bin $HOME/.bin $HOME/.local/bin /opt/homebrew/bin /usr/local/bin /opt/homebrew/opt/libpq/bin $HOME/.pub-cache/bin $PYENV_ROOT/bin $HOME/.dotnet/tools $HOME/Coding/go/bin

# Pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
pyenv init - | source

# Java
set -Ux INTEL_HAXM_HOME /usr/local/Caskroom/intel-haxm
set -Ux JAVA_HOME (/usr/libexec/java_home -v 1.8)

# Flutter
export FLUTTER_ROOT="$(asdf where flutter)"

# Gopath
set -Ux GOPATH $HOME/Coding/go

# Direnv
direnv hook fish | source

# bun
set --export BUN_INSTALL "$HOME/Library/Application Support/reflex/bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Added by Windsurf
fish_add_path /Users/seru/.codeium/windsurf/bin
