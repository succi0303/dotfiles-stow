#set -gx $HOME/.local/bin $PATH

set -x LANG ja_JP.UTF-8

set -g fish_color_autosuggestion brblack
set -g fish_color_command green
set -g fish_color_param cyan

alias ll='ls -lAh'

# mise
if test (uname) = "Darwin"
    mise activate fish | source
else
    ~/.local/bin/mise activate fish | source
end
