#!/usr/bin/env bash
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TPM_DIR="$HOME/.tmux/plugins/tpm"
VIM_PLUG_PATH="$HOME/.vim/autoload/plug.vim"

function info() {
    echo -e "\033[1;32m[INFO]\033[0m $1"
}

function is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

function is_ubuntu() {
    [[ -f /etc/lsb-release ]] && grep -qi ubuntu /etc/lsb-release
}

function detect_mise_bin() {
    if is_macos; then
        echo "/opt/homebrew/bin/mise"
    elif is_ubuntu; then
        echo "$HOME/.local/bin/mise"
    else
        echo "[ERROR] Unsupported OS for mise installation" >&2
        exit 1
    fi
}

MISE_BIN="$(detect_mise_bin)"

function install_packages_linux() {
    info "Installing packages via apt..."
    sudo add-apt-repository -y ppa:ubuntuhandbook1/emacs
    sudo apt update
    sudo apt upgrade -y

    sudo apt install -y \
        gpg cmake libtool-bin gpg-agent sudo curl wget git tig \
        stow tmux powerline nano vim vim-gui-common vim-runtime

    sudo apt install -y --no-install-recommends \
        emacs-nox emacs-common
}

function install_packages_macos() {
    if ! command -v brew >/dev/null 2>&1; then
        info "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    info "Installing packages via Brewfile..."
    brew bundle --file="$DOTDIR/.Brewfile"
}

function stow_dotfiles() {
    local dirs=(tmux powerline emacs vim mise)
    for dir in "${dirs[@]}"; do
        info "Stowing $dir..."
        stow -d "$DOTDIR" -t "$HOME" "$dir"
    done
}

function install_tpm() {
    if [ ! -d "$TPM_DIR" ]; then
        info "Installing tmux plugin manager (tpm)..."
        git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    else
        info "tmux plugin manager (tpm) is already installed."
    fi
}

function install_mise() {
    if [ ! -x "$MISE_BIN" ]; then
        info "Installing mise..."
        curl https://mise.run | sh
    else
        info "mise is already installed."
    fi

    eval "$("$MISE_BIN" activate)"
    "$MISE_BIN" trust
    "$MISE_BIN" install
}

function install_vim_plug() {
    if [ ! -f "$VIM_PLUG_PATH" ]; then
        info "Installing vim-plug..."
        curl -fLo "$VIM_PLUG_PATH" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        info "vim-plug is already installed."
    fi
}

# ---- Main ----

if is_macos; then
    install_packages_macos
elif is_ubuntu; then
    install_packages_linux
else
    echo "[ERROR] Unsupported OS"
    exit 1
fi

stow_dotfiles
install_tpm
install_mise
install_vim_plug

info "Installation completed successfully."
