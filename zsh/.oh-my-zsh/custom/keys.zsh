####
# Some shortcuts for working with my keys.
#
# Original version from Zach Holman (https://github.com/holman/dotfiles/blob/master/system/keys.zsh)
# 
# Last Update: 2012.12.29
####

# Pipe my public key to my clipboard. Fuck you, pay me.
alias pubkey="more ~/.ssh/id_ed25519.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Copy my public key to a remote host
function ssh-copy () {
    cat ~/.ssh/id_ed25519.pub | ssh $@ 'mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys'
}
