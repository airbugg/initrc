#!/usr/bin/env bash

# Function to install Fish on Ubuntu
install_fish_ubuntu() {
    echo "Installing Fish on Ubuntu..."
    sudo apt-add-repository ppa:fish-shell/release-3 -y
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install fish -y
    chsh -s $(which fish) $USER
}

# Function to install Fish on MacOS
install_fish_macos() {
    echo "Installing Fish on MacOS..."
    brew install fish
    sudo chsh -s $(which fish)
}

post_install() {
    mkdir -p ~/.local/bin

    echo -e "# Add ~/.local/bin to the PATH.\nset -U fish_user_paths \$HOME/.local/bin $fish_user_paths\n" >>~/.config/fish/config.fish

    echo "Fish installed successfully."
    echo "Please restart your terminal to use Fish as the default shell."
}

# Check if Fish is installed
if ! command -v fish &>/dev/null; then
    echo "Fish is not installed. Installing..."

    # Detect the Operating System
    OS="$(uname -s)"
    case "$OS" in
    Linux*)
        # Assuming Ubuntu or similar
        install_fish_ubuntu
        ;;
    Darwin*)
        # MacOS
        install_fish_macos
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
    esac

    post_install
else
    echo "Fish is already installed."
fi
