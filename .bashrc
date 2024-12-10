# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Path to the bash it configuration
export BASH_IT="$HOME/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='bobby'

# Some themes can show whether `sudo` has a current token or not.
# Set `$THEME_CHECK_SUDO` to `true` to check every prompt:
#THEME_CHECK_SUDO='true'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# (Advanced): Change this to the name of the main development branch if
# you renamed it or if it was changed for some reason
# export BASH_IT_DEVELOPMENT_BRANCH='master'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to the location of your work or project folders
#BASH_IT_PROJECT_PATHS="${HOME}/Projects:/Volumes/work/src"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true
# Set to actual location of gitstatus directory if installed
#export SCM_GIT_GITSTATUS_DIR="$HOME/gitstatus"
# per default gitstatus uses 2 times as many threads as CPU cores, you can change this here if you must
#export GITSTATUS_NUM_THREADS=8

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# If your theme use command duration, uncomment this to
# enable display of last command duration.
#export BASH_IT_COMMAND_DURATION=true
# You can choose the minimum time in seconds before
# command duration is displayed.
#export COMMAND_DURATION_MIN_SECONDS=1

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1


#-------
# DESC: Adds a directory to the PATH if it's not already in the PATH
# ARGS:
#  1 - The directory to add
#  2 - Which end of PATH to add to.  Use "front" to prepend.
#-------
add2path() {
  if ! echo $PATH | egrep "(^|:)$1(:|\$)" > /dev/null ; then
    if [[ $2 = "front" ]]; then
      PATH="$1:$PATH"
    else
      PATH="$PATH:$1"
    fi

    export PATH
  fi
}

# Update dotfiles
if [ -z "$TMUX" ];then
	/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME pull --rebase
fi

if [[ ( -z "${SSH_AGENT_PID}"  && -z "${SSH_AUTH_SOCK}" ) ]]; then
  echo Sourcing agent file
        . ~/.agent;
        /usr/bin/keychain -q --nogui $HOME/.ssh/id_ed25519
        source $HOME/.keychain/$(hostname)-sh
fi;


if [ -x /root/bin/cwd ]; then
        alias cwd='. /root/bin/cwd'
fi;

ulimit -u 2048

export VISUAL="vim"
export EDITOR="vim"
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
###############################################################################
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi

###############################################################################
# History Control
export HISTCONTROL=ignoreboth
shopt -s histappend
export HISTSIZE=-1
export HISTFILESIZE=-1
shopt -s checkwinsize
shopt -s cmdhist
export HISTFILESIZE=1000000
#export HISTSIZE=1000000
export HISTTIMEFORMAT='%F %T '
export PROMPT_COMMAND='history -a'

###############################################################################
# Shell Prompt
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


get_git_branch() {
  local branch=$(git branch --no-color 2>/dev/null | grep '*' | colrm 1 2)
  if [[ -n "$branch" ]];then
    if [[ -n "$1" ]];then
      echo -n " ($branch)"
    else
      echo -en " (${branch})"
    fi
  else
    echo -n ""
  fi
}

# For setting the terminal title
_thing1=$'\e]0;'
_thing2=$'\a'

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

# leaving a note here about tput setaf 125 (this would generate color codes.)
# there's also tput setf too which would be mostly for 8 colors vs xterm
# https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg

# tmux is giving me problems where i'm getting =1s printed out. not sure why.

# Using the polyglot for PS1 so this is just a sane default.
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
unset color_prompt force_color_prompt

# This is here but i've not see this code triggered in so so long.
# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# Load Bash It
source "$BASH_IT"/bash_it.sh
###############################################################################

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  else
    echo "bash-completion not found" >/dev/stderr
  fi
fi

if uname -r | grep -iq wsl;then
    export BROWSER='wslview';
    export PATH=/mnt/c/opscode/chefdk/bin:$PATH
fi

if [[ -n "$WSL_DISTRO_NAME" ]];then
    export TERM="alacritty"
fi

###############################################################################
# Shell tooling

if [[ -e ~/.bashrc.local ]];then
  . ~/.bashrc.local
fi

# Be safe with MacOS paths.. yeah
if [[ -e "${HOME}/Library/Python" ]]; then
  for entry in $(find "${HOME}/Library/Python" -maxdepth 2 -iname 'bin' -type d); do
    add2path "${entry}" "front"
  done
fi

export GOENV_ROOT="$HOME/.goenv"
export NVM_DIR="$HOME/.nvm"

for brew_prefix in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew; do
  if [[ -e "$brew_prefix/bin/brew" ]];then
    eval "$($brew_prefix/bin/brew shellenv)"
  fi
done

add2path "$HOME/.local/bin" front
add2path "$HOME/.tfenv/bin" front
add2path "$HOME/.pyenv/bin" front
add2path "$HOME/.rbenv/bin" front
add2path "$GOENV_ROOT/bin" front
add2path "${KREW_ROOT:-$HOME/.krew}/bin" front

if type pyenv &>/dev/null ;then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if type rbenv &>/dev/null;then
  eval "$(rbenv init - bash)"
fi

# goenv support
if [ -d "$GOENV_ROOT" ];then
  eval "$(goenv init -)"
fi

if [[ -d "$NVM_DIR" ]];then

  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  export NVSHIM_AUTO_INSTALL=1

  source <(npm completion)
fi

add2path /c/opscode/chefdk/bin

###############################################################################

# If we're in the /mnt/c system go home
if [[ "$(pwd)" == '/mnt/c'* ]];then
  cd ~
fi

if [[ -e ~/.cargo/env ]];then
  . ~/.cargo/env
fi

if [[ -e /usr/local/bin/aws_completer ]];then
  complete -C '/usr/local/bin/aws_completer' aws
fi

if [[ -d ~/.local/share/bash-completion ]];then
  for file in $(find ~/.local/share/bash-completion -maxdepth 1 -name '*.sh' -type f -print -quit); do source $file; done
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export BASHRC_LOADED=1



# krew path
