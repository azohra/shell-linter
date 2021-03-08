#! /bin/bash

# Update shellcheck to the locked v0.7.0 version through the binary distribution
scversion='v0.7.1'

wget -qO- "https://github.com/koalaman/shellcheck/releases/download/${scversion?}/shellcheck-${scversion?}.linux.x86_64.tar.xz" | tar -xJv
sudo cp "shellcheck-${scversion}/shellcheck" /usr/bin/
shellcheck --version
