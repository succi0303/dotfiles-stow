[[ $- != *i* ]] && return

## ─────────────────────────────────────
## Platform Detection
## ─────────────────────────────────────
OS_TYPE="$(uname -s)"
case "$OS_TYPE" in
    Linux)
        if grep -qi microsoft /proc/version 2>/dev/null; then
            IS_WSL=true
        else
            IS_WSL=false
        fi
        ;;
    Darwin)
        IS_WSL=false
        ;;
    *)
        IS_WSL=false
        ;;
esac

## ─────────────────────────────────────
## History
## ─────────────────────────────────────
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

## ─────────────────────────────────────
## Pager
## ─────────────────────────────────────
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

## ────────────────────────────────────
## Debian Chroot (Ubuntu)
## ─────────────────────────────────────
if [[ -z "${debian_chroot:-}" && -r /etc/debian_chroot ]]; then
    debian_chroot=$(< /etc/debian_chroot)
fi

## ─────────────────────────────────────
## Prompt
## ─────────────────────────────────────
if [[ "$TERM" =~ (xterm|rxvt|.*-256color) ]]; then
    color_prompt=yes
fi

if [[ -n "$force_color_prompt" ]]; then
    if command -v tput &>/dev/null && tput setaf 1 &>/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [[ "$color_prompt" == yes ]]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# xterm title
if [[ "$TERM" =~ ^(xterm|rxvt) ]]; then
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
fi

## ─────────────────────────────────────
## LS Colors / Aliases
## ─────────────────────────────────────
if command -v dircolors &>/dev/null; then
    eval "$(dircolors -b "$HOME/.dircolors" 2>/dev/null || dircolors -b)"
    alias ls='ls --color=auto'
else
    # macOS BSD ls does not support --color
    alias ls='ls -G'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep color
command -v grep &>/dev/null && alias grep='grep --color=auto'
command -v fgrep &>/dev/null && alias fgrep='fgrep --color=auto'
command -v egrep &>/dev/null && alias egrep='egrep --color=auto'

## ─────────────────────────────────────
## Alert for long running commands
## ────────────────────────────────────
if command -v notify-send &>/dev/null; then
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -E '\''s/^\s*[0-9]+\s*//;s/[;&|]\s*alert$//'\'')"'
elif [[ "$OS_TYPE" == "Darwin" ]]; then
    # macOS fallback using AppleScript
    alias alert='osascript -e "display notification \"Command finished\" with title \"Terminal\""'
fi

## ─────────────────────────────────────
## User Aliases
## ─────────────────────────────────────
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

## ─────────────────────────────────────
## Completion
## ─────────────────────────────────────
if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        source /etc/bash_completion
    elif [[ "$OS_TYPE" == "Darwin" && -f /opt/homebrew/etc/bash_completion ]]; then
        source /opt/homebrew/etc/bash_completion
    fi
fi

## ─────────────────────────────────────
## mise (env manager)
## ────────────────────────────────────
if [[ -x "$HOME/.local/bin/mise" ]]; then
    eval "$("$HOME/.local/bin/mise" activate bash)"
fi

## ─────────────────────────────────────
## Emacs Daemon
## ─────────────────────────────────────
# Emacs Daemon auto-start on SSH login
if [[ -n "$SSH_CONNECTION" ]]; then
    if command -v emacs &>/dev/null && [[ ! -S "$HOME/.emacs.d/server/server" ]]; then
        emacs --daemon &>/dev/null
    fi
fi

# Emacs aliases
alias ec='emacsclient -t'
alias emacsd='emacs --daemon'
alias kill-emacsd='emacsclient -e "(kill-emacs)"""'

## ─────────────────────────────────────
## Powerline
## ─────────────────────────────────────
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
    source /usr/share/powerline/bindings/bash/powerline.sh
fi


