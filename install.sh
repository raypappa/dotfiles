#!/bin/bash

. .install

_install_deps

. ~/.bashrc

# Programming languages/language version management
_install_goenv
_install_rbenv
_install_pyenv
_install_nvm
_install_nvshim
_install_rust

# Tool version management
_install_tfenv

# Package managers
_install_poetry
_install_pipx
_install_pnpm

# Tools
_install_cspell
_install_aws
_install_tflint
_install_sam_cli
_install_taskfile_cli
_install_kubectl
_install_glow
_install_aws_vault
_install_ripgrep
_install_fd
_install_ctags
_install_vale
_install_aws_azure_login
_install_gh_cli
_install_vim

# Others
_install_polyglot_prompt
_install_alacrity_support
_install_docker
_install_lazydocker
_configure_nvim
_configure_global_git
echo "krew plugin for df-pv available but not installed by default"


. ~/.bashrc

_configure_locale
_start_ssh_agent

echo Please restart terminal.
