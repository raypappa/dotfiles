# This is the file used by zsh's interactive login. Interacty stuff goes
# here.


zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt 'Assuming %e errors:'
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/${USER}/.zshrc'

autoload -Uz compinit
autoload -U colors
colors
compinit

bindkey '^R' history-incremental-search-backward

_thing1=$'\e]0;'
_thing2=$'\a'

# If we're root, lets be "bright" about it, ha, ha, ha.
_setspacer()
{
  case ${USER} in
    root)
      _spacer='%{%F{red}%}#%{%f%}'
      ;;
    *)
      _spacer="$"
      ;;
  esac
}

# These don't carry through su -; root will need a .zshrc as well.
# But they do carry through su now that I did it right.
autoload -Uz add-zsh-hook

add-zsh-hook precmd _setspacer

export PS1='%{${_thing1}%* %n@%m: ~% ${_thing2}%}[%* %F{green}${STY##*.} %n@%m%f:%F{yellow}%~%f]${_spacer} '

preexec() { printf "${_thing1}%s${_thing2}" "${1}"; }

alias ls="ls --color=auto -a"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias npm-exec='PATH=$(npm bin):$PATH'
alias sso="aws-azure-login -m cli --profile slalom-aws --no-prompt"

[ -s $NVM_DIR/nvm.sh ] && . $NVM_DIR/nvm.sh
[ -s $NVM_DIR/bash_completion ] && . $NVM_DIR/bash_completion
alias gh=gh.exe

# Always respect history && histfile.
export HISTFILE=~/.histfile
export HISTSIZE=65536
export SAVEHIST=9223372036854775807
setopt INC_APPEND_HISTORY HIST_IGNORE_DUPS EXTENDED_HISTORY
alias history="history -i"

ssm() { aws ssm start-session --target "${2}" --profile "${1}" --region us-east-1 }
