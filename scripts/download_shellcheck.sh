#! /bin/bash

# Update shellcheck to the latest by downloading the binary
scversion="latest"
          
wget -qO- "https://storage.googleapis.com/shellcheck/shellcheck-${scversion?}.linux.x86_64.tar.xz" | tar -xJv
sudo cp "shellcheck-${scversion}/shellcheck" /usr/bin/
shellcheck -V