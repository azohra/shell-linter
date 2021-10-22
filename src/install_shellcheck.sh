#!/bin/bash

# Update shellcheck to the locked v0.7.0 version through the binary distribution
scversion='v0.7.2'
          
wget -qO- "https://github.com/koalaman/shellcheck/releases/download/${scversion?}/shellcheck-${scversion?}.linux.x86_64.tar.xz" | tar -xJv
cp "shellcheck-${scversion}/shellcheck" /usr/local/bin
shellcheck --version