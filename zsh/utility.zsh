# File Download
if (( $+commands[curl] )); then
    alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
    alias get='wget --continue --progress=bar --timestamping'
fi

# CtrlP for zsh
ctrlp() {
    </dev/tty vim -c CtrlP
}
zle -N ctrlp

bindkey "^p" ctrlp
