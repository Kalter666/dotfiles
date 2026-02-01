#!/bin/bash

# Navigate to meta-package folder
cd "$(dirname "$0")/system-meta"

# Increment the pkgrel number in the PKGBUILD
sed -i 's/pkgrel=\([0-9]\+\)/echo "pkgrel=$((\1+1))"/e' PKGBUILD

echo "Syncing system with updated PKGBUILD..."

# Use paru to build and install everything
paru -S . --needed

echo "System sync complete. Don't forget to git push your changes!"
