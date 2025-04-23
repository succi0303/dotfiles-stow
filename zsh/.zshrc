# Path and locale
export LANG=ja_JP.UTF-8
export PATH=$PATH:/sbin:/usr/sbin

# zplug setup
export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "zplug/zplug", hook-build:"zplug --self-manage"

# zplug plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "plugins/ssh-agent", from:oh-my-zsh

# Install plugins if not present
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load --verbose

# History settings
setopt extended_history hist_fcntl_lock hist_ignore_all_dups hist_ignore_space \
       hist_no_functions hist_no_store hist_reduce_blanks hist_save_no_dups \
       inc_append_history inc_append_history_time share_history
HISTSIZE=2000
SAVEHIST=1000000
HISTFILE=~/.zhistory
DIRSTACKSIZE=20
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-biginning-search-forward-end history-search-end
bindkey '^p' history-beginning-search-backward-end
bindkey '^n' history-biginning-search-forward-end
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# Completion settings
setopt always_to_end auto_list auto_menu complete_in_word glob_complete \
       list_beep list_packed list_types menu_complete
autoload -Uz compinit && compinit
zstyle ':completion:*' format '%B%F{yellow}%d%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both
autoload bashcompinit && bashcompinit

# Directory navigation
setopt auto_cd auto_pushd cdable_vars pushd_ignore_dups pushd_to_home

# Globbing and parameter expansion
setopt brace_ccl hist_subst_pattern magic_equal_subst mark_dirs rc_expand_param

# Input/output behavior
setopt aliases clobber correct correct_all no_flow_control ignore_eof path_dirs

# Job control
setopt auto_continue auto_resume notify

# ZLE and editing
setopt no_beep emacs zle

# cdr (recent directories)
autoload -Uz add-zsh-hook chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-default true

# Colors
autoload -Uz colors && colors
bindkey -e

# Aliases
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ll='ls -l'
alias la='ls -a'
alias lsa='ls -al'
alias emacs='emacs -nw'
alias ls='ls -GwF'

# mise
if [[ "$(uname)" == "Darwin" ]]; then
  eval "$( /opt/homebrew/bin/mise activate zsh )"
else
  eval "$( ~/.local/bin/mise activate zsh )"
fi

# starship
eval "$(starship init zsh)"
