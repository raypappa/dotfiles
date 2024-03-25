#!/bin/bash

. .install

_install_deps

_install_symlinks

. ~/.bashrc

_install_alacrity_support
_install_polyglot_prompt
_install_rbenv
_install_pyenv
_install_pipx
_install_poetry
_install_nvm
_install_nvshim
_install_tfenv
_install_rust
_install_aws_azure_login
_install_cspell
_install_aws
_install_docker
_install_lazydocker
_install_vim
_configure_nvim
_install_tflint
_install_sam_cli
_install_taskfile_cli
_configure_global_git
_install_gh_cli
_install_kubectl
_install_pnpm
_install_golang

. ~/.bashrc

_configure_locale
_start_ssh_agent

echo Please restart terminal.
