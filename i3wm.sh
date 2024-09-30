#!/bin/bash
# Set current directory to a variable
DOTFILES_DIR="$(pwd)"

# Navigate to the dotfiles directory
cd "$DOTFILES_DIR"
sudo apt install zsh rofi --yes


# Add i3 window manager repository and install i3
#curl https://baltocdn.com/i3-window-manager/signing.asc | sudo apt-key add -
#echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild-#ubuntu/ all main" | sudo tee /etc/apt/sources.list.d/i3-#autobuild.list

/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update
sudo apt install alacritty --yes
sudo apt install i3 --yes
sudo apt-get update
sudo apt-get upgrade


# Use stow to manage dotfiles
cd "$DOTFILES_DIR" && stow --adopt zsh && stow --adopt alacritty

# Check and install ASDF if not already installed
if [ ! -d "$HOME/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
else
    echo "ASDF already installed"
fi

# Install Zinit for Zsh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Check and install Powerlevel10k if not already installed
if [ ! -d "$HOME/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    # Use stow to manage Powerlevel10k if needed
    cd "$DOTFILES_DIR" && stow zsh
    echo "Powerlevel10k installed."
else
    echo "Powerlevel10k already installed."
fi

# Inform the user


