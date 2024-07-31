#!/bin/bash

set -e

. .install

_install_deps

. "$HOME/.bashrc"

_install_cspell
_install_alacrity_support
_install_nvshim

_configure_nvim
_configure_global_git
echo "krew plugin for df-pv available but not installed by default"


. ~/.bashrc

_configure_locale
_start_ssh_agent

echo Please restart terminal.
