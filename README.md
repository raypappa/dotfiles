# dotfiles

Currently I'm using tmux, bash, and neovim for tooling workflows. Other
items may not be very well maintained

**NOTE: Don't forget to copy the alacritty.yml/toml file to windows to %APPDATA%\alacritty\alacritty.yml**

## Bootstrap on Windows

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

powercfg.exe /hibernate off

wsl --install

Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco upgrade -y  7zip.install alacritty.install cccp chocolatey chocolatey-compatibility.extension chocolatey-core.extension chocolatey-windowsupdate.extension Firefox firefox greenshot launchy nodejs.install nosql-workbench OpenHardwareMonitor powershell-core pwsh slack sublimetext4 sysinternals vlc.install vscode.install yubikey-manager yubikey-piv-manager zoom

refreshenv

wsl --set-default-version 2

wsl --install -d Debian
```

## AWS CLI Windows

```powershell
Invoke-Expression "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12"
Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -Outfile C:\AWSCLIV2.msi
Start-Process msiexec.exe -ArgumentList "/i `"C:\AWSCLIV2.msi`" /quiet" -Wait
```

## Pre-requisites
1. Generate your SSH key
1. Add ssh key to github
1. clone repo in wsl/linux/mac
   ```bash
   git clone git@github.com:blade2005/dotfiles.git ~/.local/src/dotfiles
   ```

## Install script

Installs a lot of things. It's categorized in functions so it's easy to see from the [install](./install.sh) script.

### Docker
Docker has some special stuff which is mostly preset but you'll need to configure the daemon and sudoers
https://github.com/bowmanjd/docker-wsl

`/etc/docker/daemon.json`
```json
{
  "hosts": ["unix:///mnt/wsl/shared-docker/docker.sock"]
}
```

`/etc/sudoers.d/docker`
```sudo
%docker ALL = (root) NOPASSWD: /usr/bin/dockerd
```

### tmux
started having issues with tmux. might need to override `TERM=xterm-256color` instead of `alacritty`

### TODO
