#set -gx $HOME/.local/bin $PATH

set -x LANG ja_JP.UTF-8

set -g fish_color_autosuggestion brblack
set -g fish_color_command green
set -g fish_color_param cyan

alias ll='ls -lAh'
alias ec='emacsclient -t'
alias emacsd='emacs --daemon'
alias emacsd-kill='emacsclient -e "(kill-emacs)"'

# mise
if test (uname) = "Darwin"
    mise activate fish | source
else
    ~/.local/bin/mise activate fish | source
end

# emacs daemon
if set -q SSH_CONNECTION; and not set -q EMACS_DAEMON_STARTED
    set -gx EMACS_DAEMON_STARTED 1
    if not pgrep -u (whoami) emacs > /dev/null
        echo "Starting Emacs daemon for SSH session..."
        nohup emacs --daemon > ~/.emacs.d/daemon.log 2>&1 &
    end
end

