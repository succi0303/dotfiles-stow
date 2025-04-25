
#!/bin/bash -e

# install packages

sudo add-apt-repository -y ppa:ubuntuhandbook1/emacs
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
     gpg \
     cmake \
     libtool-bin \
     gpg-agent \
     sudo \
     curl \
     wget \
     git \
     tig \
     stow \
     tmux \
     powerline \
     nano \
     vim \
     vim-gui-common \
     vim-runtime

sudo apt install -y --no-install-recommends \
     emacs-nox \
     emacs-common

# dotfiles

DOTDIR="$( cd "$( dirname "$0" )" && pwd )"
stow -d $DOTDIR -t $HOME tmux
sotw -d $DOTDIR -t $HOME poweline
stow -d $DOTDIR -t $HOME emacs
stow -d $DOTDIR -t $HOME vim
stow -d $DOTDIR -t $HOME mise

# tmux
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing tmux plugin manager (tpm)..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "tmux plugin manager (tpm) is already installed."
fi

# mise
curl https://mise.run | sh
eval "$(~/.local/bin/mise activate)"
mise trust
mise install

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
