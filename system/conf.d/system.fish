#!/usr/bin/env fish

function fish_greeting
    fortune | cowsay | lolcat
end
funcsave -q fish_greeting

abbr -a less 'less -r'

if command -qs exa
    alias l='exa -lah --icons'
    alias ll='exa -lh --icons'
    alias lr='exa -lhr --icons'
    alias lt='exa -l --icons --tree --level=2'
    alias lt='exa -l --icons --tree --level=2'
else
    alias l='ls -lAh'
    alias ll='ls -l'
end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

#abbr -a t1 'tree -I "node_modules|vendor" -d -L 1'
abbr -a t1 'exa --tree --level 1'
abbr -a t2 'exa --tree --level 2'
abbr -a t3 'exa --tree --level 3'
abbr -a t4 'exa --tree --level 4'
abbr -a t5 'exa --tree --level 5'

# quickly jump to recently used directories
abbr -a 1 'prevd 1'
abbr -a 2 'prevd 2'
abbr -a 3 'prevd 3'
abbr -a 4 'prevd 4'
abbr -a 5 'prevd 5'

abbr -a mk 'mkdir -p'