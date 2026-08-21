#!/bin/bash

set -e

echo "Cloning and building paru..."

sudo pacman -S --needed base-devel git

TEMP_DIR=$(mktemp -d)

cleanup() {
    echo "Cleaning up..."
    rm -rf "$TEMP_DIR"
}

trap cleanup EXIT

git clone https://aur.archlinux.org/paru.git "$TEMP_DIR"
cd "$TEMP_DIR"
makepkg -si --noconfirm

echo "paru installed. Now syncing your meta-package..."

cd ~/dotfiles/system-meta
paru -S . --needed

echo "Applying per-user setup..."

sudo usermod -aG docker "$USER"
echo ">> $USER added to docker group."

if command -v rustup > /dev/null; then
    rustup default stable
    echo ">> Rustup set to stable."
fi

cd ~/dotfiles
stow .
echo ">> Dotfiles symlinked with stow."

echo "NOTE: Log out and back in for the docker group change to take effect."
