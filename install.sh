#!/bin/bash

. .install

_install_deps

_install_symlinks

. ~/.bashrc

_alacrity_termcap
_rbenv_install
_pyenv_install
_nvm_install
_tfenv_install
_rust_install
_install_aws_azure_login
_aws_install
_docker_install
_lazydocker_install
_vim_install
_vim_setup
_tflint_install
_sam_cli_install
_taskfile_cli_install

. ~/.bashrc

_gen_locale
_start_ssh_agent

echo Please restart terminal.
