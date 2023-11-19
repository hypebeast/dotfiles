if status is-interactive
    # Commands to run in interactive sessions can go here
end

# PATH
fish_add_path -a $DOTFILES/bin $HOME/.bin $HOME/.local/bin /opt/homebrew/bin /usr/local/bin /opt/homebrew/opt/libpq/bin

source /opt/homebrew/opt/asdf/libexec/asdf.fish
