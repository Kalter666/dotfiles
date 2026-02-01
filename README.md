# 🐧 Dotfiles & System Meta-Package

My personal Arch Linux configuration managed via **GNU Stow** and a custom **PKGBUILD meta-package**.

## 🚀 Quick Start (Fresh Install)

Once you have a base Arch Linux installation, run this two-step process to replicate my entire environment:

```bash
git clone [https://github.com/Kalter666/dotfiles.git](https://github.com/Kalter666/dotfiles.git) ~/dotfiles
cd ~/dotfiles
chmod +x bootstrap.sh
./bootstrap.sh
```

What this handles:

1. AUR Helper: Installs paru manually from the AUR.

2. Meta-Package: Builds and installs my-system-meta.

3. Software: Automatically pulls in all CLI tools, GUI apps, and fonts.

4. System Config:

    4.1. Enables the docker daemon and adds your user to the group.

    4.2. Sets rustup to the stable toolchain.

    4.3. Symlinks your .config files using stow.

## 🔄 Daily Maintenance & Syncing

To keep your system and this repository in sync, never install packages directly with paru -S. Instead, treat your PKGBUILD as the "Source of Truth."

1. Adding New Software

    1.1. Edit system-meta/PKGBUILD.

    1.2. Add the package name to the depends array.

    1.3. Save the file.

2. Run the Sync Script
Run the provided sync.sh script. This script automatically increments the version number so Arch knows the package has changed, then triggers paru to install the updates.

```bash
./sync.sh
```

3. Commit Changes
Once your system is updated, push the new list to GitHub:

```bash
git add .
git commit -m "feat: add <package-name> to system meta"
git push
```
