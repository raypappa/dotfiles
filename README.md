# configs

Currently I'm using tmux, bash, and neovim for tooling workflows. Other
items may not be very well maintained

**NOTE: Don't forget to copy the alacritty.yml file to windows**

## Bootstrap on Windows
```pwsh
wsl --install
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install -y  firefox vscode lastpass launchy slack alacritty pwsh lastpass-for-applications 7zip.install zoom sysinternals vlc cccp greenshot sublimetext4 nodejs
refreshenv
```

## AWS CLI Windows
```pwsh
Invoke-Expression "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12"
Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -Outfile C:\AWSCLIV2.msi
Start-Process msiexec.exe -ArgumentList "/i `"C:\AWSCLIV2.msi`" /quiet" -Wait
```

## Pre-requisites
1. Generate your SSH key
1. Add ssh key to github
1. clone repo in wsl/linux/mac
   ```bash
   git clone git@github.com:blade2005/configs.git ~/.local/src/configs
   ```

## Install script
1. Installs [NVM](https://github.com/nvm-sh/nvm)
1. Installs [TFEnv](https://github.com/tfutils/tfenv)
1. Installs [PyEnv](https://github.com/pyenv/pyenv)
1. Installs [RBEnv](https://github.com/rbenv/rbenv)
1. Installs NeoVim
1. Installs Rust
1. Configures NeoVim
1. Installs symlinks

### Docker
Docker has some special stuff which is mostly preset but you'll need to configure the daemon and sudoers
https://github.com/bowmanjd/docker-wsl
`/etc/docker/daemon.json`
```json
{
  "hosts": ["unix:///mnt/wsl/shared-docker/docker.sock"],
  "iptables": false
}
```
`/etc/sudoers.d/docker`
```sudo
%docker ALL = (root) NOPASSWD: /usr/bin/dockerd
```

### tmux
started having issues with tmux. might need to override `TERM=xterm-256color` instead of `alacritty`

### TODO
