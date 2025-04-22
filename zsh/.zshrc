# zplug
export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "zplug/zplug", hook-build:"zplug --self-manage"

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"

zplug "plugins/ssh-agent", from:oh-my-zsh

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load --verbose

export LANG=ja_JP.UTF-8
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/sbin

# history
#setopt append_history
#setopt bang_hist
setopt extended_history
#setopt hist_allow_clobber
#setopt hist_beep
#setopt hist_expire_dups_first
setopt hist_fcntl_lock
#setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
#setopt hist_lex_words
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
#setopt hist_save_by_copy
setopt hist_save_no_dups
#setopt hist_verify
setopt inc_append_history
setopt inc_append_history_time
setopt share_history
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

# completion
#setopt always_last_prompt
setopt always_to_end
setopt auto_list
setopt auto_menu
#setopt auto_name_dir
#setopt auto_param_keys
#setopt auto_param_slash
#setopt bash_auto_list
#setopt complete_aliases
setopt complete_in_word
setopt glob_complete
#setopt hash_list_all
#setopt list_ambiguous
setopt list_beep
setopt list_packed
#setopt list_rows_first
setopt list_types
setopt menu_complete
#setopt rec_exact
autoload -Uz compinit
compinit
zstyle ':completion:*' format '%B%F{yellow}%d%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# change directory
setopt auto_cd
setopt auto_pushd
setopt cdable_vars
#setopt chase_dots
#setopt chase_links
#setopt posix_cd
setopt pushd_ignore_dups
#setopt pushd_minus
#setopt pushd_silent
setopt pushd_to_home

# glob
#setopt bad_pattern
#setopt bare_glob_qual
setopt brace_ccl
#setopt case_glob
#setopt case_match
#setopt csh_null_glob
#setopt equals
#setopt extended_glob
#setopt force_float
#setopt glob
#setopt glob_assign
#setopt glob_dots
#setopt glob_subst
setopt hist_subst_pattern
#setopt ignore_braces
#setopt ignore_close_braces
#setopt ksh_glob
setopt magic_equal_subst
setopt mark_dirs
#setopt multibyte
#setopt nomatch
#setopt null_glob
#setopt numeric_glob_sort
setopt rc_expand_param
#setopt rematch_pcre
#setopt sh_glob
#setopt unset
#setopt warn_create_global

# initialization
#setopt all_export
#setopt global_export
#setopt global_rcs
#setopt rcs

# input/output
setopt aliases
setopt clobber
setopt correct
setopt correct_all
#setopt dvorak
setopt no_flow_control
setopt ignore_eof
#setopt interactive_comments
#setopt hash_cmds
#setopt hash_dirs
#setopt hash_executables_only
#setopt mail_warning
setopt path_dirs
#setopt path_script
#setopt print_eight_bit
#setopt print_exit_value
#setopt rc_quotes
#setopt rm_star_silent
#setopt rm_star_wait
#setopt short_loops
#setopt sun_keyboard_hack

# job
setopt auto_continue
setopt auto_resume
#setopt bg_nice
#setopt check_jobs
#setopt hup
#setopt long_list_jobs
#setopt monitor
setopt notify

# zle
setopt no_beep
#setopt combining_chars
setopt emacs
#setopt overstrike
#setopt single_line_zle
#setopt vi
setopt zle

# cdr
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-default true

autoload -Uz colors
colors

bindkey -e

# alias
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ll='ls -l'
alias la='ls -a'
alias lsa='ls -al'
alias emacs='emacs -nw'

alias ls='ls -GwF'

# mise
eval "$(~/.local/bin/mise activate zsh)
