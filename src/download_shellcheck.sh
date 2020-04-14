#! /bin/bash

# Update shellcheck to the locked v0.7.0 version through the binary distribution
scversion='v0.7.0'
          
wget -qO- "https://storage.googleapis.com/shellcheck/shellcheck-${scversion?}.linux.x86_64.tar.xz" | tar -xJv
sudo cp "shellcheck-${scversion}/shellcheck" /usr/bin/
shellcheck --version