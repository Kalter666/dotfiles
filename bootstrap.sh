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
