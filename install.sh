#!/bin/bash

. $HOME/.bashrc

set -e

# Build alacritty toml
cp "$HOME/.config/alaciritty/alacritty.base.toml" "$HOME/.config/alacritty.toml"
if [[ "$(uname -s)" == "Darwin" ]];then
  cat "$HOME/.config/alacritty.mac.toml" >> "$HOME/.config/alacritty.toml";
fi
# Windows alacritty gets done with powershell and is run adhoc from a power shell term. See README.md
