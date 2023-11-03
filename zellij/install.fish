#!/usr/bin/env fish

if command -qs zellij
    exit
end

set -l zellij_version v0.38.2

curl -L -o /tmp/zellij.tar.gz "https://github.com/zellij-org/zellij/releases/download/$zellij_version/zellij-x86_64-unknown-linux-musl.tar.gz"
pushd /tmp
tar -xvf zellij*.tar.gz
chmod +x zellij
mv zellij ~/.bin
rm /tmp/zellij.tar.gz
popd

