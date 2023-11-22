function pubkey
    cat ~/.ssh/id_ed25519.pub | pbcopy; and echo '=> Public key copied to pasteboard.'
end

