#!/usr/bin/env fish

function fish_greeting
    fortune | cowsay | lolcat
end
funcsave -q fish_greeting

if command -qs eza
    alias l='eza -lah --icons'
    alias ll='eza -lh --icons'
    alias lr='eza -lhr --icons'
    alias lr='eza -a -l -s changed --icons'

    abbr -a lt 'eza --tree --level 2 -D'
    abbr -a ltt 'eza --tree --level 3 -D'
    abbr -a lttt 'eza --tree --level 4 -D'
    abbr -a lt3 'eza --tree -D --level 3'
    abbr -a lt4 'eza --tree -D --level 4'
    abbr -a lt5 'eza --tree -D --level 5'

    abbr -a t2 'eza --tree --icons --level 2'
    abbr -a t3 'eza --tree --icons --level 3'
    abbr -a t4 'eza --tree --icons --level 4'
    abbr -a t5 'eza --tree --icons --level 5'
else
    alias l='ls -lAh'
    alias ll='ls -l'
end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

#abbr -a t1 'tree -I "node_modules|vendor" -d -L 1'

# quickly jump to recently used directories
abbr -a 1 'prevd 1'
abbr -a 2 'prevd 2'
abbr -a 3 'prevd 3'
abbr -a 4 'prevd 4'
abbr -a 5 'prevd 5'

abbr -a less 'less -r'
abbr -a lg lazygit
abbr -a repos 'cd ~/Coding'
abbr -a dotfiles 'cd ~/.dotfiles'
abbr -a mk 'mkdir -p'
abbr -a v nvim
abbr -a rg 'rg -i'
