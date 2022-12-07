#!/bin/bash
base_dir=~/.config/nvim

if [[ -e ~/.config/nvim ]];then
  echo vim already configured. Exiting.
  exit 1
fi

if ! type nvim; then
  if grep -P --quiet '(?<=ID=)debian$' /etc/os-release; then
    sudo apt-get remove -y --purge vim vim-runtime vim-gnome vim-tiny vim-common vim-gui-common vim-nox
    sudo apt-get install -y git neovim
  fi
fi

if [[ ! -e $base_dir ]];then
  pushd ~/.config && ln -s $(dirname $(realpath  ~/.bashrc))/.config/nvim .
fi

if [ ! -d $base_dir/bundle/Vundle.vim ];then
  echo Installing Vundle
  git clone https://github.com/VundleVim/Vundle.vim.git $base_dir/bundle/Vundle.vim
fi

vim +PluginInstall +qall
#
pushd $base_dir/bundle/plugins/coc.nvim && yarn install --frozen-lockfile; popd
vim +PluginInstall +qall

pushd $base_dir/bundle/plugins/flake8-vim/ftplugin/python/pycodestyle && git checkout main && git pull; popd
