####
# Some shortcuts for working with my keys.
#
# Original version from Zach Holman (https://github.com/holman/dotfiles/blob/master/system/keys.zsh)
# 
# Last Update: 2012.12.29
####

# Pipe my public key to my clipboard. Fuck you, pay me.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
