# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Update configs
pushd $(dirname $(realpath ~/.bashrc)) && git pull --rebase; popd

. /usr/share/bash-completion/completions/git

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
      echo -en " (\e[03;35m${branch}\e[00m)"
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

# https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
# https://i.stack.imgur.com/9UVnC.png
# Font  Effects
# Code      Effect     Note
# 0         Reset / Normal     all attributes off
# 1         Bold or increased intensity
# 2         Faint (decreased intensity)     Not widely supported.
# 3         Italic     Not widely supported. Sometimes treated as inverse.
# 4         Underline
# 5         Slow Blink     less than 150 per minute
# 6         Rapid Blink     MS-DOS ANSI.SYS; 150+ per minute; not widely supported
# 7         [[reverse video]]     swap foreground and background colors
# 8         Conceal     Not widely supported.
# 9         Crossed-out     Characters legible, but marked for deletion. Not widely supported.
# 10        Primary(default) font
# 11–19     Alternate font     Select alternate font n-10
# 20        Fraktur     hardly ever supported
# 21        Bold off or Double Underline     Bold off not widely supported; double underline hardly ever supported.
# 22        Normal color or intensity     Neither bold nor faint
# 23        Not italic, not Fraktur
# 24        Underline off     Not singly or doubly underlined
# 25        Blink off
# 27        Inverse off
# 28        Reveal     conceal off
# 29        Not crossed out
# 30–37     Set foreground color     See color table below
# 38        Set foreground color     Next arguments are 5;<n> or 2;<r>;<g>;<b>, see below
# 39        Default foreground color     implementation defined (according to standard)
# 40–47     Set background color     See color table below
# 48        Set background color     Next arguments are 5;<n> or 2;<r>;<g>;<b>, see below
# 49        Default background color     implementation defined (according to standard)
# 51        Framed
# 52        Encircled
# 53        Overlined
# 54        Not framed or encircled
# 55        Not overlined
# 60        ideogram underline     hardly ever supported
# 61        ideogram double underline     hardly ever supported
# 62        ideogram overline     hardly ever supported
# 63        ideogram double overline     hardly ever supported
# 64        ideogram stress marking     hardly ever supported
# 65        ideogram attributes off     reset the effects of all of 60-64
# 90–97     Set bright foreground color     aixterm (not in standard)
# 100–107   Set bright background color     aixterm (not in standard)

if [ "$color_prompt" = yes ]; then
  # Set title to `\u@\h:\w $(get_git_branch nc)` which produces username@host:workingdir (branch)
  # prompt will be stoney@platypus (main):workingdir (newline)$
  # the git branch is purple, the directory is blue
  PS1='[\e]0;]\u@\h:\w $(get_git_branch nc)\a${debian_chroot:+($debian_chroot)}\[[\e[01;32m]\u@\h\e[0m$(get_git_branch)\e[10;34m:\w\]\e[0m\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
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

if [[ -e /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi;

# Be safe with MacOS paths.. yeah
if [[ -e "${HOME}/Library/Python" ]]; then
  for entry in $(find "${HOME}/Library/Python" -maxdepth 2 -iname 'bin' -type d); do
    export PATH="${entry}:${PATH}"
  done
fi
if [[ -e "$HOME/.local/bin" ]];then
  export PATH=~/.local/bin:$PATH
fi
if [[ -e "$HOME/go/bin" ]];then
  export PATH=~/go/bin:${PATH}
fi

export NVM_DIR=~/.nvm
if [[ -e "$HOME/.tfenv/bin" ]];then
  export PATH=~/.tfenv/bin:$PATH
fi
if [[ -e "$HOME/.pyenv/bin" ]];then
  export PATH=~/.pyenv/bin:$PATH
fi
if [[ -e "$HOME/.pyenv/shims" ]];then
  export PATH=~/.pyenv/shims:$PATH
fi
if [[ -e "$HOME/.rbenv/bin" ]];then
  export PATH=~/.rbenv/bin:$PATH
fi

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init - bash)"
eval "$(pyenv virtualenv-init -)"

[ -s $NVM_DIR/nvm.sh ] && . $NVM_DIR/nvm.sh  # This loads nvm
[ -s $NVM_DIR/bash_completion ] && . $NVM_DIR/bash_completion  # This loads nvm bash_completion
source <(npm completion)

if [[ -e /c/opscode/chefdk/bin ]];then
  export PATH=/c/opscode/chefdk/bin:$PATH
fi

###############################################################################

# If we're in the /mnt/c system go home
if [[ "$(pwd)" == '/mnt/c'* ]];then
  cd ~
fi

if [[ -e ~/.cargo/env ]];then
  . ~/.cargo/env
fi

if [[ "$WSL_DISTRO_NAME" == "Ubuntu" || "$WSL_DISTRO_NAME" == "Debian" ]] && [[ "$NO_WSL_DOCKER" != "true" ]];then
  DOCKER_DISTRO="$WSL_DISTRO_NAME"
  DOCKER_DIR=/mnt/wsl/shared-docker
  DOCKER_SOCK="$DOCKER_DIR/docker.sock"
  export DOCKER_HOST="unix://$DOCKER_SOCK"
  if [ ! -d "$DOCKER_DIR" ]; then
    mkdir -pm o=,ug=rwx "$DOCKER_DIR"
    sudo chgrp docker "$DOCKER_DIR"
  fi
  if [ ! -S "$DOCKER_SOCK" ]; then
    /mnt/c/Windows/System32/wsl.exe -d $DOCKER_DISTRO sh -c "nohup sudo -b dockerd < /dev/null > $DOCKER_DIR/dockerd.log 2>&1"
  fi
fi

if [[ -e /usr/local/bin/aws_completer ]];then
  complete -C '/usr/local/bin/aws_completer' aws
fi

if [[ -e  ~/.local/src/alacritty.bash ]];then
  . ~/.local/src/alacritty.bash
fi

if [[ -e ~/.local/share/bash-completion/task.bash ]];then
  . ~/.local/share/bash-completion/task.bash
fi

cdnvm() {
    command cd "$@" || return $?
    nvm_path=$(nvm_find_up .nvmrc | tr -d '\n')

    # If there are no .nvmrc file, use the default nvm version
    if [[ ! $nvm_path = *[^[:space:]]* ]]; then

        declare default_version;
        default_version=$(nvm version default);

        # If there is no default version, set it to `node`
        # This will use the latest version on your machine
        if [[ $default_version == "N/A" ]]; then
            nvm alias default node;
            default_version=$(nvm version default);
        fi

        # If the current version is not the default version, set it to use the default version
        if [[ $(nvm current) != "$default_version" ]]; then
            nvm use default;
        fi

    elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
        declare nvm_version
        nvm_version=$(<"$nvm_path"/.nvmrc)

        declare locally_resolved_nvm_version
        # `nvm ls` will check all locally-available versions
        # If there are multiple matching versions, take the latest one
        # Remove the `->` and `*` characters and spaces
        # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
        locally_resolved_nvm_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')

        # If it is not already installed, install it
        # `nvm install` will implicitly use the newly-installed version
        if [[ "$locally_resolved_nvm_version" == "N/A" ]]; then
            nvm install "$nvm_version";
        elif [[ $(nvm current) != "$locally_resolved_nvm_version" ]]; then
            nvm use "$nvm_version";
        fi
    fi
}

# be horrified!!
alias cd='cdnvm'
cdnvm "$PWD" || exit

export BASHRC_LOADED=1
