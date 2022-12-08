# configs

Currently I'm using tmux, bash, and neovim for tooling workflows. Other
items may not be very well maintained

## Bootstrap on Windows
```pwsh
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install -y  firefox vscode lastpass launchy slack alacritty pwsh lastpass-for-applications 7zip.install zoom sysinternals vlc cccp greenshot sublimetext4 nodejs
refreshenv
npm install -g aws-azure-login
wsl --install
```
## AWS CLI
```pwsh
Invoke-Expression "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12"
Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -Outfile C:\AWSCLIV2.msi
Start-Process msiexec.exe -ArgumentList "/i `"C:\AWSCLIV2.msi`" /quiet" -Wait
```

## [NVM](https://github.com/nvm-sh/nvm)
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
```
## [TFEnv](https://github.com/tfutils/tfenv)
```bash
git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
```
## [PyEnv](https://github.com/pyenv/pyenv)
```bash
curl https://pyenv.run | bash
sudo apt update; sudo apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev \
xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
pyenv install 3.10.2
pyenv global 3.10.2
```
## [RBEnv](https://github.com/rbenv/rbenv)
```bash
sudo apt install -y libssl-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
```

## NeoVIM
1. Go to
   [releases](https://github.com/neovim/neovim/releases/tag/stable)
1. Find the appropriate release assest (eg. `nvim-linux64.deb`)
1. Download the release asset and install

Alternatively this should be a static link to the latest deb package
[link](https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb)
```bash
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb
rm nvim-linux64.deb
```

## Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
