#!/bin/bash -e

# install packages

sudo add-apt-repository -y ppa:ubuntuhandbook1/emacs
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
     git \
     tig \
     stow \
     tmux\
     emacs-nox \
     emacs-common

# dotfiles

DOTDIR="$( cd "$( dirname "$0" )" && pwd )"
stow -d $DOTDIR -t $HOME tmux
stow -d $DOTDIR -t $HOME emacs
stow -d $DOTDIR -t $HOME vim
