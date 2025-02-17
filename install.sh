#!/bin/bash

. $HOME/.bashrc

set -e

. .install

for fn in \
  "_install_deps" \
  "_install_brew" \
  "_install_brew_packages" \
  "_install_bash_it" \
  "_install_nvm" \
  "_install_cspell" \
  "_install_alacrity_support" \
  "_install_nvshim" \
  "_configure_nvim" \
  "_configure_locale" \
  "_start_ssh_agent" \
  "_setup_rust" \
  "_setup_goenv"
do
  # confirm "Execute $fn" && ${fn}
  ${fn}
done

echo "krew plugin for df-pv available but not installed by default"
echo Please restart terminal.
