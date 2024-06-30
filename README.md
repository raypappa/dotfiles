# dotfiles

Currently I'm using tmux, bash, and neovim for tooling workflows. Other
items may not be very well maintained

**NOTE: Don't forget to copy the alacritty.toml file to windows to %APPDATA%\alacritty\alacritty.toml**

## Bootstrap on Windows

### Chocolatey

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco.exe upgrade -y 7zip.install alacritty alacritty.install audacity awscli cccp chocolatey chocolatey-compatibility.extension chocolatey-core.extension chocolatey-dotnetfx.extension chocolatey-windowsupdate.extension dotnet4.5.2 dotnet4.7.1 dotnetfx firefox git.install go-task greenshot launchy nodejs nodejs.install nosql-workbench openhardwaremonitor powershell-core pwsh rancher-desktop slack sourcetree sublimetext4 sysinternals vcredist140 vcredist2015 vlc.install vscode.install yubikey-manager yubikey-piv-manager zoom

refreshenv.cmd
```

### WSL

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

powercfg.exe /hibernate off

wsl.exe --set-default-version 2
wsl.exe --install -d Debian
```

## Pre-requisites

1. Generate your SSH key
1. Add ssh key to github
1. clone repo in wsl/linux/mac

```bash
git clone --bare git@github.com:blade2005/dotfiles.git ~/.cfg
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout main --force
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
```

## Install script

Installs a lot of things. It's categorized in functions so it's easy to see from the [install](./install.sh) script.

### tmux

started having issues with tmux. might need to override `TERM=xterm-256color` instead of `alacritty`

### alacritty on windows

After installing alacritty via Chocolatey you'll need to copy the toml file to the correct location `%APPDATA%\\alacritty` and add the following snippet to the file

```
[shell]
args = ["-d Ubuntu", "--cd ~"]
program = "wsl"
```

So that alacritty opens wsl instead of powershell by default

### TODO

