#!/bin/bash
base_dir=~/.config/nvim

if ! type nvim; then
  if grep -P --quiet '(?<=ID=)debian$' /etc/os-release; then
    sudo apt-get remove -y --purge vim*
    sudo apt-get install -y git
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
    sudo apt install ./nvim-linux64.deb
    rm nvim-linux64.deb
    sudo update-alternatives --install /usr/local/bin/vim vim $(which nvim) 20
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

pushd $base_dir/bundle/plugins/flake8-vim/ftplugin/python/pycodestyle && git checkout main && git pull; popd
