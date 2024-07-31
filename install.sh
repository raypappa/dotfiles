#!/bin/bash

set -e

. .install

for fn in "_install_deps" "_source_bashrc" "_install_cspell" "_install_alacrity_support" "_install_nvshim" "_configure_nvim" "_configure_global_git" "_source_bashrc" "_configure_locale" "_start_ssh_agent";do
  confirm "Execute $fn" && ${!fn}
done

echo "krew plugin for df-pv available but not installed by default"
echo Please restart terminal.
