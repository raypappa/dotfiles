#!/bin/bash
base_git_dir=~/.local/src/configs
./vim.install.sh
files="
~/.bash_aliases
~/.bash_logout
~/.bash_profile
~/.bashrc
~/.dircolors
~/.inputrc
~/.profile
~/.screenrc
~/.tmux.conf
~/.zcompdump
~/.zpath
~/.zprofile
~/.zshenv
~/.zshrc
~/.zshrc.zni
"
for file in $files ;do
  file="${file/#~/$HOME}"
  if [ ! -e $file ];then
    filename=$(basename $file)
    echo "Installing symlink for $file"
    ln -s $base_git_dir/$filename $file
  fi
done
mkdir ~/.local/bin -p
ln -s $base_git_dir/bin/credentials-to-env ~/.local/bin/credentials-to-env
