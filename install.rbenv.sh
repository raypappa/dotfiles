#!/bin/bash
sudo apt install -y libssl-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
