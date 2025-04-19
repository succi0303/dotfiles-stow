#!/bin/bash -e

# install packages

sudo add-apt-repository -y ppa:ubuntuhandbook1/emacs
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
     curl \
     wget \
     git \
     tig \
     stow \
     tmux\
     emacs-nox \
     emacs-common

# mise
curl https://mise.run | sh
mise use --global node@22

# dotfiles

DOTDIR="$( cd "$( dirname "$0" )" && pwd )"
stow -d $OUTDIR -t $HOME bash
stow -d $DOTDIR -t $HOME tmux
stow -d $DOTDIR -t $HOME emacs
stow -d $DOTDIR -t $HOME vim
stow -d $DOTDIR -t $HOME mise

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
